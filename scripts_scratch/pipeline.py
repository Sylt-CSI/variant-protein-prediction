#! bin/bash/env python3

import argparse
import subprocess


class ProteinFeatureGeneratorPipeline:

    def __init__(self):
        self._load_cluster_modules()
        protein_pipeline_arguments = self._protein_feature_pipeline_argument_parser()
        self._execute_rosetta_ddg_monomer(protein_pipeline_arguments.ddgpdb)

    @staticmethod
    def _protein_feature_pipeline_argument_parser():
        protein_feature_pipeline_arguments = argparse.ArgumentParser()
        protein_feature_pipeline_arguments.add_argument("-rdb",
                                                        type=str,
                                                        help="Specify the path to the full Rosetta database for the ddg monomer application.",
                                                        required=True,
                                                        nargs=1,
                                                        dest="rdb")

        protein_feature_pipeline_arguments.add_argument("-ddgpdb",
                                                        type=str,
                                                        help="The original pdb structure.",
                                                        required=True,
                                                        nargs=1,
                                                        dest="ddgpdb")

        protein_feature_pipeline_arguments.add_argument("-ddgmut",
                                                        type=str,
                                                        help="Mutation file that contains the mutations for the PDB file to be calculated by ddg monomer.",
                                                        required=True,
                                                        nargs=1,
                                                        dest="ddgmut")

        protein_feature_pipeline_arguments.add_argument("-rrnstruct",
                                                        type=int,
                                                        default=50,
                                                        help="Amount of structures made by rosetta relax, more is better but 50 is default.",
                                                        nargs=1,
                                                        required=False,
                                                        dest="-rrnstruct")

        protein_feature_pipeline_arguments.add_argument("-PSIdb",
                                                        type=str,
                                                        help="Give the full path of the protein database (nr) to PSIblast. (it is a different one than used by Rosetta.)",
                                                        nargs=1,
                                                        required=False,
                                                        default="/groups/umcg-gcc/tmp03/umcg-sschuurmans/db/nr",
                                                        dest="PSIdb")

        return protein_feature_pipeline_arguments.parse_args()

    @staticmethod
    def _load_cluster_modules():
        subprocess.call(
            ['module purge\n',
             'module load  BLAST+/2.7.1-foss-2015b\n',
             'module load Python/2.7.11-foss-2015b\n',
             'module load libffi/3.2.1-foss-2015b\n',
             'module load foss/2015b\n',
             'module load libtool/2.4.6-GNU-4.9.3-2.25\n',
             'module load zlib/1.2.11-foss-2015b\n'])

    def _execute_rosetta_ddg_monomer(self, ddg_protein):
        self._pdb_renumber(ddg_protein)
        subprocess.Popen(
            [
                "/groups/umcg-gcc/tmp03/umcg-sschuurmans/source_code_tools/rosetta_src_2018.33.60351_bundle/main/source/bin/ddg_monomer",
                '-database', '{}',
                '-in:file:s', 'renumbered_{}'.format(ddg_protein),  # /groups/umcg-gcc/tmp03/umcg-sschuurmans/github-archive/example_input/2C35_VIPUR/2C35_renumbered.pdb
                '-ddg::mut_file',  # '/groups/umcg-gcc/tmp03/umcg-sschuurmans/github-archive/example_input/2C35_VIPUR/2C35.txt',
                '-ddg::output_silent', 'false',
                '-ddg::dump_pdbs', 'false',
                '-ddg::output_silent', 'false',
                '-ddg::suppress_checkpointing', 'true',
                '-ddg::iterations', '50',
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

    def _execute_rosetta_rescore(self):
        pass

    def _pdb_renumber(self, ddg_protein):
        subprocess.call(["python",
                         "/groups/umcg-gcc/tmp03/umcg-sschuurmans/source_code_tools/rosetta_src_2018.33.60351_bundle/tools/protein_tools/scripts/pdb_renumber.py",
                         "{}".format(ddg_protein),  # Input pdb file that needs to be renumbered
                         "{}".format("renumbered_"+ddg_protein)])  # Name of the new file that has the new pdb order.

    def _renumbered_pdb_name_generator(self):
        pass

    def _execute_rosetta_relax(self):
        pass

    def _execute_probe(self):
        subprocess.Popen(
            ["/groups/umcg-gcc/tmp03/umcg-sschuurmans/source_code_tools/probe.2.16.130520.linuxi386",
             "-Q",  # quiet mode
             "{}"  # residue position, not very well mentioned in the doc. all is the whole molecule.
             "-rad1.4",  # radius of the rolling sphere used for marking contact dots and spikes.
             "-C",  # count produced dots
             "-out {}".format("worst", "kaas")]  #
        )

        pass

    def _execute_psi_blast(self):
        ['-num_threads 46 \n',
         '-outfmt 7 \n',
         '-num_iterations 2 \n',
         '-evalue 1 \n',
         '-db /home/evan/bio/databases/blast/nr/nr \n',
         '-comp_based_stats 1 \n',
         '-inclusion_ethresh 0.001 \n',
         '-num_descriptions 3000 \n',
         '-pseudocount 2 \n',
         '-export_search_strategy /home/evan/VIPUR_pipeline/VIPUR/example_input/2C35_VIPUR/2C35.ss \n',
         '-query /home/evan/VIPUR_pipeline/VIPUR/example_input/2C35_VIPUR/2C35.fa \n',
         '-out_ascii_pssm /home/evan/VIPUR_pipeline/VIPUR/example_input/2C35_VIPUR/2C35.pssm \n',
         '-num_alignments 300 \n',
         '-out_pssm /home/evan/VIPUR_pipeline/VIPUR/example_input/2C35_VIPUR/2C35.cp \n',
         '-out /home/evan/VIPUR_pipeline/VIPUR/example_input/2C35_VIPUR/2C35.pb\n']


if __name__ == "__main__":
    ProteinFeatureGeneratorPipeline()
