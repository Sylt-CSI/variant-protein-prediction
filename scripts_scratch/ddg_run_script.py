import argparse
import subprocess


class DdgRun:

    def __init__(self):
        ddg_args = self._ddg_run_arguments()
        self._execute_rosetta_ddg_monomer(ddg_args.rdb, ddg_args.ddgpdb, ddg_args.ddgmut)

    @staticmethod
    def _ddg_run_arguments():
        ddg_arguments = argparse.ArgumentParser()

        ddg_arguments.add_argument("-rdb",
                                   type=str,
                                   help="Specify the path to the full Rosetta database for the ddg monomer application.",
                                   required=True,
                                   nargs=1,
                                   dest="rdb")

        ddg_arguments.add_argument("-ddgpdb",
                                   type=str,
                                   help="The original pdb structure.",
                                   required=True,
                                   nargs=1,
                                   dest="ddgpdb")

        ddg_arguments.add_argument("-ddgmut",
                                   type=str,
                                   help="Mutation file that contains the mutations for the PDB file to be calculated by ddg monomer.",
                                   required=True,
                                   nargs=1,
                                   dest="ddgmut")

        return ddg_arguments.parse_args()

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

    def _execute_rosetta_ddg_monomer(self, rosetta_database, ddg_protein, ddg_mutation_file):
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


if __name__ == "__main__":
    DdgRun()
