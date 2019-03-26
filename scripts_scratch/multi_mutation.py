import sys
import os
import glob
import argparse
import modeller
import modeller.scripts
import modeller.optimizers
import modeller.automodel


class MultiMutator:

    def __init__(self):
        self._pdb_file_mutants = {}
        self._mutant_dict = {}
        self._found_proteins_structures = {}

        # (Construction aka) execution.

        arguments = self._multi_mutation_argument_parser()

        folder_name = self._quick_fix_folder_name(arguments.FO[0])

        self._folder_search(folder_name, arguments.E)
        self._read_mutation_file(arguments.M[0])
        # self._available_files_mutation_filtering()
        # self._execute_deletion()
        # self._execute_insertion()

    @staticmethod
    def _multi_mutation_argument_parser():
        multi_mutator_argument_parser = argparse.ArgumentParser(
            description="Prints this message and shows all option the script has.")
        file_or_folder_group_argument = multi_mutator_argument_parser.add_mutually_exclusive_group(required=True)

        file_or_folder_group_argument.add_argument("-fo",
                                                   dest="FO",
                                                   nargs=1,
                                                   type=str,
                                                   help="Requires a single folder that holds the pdb files.")
        file_or_folder_group_argument.add_argument("-fi",
                                                   dest="FI",
                                                   nargs=1,
                                                   type=str,
                                                   help="Requires a single pdb file (CURRENTLY NOT WORKING)")

        multi_mutator_argument_parser.add_argument("-mm",
                                                   required=True,
                                                   help="Give a mutation file that describes which residues at which chain it should mutate.",
                                                   nargs=1,
                                                   type=str,
                                                   dest="M")
        multi_mutator_argument_parser.add_argument("-ep",
                                                   required=False,
                                                   nargs="+",
                                                   type=str,
                                                   default="",
                                                   help="Specify extra file extensions that should be looked for when searching for PDB. (CURRENTLY NO CIF SUPPORT)",
                                                   dest="E")

        return multi_mutator_argument_parser.parse_args()

    def _quick_fix_folder_name(self,folder_name):
        if not folder_name.endswith("/"):
            return folder_name+"/"
        else:
            return folder_name



    def _read_mutation_file(self, mutation_file):
        """
        Reads a file to discover which mutations should be made
        The setup: NUMBER,PDB:CHAIN:RESIDUE-POSITION:TRI-CODE

        # SINGLE PDB multi mutation
        1,1a2b:A:3:TYR
        1,1a2b:A:4:LEU
        1,1a2b:A:5:ILE

        # SAME PDB different mutation
        2,1a2b:A:3:VAL

        # NEW PDB different mutation
        1,9Z3X:F:27:PRO
        """
        with open(mutation_file, "r") as mutants:
            for line in mutants:
                if line.startswith("#"):
                    pass
                else:
                    pdb_file_mutation, pdb_chain, pdb_position, amino_acid = line.split(":")
                    if pdb_file_mutation in self._mutant_dict:
                        self._mutant_dict[pdb_file_mutation].extend([pdb_chain.strip(" \n"),
                                                                     pdb_position.strip(" \n"),
                                                                     amino_acid.strip(" \n")])
                    else:
                        self._mutant_dict[pdb_file_mutation] = [pdb_chain.strip(" \n"),
                                                                pdb_position.strip(" \n"),
                                                                amino_acid.strip(" \n")]

    def _folder_search(self, pdb_folder, expanded_patterns=""):
        """
        Searches the targeted folder for files with a specfic extension, by default it focuses on pdb and
        :param expanded_patterns: String separated by comma's containing file extensions, it is CASE sensitive.
        :return: A numpy array containing all found file.
        """
        number_of_found_files = 0
        file_extension_search_patterns = ["[Pp][Dd][Bb]"]
        if expanded_patterns == "":
            pass
        else:
            file_extension_search_patterns.extend(expanded_patterns.split(","))
        for file_extension in file_extension_search_patterns:
            checked_folder = glob.glob("{}*.{}".format(pdb_folder, file_extension))
            extension_found_proteins = {found_file.split("/")[5].split(".")[0]: found_file
                                        for found_file in checked_folder}
            number_of_found_files += len(checked_folder)
            self._found_proteins_structures.update(extension_found_proteins.copy())
        print("Potential protein structure files found: {}".format(number_of_found_files))

    def _available_files_mutation_filtering(self):
        """
        Match the found pdb files that are related to a mutation.
        """
        for applied_protein_mutation in self._mutant_dict:
            protein_file_name = applied_protein_mutation.split(",")[1]
            if protein_file_name in self._found_proteins_structures:
                # Combine the information of the available files and the mutations structure:
                # Key = PROTEIN MUTATION, Values = [[CHAIN, POSITION, NEW RESIDUE],FILE_PATH]
                self._pdb_file_mutants[applied_protein_mutation] = [self._mutant_dict[applied_protein_mutation],
                                                                    self._found_proteins_structures[protein_file_name]]
                print("Found protein structure for mutation: {}".format(applied_protein_mutation))
            else:
                print("No protein structure found for mutation: {}".format(applied_protein_mutation))
        # Garbage collect dictionaries that are not relevant anymore.
        del self._mutant_dict, self._found_proteins_structures
        if len(self._pdb_file_mutants) <= 0:
            sys.exit("Quiting program, no mutants found that are related to the associated PDB structures.")

    def _file_search(self):
        # TODO TO BE IMPLEMENTED
        pass

    def _create_mutations(self):
        # TODO alter _execute_insertion function that makes the generic part which is also necessary for mutations
        pass

    def _execute_insertion(self):
        """
        Makes mutations to a protein structure, ligands will be removed,
        since it is hard to guarantee that all structures have ligands.
        """

        protein_environment = modeller.environ(rand_seed=-49837)
        protein_environment.libs.topology.read(file='$(LIB)/top_heav.lib')
        protein_environment.libs.parameters.read(file='$(LIB)/par.lib')
        protein_environment.io.hetatm = False

        # Structure as it will be read:
        # {'1,133l': [['A', 'CYS', '40'], '/Users/gcc/Downloads/crap_tastic_pdbs/133l.pdb'],
        # '1,134l': [['A', 'VAL', '32'], '/Users/gcc/Downloads/crap_tastic_pdbs/134l.pdb']}

        for mutant_pdb_file_dict in self._pdb_file_mutants:
            # Get file name to which the mutation it matched.
            protein_data_bank_file = self._pdb_file_mutants[mutant_pdb_file_dict][-1]

            # Information regarding the mutation itself : chain, new residue and position.
            protein_mutation_information = self._pdb_file_mutants[mutant_pdb_file_dict][0]

            # Find the path to the file by splitting the last right slash of from the file.
            mutant_protein_data_bank_path_and_file = protein_data_bank_file.rsplit("/", 1)

            # Get iteration number of the pdb file, in case different mutations are made within the same pdb.
            mutant_number = mutant_pdb_file_dict.split(",")[0]

            # Put the name of the original protein together with the mutant iteration number together for the filename.
            mutant_protein_data_bank_path_and_file[-1] = mutant_protein_data_bank_path_and_file[-1].split(".")[
                                                             0] + "_" + mutant_number

            # Execute a script which adds missing atoms to the PDB structure, returns a model.
            complemented_pdb = modeller.scripts.complete_pdb(protein_environment,
                                                             protein_data_bank_file)

            # Instantiate an alignment object and add the model to it.
            pdb_alignment_array = modeller.alignment(protein_environment)
            pdb_alignment_array.append_model(complemented_pdb,
                                             atom_files=protein_data_bank_file,
                                             align_codes=protein_data_bank_file)

            # Apply each mutation to the current protein databank file.
            for protein_chain_index in range(0, len(protein_mutation_information), 3):
                #   [CHAIN              , RESIDUE_TYPE          , RESIDUE_POSITION]
                #   [protein_chain_index, protein_chain_index +1, protein_chain_index +2]
                protein_selection = modeller.selection(
                    complemented_pdb.chains[protein_mutation_information[protein_chain_index]].residues[
                        protein_mutation_information[protein_chain_index + 2]])
                protein_selection.mutate(residue_type=protein_mutation_information[protein_chain_index + 1])

            # Add the mutated model to the alignment.
            pdb_alignment_array.append_model(complemented_pdb, align_codes=protein_data_bank_file)

            # Remove the topology from the model.
            complemented_pdb.clear_topology()
            # Copy over the topology from the the mutated model that resides within the alignment.
            complemented_pdb.generate_topology(pdb_alignment_array[-1])

            # Transfer the coordinates from the template native structure to the mutant.
            complemented_pdb.transfer_xyz(pdb_alignment_array)
            # In case of missing coordinates initialize_xyz=False generates coordinates.
            # Build method defines how the atoms are placed, with INTERNAL_COORDINATES the topology library is used.
            complemented_pdb.build(initialize_xyz=False, build_method='INTERNAL_COORDINATES')

            revised_model = modeller.model(env=protein_environment, file=protein_data_bank_file)
            complemented_pdb.res_num_from(revised_model, pdb_alignment_array)
            complemented_pdb.write(file="/".join(mutant_protein_data_bank_path_and_file) + ".pdb")

    def _execute_deletion(self):
        # TODO Biopython implementation
        pass

        # modelname, respos, restyp, chain, = sys.argv[1:]

    def _calculate_disulfide(self):
        pass


if __name__ == "__main__":
    MultiMutator()

    # Check for appropriate file:
    # if pdb_file ==
    # Modify specific residue.
