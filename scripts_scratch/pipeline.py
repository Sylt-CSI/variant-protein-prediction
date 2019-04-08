#! bin/bash/env python3

import argparse
import subprocess
import time
import threading
import glob


class ProteinFeatureGeneratorPipeline:

    def __init__(self):
        # self._load_cluster_modules()
        protein_pipeline_arguments = self._protein_feature_pipeline_argument_parser()
        # threading.Thread(self._rosetta_relax_progress_monitoring(protein_pipeline_arguments.rrnstruct[0]))
        # print(protein_pipeline_arguments)
        self._execute_rosetta_relax(
            protein_pipeline_arguments.script[0],
            protein_pipeline_arguments.out[0],
            protein_pipeline_arguments.seed[0],
            protein_pipeline_arguments.nstruct[0],
            protein_pipeline_arguments.pdb[0],
            protein_pipeline_arguments.rdb[0]
        )

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

        protein_feature_pipeline_arguments.add_argument("-nstruct",
                                                        type=int,
                                                        default=[5],
                                                        help="Amount of structures made by rosetta relax, more is better but 50 is default.",
                                                        nargs=1,
                                                        required=False,
                                                        dest="nstruct")

        protein_feature_pipeline_arguments.add_argument("-pdb",
                                                        type=str,
                                                        help="The pdb structure that must be relaxed and for which the properties must be acquired",
                                                        nargs=1,
                                                        required=True,
                                                        dest="pdb")

        protein_feature_pipeline_arguments.add_argument("-rscri",
                                                        type=str,
                                                        default=[
                                                            "/groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/rosetta_relax.sh"],
                                                        help="The path to the rosetta relax script.",
                                                        required=False,
                                                        nargs=1,
                                                        dest="script")

        protein_feature_pipeline_arguments.add_argument("-out",
                                                        type=str,
                                                        help="The output name and folder",
                                                        nargs=1,
                                                        required=True,
                                                        dest="out")

        protein_feature_pipeline_arguments.add_argument("-seed",
                                                        type=int,
                                                        help="Seed number",
                                                        nargs=1,
                                                        default=[17],
                                                        required=False,
                                                        dest="seed")

        return protein_feature_pipeline_arguments.parse_args()

    @staticmethod
    def _load_cluster_modules():
        subprocess.call(
            [
                'module purge\n',
                # 'module load  BLAST+/2.7.1-foss-2015b\n',
                'module load Python/2.7.11-foss-2015b\n',
                # 'module load libffi/3.2.1-foss-2015b\n',
                # 'module load foss/2015b\n',
                # 'module load libtool/2.4.6-GNU-4.9.3-2.25\n',
                # 'module load zlib/1.2.11-foss-2015b\n'
            ])

    def _execute_rosetta_rescore(self):
        pass

    def _rosetta_relax_progress_monitoring(self, required_structures_to_start):
        while required_structures_to_start < len(glob.glob("/*.pdb")):
            time.sleep(10)
        self._execute_probe()

    def _execute_rosetta_relax(self, script, out_folder, seed, nstruct, pdb, database):
        protein_name = pdb.rsplit("/", 1)[-1][:-4]
        score_file = out_folder + protein_name + ".sc"
        subprocess.call(["sbatch", script, out_folder, str(seed), score_file, pdb, database, str(nstruct)])

    def _execute_probe(self):
        """
        Execute probe locally since it runs relative fast.
        """
        subprocess.Popen(
            ["/groups/umcg-gcc/tmp03/umcg-sschuurmans/source_code_tools/probe.2.16.130520.linuxi386",
             "-Q",  # quiet mode
             "{}"  # residue position, not very well mentioned in the doc. all is the whole molecule.
             "-rad1.4",  # radius of the rolling sphere used for marking contact dots and spikes.
             "-C",  # count produced dots
             "-out {}".format("kaas")]  #
        )


if __name__ == "__main__":
    ProteinFeatureGeneratorPipeline()
