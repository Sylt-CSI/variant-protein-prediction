#! bin/bash/env python3

import argparse
import subprocess
import time
import glob
import os.path


class RosettaBackRubRelaxDockPipeline:

    def __init__(self):
        # Initiate command line options.
        protein_arguments = self._protein_feature_pipeline_argument_parser()
        self._dry_run = protein_arguments.dry
        checked_output_folder_name = self._add_backslash_to_folder_if_missing(protein_arguments.out[0])
        # print(protein_arguments.backrub_script[0],
        #         protein_arguments.rdb[0],
        #         protein_arguments.pdb[0],
        #         checked_output_folder_name)
        if not os.path.isfile(checked_output_folder_name + "backrub/score_back_rub.sc"):
            print(
                "Submitted Rosetta Backrub job for {}.".format(
                    protein_arguments.pdb[0].split("/")[-1].split(".")[0]))
            self._submit_rosetta_slurm_job(
                protein_arguments.backrub_script[0],
                protein_arguments.rdb[0],
                protein_arguments.pdb[0],
                checked_output_folder_name
            )
            # Monitor the outcome of backrub.
            outcome = self._rosetta_pipeline_monitoring(1000, checked_output_folder_name + "backrub/", "regular_backrub")
            if outcome == "Failed" and protein_arguments.ignore is False:
                return
        else:
            print("Backrub is already finished, continuing with relax.")
        # # Filter the lowest energy scoring backrub pdb.
        lowest_scoring_backrub_protein_model = self._get_lowest_energy_structure_name(
            checked_output_folder_name + "backrub/score_back_rub.sc")
        print(
            protein_arguments.relax_script[0],
            protein_arguments.rdb[0],
            checked_output_folder_name + "backrub/" + str(lowest_scoring_backrub_protein_model) + ".pdb",
            checked_output_folder_name
        )
        if not os.path.isfile(checked_output_folder_name + "relax/score_relax.sc"):
            print("Submitted Rosetta Relax job for {}.".format(lowest_scoring_backrub_protein_model))
            self._submit_rosetta_slurm_job(
                protein_arguments.relax_script[0],
                protein_arguments.rdb[0],
                checked_output_folder_name + "backrub/" + str(lowest_scoring_backrub_protein_model) + ".pdb",
                checked_output_folder_name
            )
            # Monitor the outcome of relax.
            outcome = self._rosetta_pipeline_monitoring(64, checked_output_folder_name + "relax/", "regular_relax")
            if outcome == "Failed" and protein_arguments.ignore is False:
                return
        else:
            print("Relax is already finished.")
        # # Filter the lowest energy scoring relax pdb.
        # lowest_scoring_relax_protein_model = self._get_lowest_energy_structure_name(
        #     checked_output_folder_name + "relax/score_relax.sc")
        #
        # self._submit_rosetta_slurm_job(
        #     protein_arguments.docking_script[0],
        #     protein_arguments.rdb[0],  # This option is not used.
        #     checked_output_folder_name + "relax/" + str(
        #         lowest_scoring_relax_protein_model) + ".pdb",
        #     checked_output_folder_name
        # )
        # # Monitor the outcome of docking.
        # outcome = self._rosetta_pipeline_monitoring(136, checked_output_folder_name + "local_docking/",
        #                                             "regular_docking")
        # if outcome == "Failed" and protein_arguments.ignore is False:
        #     return
        print("Finished run.")

    @staticmethod
    def _protein_feature_pipeline_argument_parser():
        protein_feature_pipeline_arguments = argparse.ArgumentParser()
        protein_feature_pipeline_arguments.add_argument("-rdb",
                                                        type=str,
                                                        help="Specify the path to the full Rosetta database for the ddg monomer application.",
                                                        required=False,
                                                        default=[
                                                            "/groups/umcg-gcc/tmp03/umcg-sschuurmans/source_code_tools/rosetta_src_2018.33.60351_bundle/main/database"],
                                                        nargs=1,
                                                        dest="rdb")

        protein_feature_pipeline_arguments.add_argument("-pdb",
                                                        type=str,
                                                        help="The pdb structure that will be backrubed, relaxed and docked, must contain lignand and protein",
                                                        nargs=1,
                                                        required=True,
                                                        dest="pdb")

        protein_feature_pipeline_arguments.add_argument("-bscri",
                                                        type=str,
                                                        default=[
                                                            "/groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/backrub_run.sh"],
                                                        help="The rosetta backrub script in full path of where it is stored.",
                                                        required=False,
                                                        nargs=1,
                                                        dest="backrub_script")

        protein_feature_pipeline_arguments.add_argument("-rscri",
                                                        type=str,
                                                        default=[
                                                            "/groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/rosetta_relax.sh"],
                                                        help="The rosetta relax script in full path of where it is stored.",
                                                        required=False,
                                                        nargs=1,
                                                        dest="relax_script")

        protein_feature_pipeline_arguments.add_argument("-dscri",
                                                        type=str,
                                                        default=[
                                                            "/groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/run_local_docking.sh"],
                                                        help="The rosetta docking script in full path of where it is stored.",
                                                        required=False,
                                                        nargs=1,
                                                        dest="docking_script")

        protein_feature_pipeline_arguments.add_argument("-out",
                                                        type=str,
                                                        help="The name of the folder where the subfolders for the results of backrub, relax and docking are made and stored.",
                                                        nargs=1,
                                                        required=True,
                                                        dest="out")

        protein_feature_pipeline_arguments.add_argument("-ignore",
                                                        action='store_const',
                                                        default=not (True),
                                                        const=True,
                                                        required=False,
                                                        dest="ignore")

        protein_feature_pipeline_arguments.add_argument("-dry",
                                                        action='store_const',
                                                        default=not (True),
                                                        const=True,
                                                        required=False,
                                                        dest="dry")

        # OPTION that can be activated in the future, if multiple runs are possible on the cluster, that are not ran as leftovers.
        # protein_feature_pipeline_arguments.add_argument("-seed",
        #                                                 type=int,
        #                                                 help="Seed number",
        #                                                 nargs=1,
        #                                                 default=[17],
        #                                                 required=False,
        #                                                 dest="seed")

        return protein_feature_pipeline_arguments.parse_args()

    @staticmethod
    def _rosetta_pipeline_monitoring(minimum_amount_of_structures_to_finish, stored_structures_directory, job_name):
        # Keep repeating the test until the job is finished.
        while len([queue_element for queue_element in
                   subprocess.check_output(['squeue', '--Format=state,name', '-h', '-n', '{}'.format(job_name)]).strip(
                       "\n").split(" ") if len(queue_element) > 0]) != 0:
            print("Waiting 10 seconds, running \"{}\" finished {} out of {}.".format(job_name, len(
                glob.glob(stored_structures_directory + "*[0-9].pdb")), minimum_amount_of_structures_to_finish))
            time.sleep(10)
        if minimum_amount_of_structures_to_finish > len(glob.glob(stored_structures_directory + "*.pdb")):
            print("Panic! Not enough structures have been made, {} out of the {} requested.".format(
                len(glob.glob(stored_structures_directory + "*[0-9].pdb")), minimum_amount_of_structures_to_finish))
            status = "Failure"
        else:
            print("Succes! {} have been made.".format(minimum_amount_of_structures_to_finish))
            status = "Success"
        return status

    @staticmethod
    def _get_lowest_energy_structure_name(score_file):
        lowest_energy_pdb = [float("inf"), ""]
        with open(score_file, "r") as rosetta_score_file:
            # Skip first line, it contains only SEQUENCE:
            rosetta_score_file.readline()
            # Skip header line.
            rosetta_score_file.readline()
            for line in rosetta_score_file:
                line = [score_table_element for score_table_element in line.strip("\n").split(" ") if
                        len(score_table_element)]
                if float(lowest_energy_pdb[0]) > float(line[1]):
                    lowest_energy_pdb = [float(line[1]), line[-1]]
                else:
                    pass
        print("Lowest rosetta score is {} for model {}".format(lowest_energy_pdb[0], lowest_energy_pdb[1]))
        return lowest_energy_pdb[1]

    @staticmethod
    def _add_backslash_to_folder_if_missing(output_folder):
        if not output_folder.endswith("/"):
            folder_name = output_folder + "/"
        else:
            folder_name = output_folder
        return folder_name

    def _submit_rosetta_slurm_job(self,script, database, pdb, out_folder):
        if self._dry_run:
            print(" ".join(["DRY RUN:","sbatch", script, database, pdb, out_folder]))
        else:
            subprocess.call(["sbatch", script, database, pdb, out_folder])


if __name__ == "__main__":
    RosettaBackRubRelaxDockPipeline()
