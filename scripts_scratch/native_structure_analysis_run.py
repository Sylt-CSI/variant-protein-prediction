import argparse
import os
import subprocess


class NativeStructureAnalysis:

    def __init__(self):
        self._load_cluster_modules()
        ddg_args = self._ddg_run_arguments()
        self._execute_rosetta_ddg_monomer(ddg_args.rdb[0], ddg_args.ddgpdb[0], ddg_args.ddgmut[0], ddg_args.ddgiter[0],
                                          ddg_args.out[0])

        self._execute_psi_blast(ddg_args.PSIscript[0],
                                ddg_args.PSIthr[0],
                                ddg_args.PSIfa[0],
                                ddg_args.PSIdb[0],
                                ddg_args.out[0])

    @staticmethod
    def _load_cluster_modules():
        subprocess.call(
            [
                'module purge\n',
                'module load Python/2.7.11-foss-2015b\n',
                'module load libffi/3.2.1-foss-2015b\n',
                'module load foss/2015b\n',
                'module load libtool/2.4.6-GNU-4.9.3-2.25\n',
                'module load zlib/1.2.11-foss-2015b\n'
            ])

    @staticmethod
    def _ddg_run_arguments():
        native_structure_analyses_arguments = argparse.ArgumentParser()

        native_structure_analyses_arguments.add_argument("-rdb",
                                                         type=str,
                                                         help="Specify the path to the full Rosetta database for the ddg monomer application.",
                                                         required=False,
                                                         default=[
                                                             "/groups/umcg-gcc/tmp03/umcg-sschuurmans/source_code_tools/rosetta_src_2018.33.60351_bundle/main/database"],
                                                         nargs=1,
                                                         dest="rdb")

        native_structure_analyses_arguments.add_argument("-ddgpdb",
                                                         type=str,
                                                         help="The original pdb structure.",
                                                         required=True,
                                                         nargs=1,
                                                         dest="ddgpdb")

        native_structure_analyses_arguments.add_argument("-ddgmut",
                                                         type=str,
                                                         help="Mutation file that contains the mutations for the PDB file to be calculated by ddg monomer.",
                                                         required=True,
                                                         nargs=1,
                                                         dest="ddgmut")

        native_structure_analyses_arguments.add_argument("-ddgiter",
                                                         type=int,
                                                         nargs=1,
                                                         required=False,
                                                         default=[50],
                                                         help="Number of iterations that ddg_monomer should run on a single protein",
                                                         dest="ddgiter")

        native_structure_analyses_arguments.add_argument("-PSIfa",
                                                         type=str,
                                                         help="Give the full path to the fasta file that is being used by psiblast",
                                                         nargs=1,
                                                         required=True,
                                                         dest="PSIfa")

        native_structure_analyses_arguments.add_argument("-PSIdb",
                                                         type=str,
                                                         help="Give the full path of the protein database (nr) to PSIblast. (it is a different one than used by Rosetta.)",
                                                         nargs=1,
                                                         required=False,
                                                         default=[
                                                             "/groups/umcg-gcc/tmp03/umcg-sschuurmans/db/full_nr/nr_db_out"],
                                                         dest="PSIdb")

        native_structure_analyses_arguments.add_argument("-PSIscript",
                                                         type=str,
                                                         help="directory for execution script for psiblast",
                                                         nargs=1,
                                                         required=False,
                                                         default=[
                                                             "/groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/psi_blast_run.sh"],
                                                         dest="PSIscript")

        native_structure_analyses_arguments.add_argument("-PSIthr",
                                                         type=int,
                                                         help="Number of CPU cores used by PSIblast, the more you use the faster is goes, until some point is reached...",
                                                         nargs=1,
                                                         required=False,
                                                         default=[8],
                                                         dest="PSIthr")

        native_structure_analyses_arguments.add_argument("-out",
                                                         type=str,
                                                         help="Output folder for produced files, end with a /, the rest will be sticked to it.",
                                                         nargs=1,
                                                         required=False,
                                                         dest="out")

        return native_structure_analyses_arguments.parse_args()

    @staticmethod
    def _pdb_renumber(ddg_protein):
        """
        Execute the renumbering script for ddg monomer
        :param ddg_protein: The protein that needs to be renumbered.
        """
        subprocess.call(["python",
                         "/groups/umcg-gcc/tmp03/umcg-sschuurmans/source_code_tools/rosetta_src_2018.33.60351_bundle/tools/protein_tools/scripts/pdb_renumber.py",
                         "{}".format(ddg_protein),  # Input pdb file that needs to be renumbered
                         "{}".format("renumbered_" + ddg_protein)])  # Name of the new file that has the new pdb order.

    def _execute_rosetta_ddg_monomer(self, rosetta_database, ddg_protein, ddg_mutation_file, ddg_iter, ouput_folder):
        # Ddg monomer is not very cooperative with it's output, so it is just forced to execute from the directory itself.
        os.chdir(ouput_folder)
        self._pdb_renumber(ddg_protein)
        subprocess.Popen(
            [
                "/groups/umcg-gcc/tmp03/umcg-sschuurmans/source_code_tools/rosetta_src_2018.33.60351_bundle/main/source/bin/ddg_monomer",
                '-database', '{}'.format(rosetta_database),
                '-in:file:s', 'renumbered_{}'.format(ddg_protein),
                # /groups/umcg-gcc/tmp03/umcg-sschuurmans/github-archive/example_input/2C35_VIPUR/2C35_renumbered.pdb
                '-ddg::mut_file', "{}".format(ddg_mutation_file),
                # '/groups/umcg-gcc/tmp03/umcg-sschuurmans/github-archive/example_input/2C35_VIPUR/2C35.txt',
                '-ddg::output_silent', 'false',
                '-ddg::dump_pdbs', 'false',
                '-ddg::output_silent', 'false',
                '-ddg::suppress_checkpointing', 'true',
                '-ddg::iterations', "{}".format(ddg_iter),
                '-ddg::weight_file', 'soft_rep_design',
                '-ddg::local_opt_only', 'true',
                '-ddg::min_cst', 'false',
                '-ddg::mean', 'true',
                '-ddg::min', 'false',
                '-ddg::sc_min_only', 'false',
                '-ddg::ramp_repulsive', 'false',
                '-ddg::opt_radius', '8.0',
                '-ddg::debug_output', 'false',
                '-linmem_ig', '10',
                '-ignore_zero_occupancy', 'false',
                '-run:ignore_zero_occupancy', 'false',
                '-run:constant_seed',
                '-run:jran', '17']
        )

    @staticmethod
    def _execute_psi_blast(psi_blast_run, threads, query_fasta_name, psi_database, output_folder):
        """
        Execute psi blast as slurm job.
        """

        ddg_protein_name = query_fasta_name.split("/")[-1].split(".")[0]

        subprocess.call(
            ["sbatch", psi_blast_run, threads, query_fasta_name, psi_database, ddg_protein_name, output_folder])


if __name__ == "__main__":
    NativeStructureAnalysis()
