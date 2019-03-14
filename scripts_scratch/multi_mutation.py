import sys
# import os
import glob
import modeller
import modeller.scripts
import modeller.optimizers
import modeller.automodel


class MultiMutator:

    def __init__(self, file_with_mutations=sys.argv[1], file_extensions=""):
        self._pdb_file_mutants = {}
        self._mutant_dict = {}
        self._found_proteins_structures = {}

        # Construction of the object.
        self._folder_search(file_extensions)
        self._read_mutation_file(file_with_mutations)
        self._available_files_planned_mutation_filtering()
        self._execute_deletion()
        self._execute_insertion()

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
                pdb_file_mutation, pdb_chain, pdb_position, amino_acid = line.split(":")
                if pdb_file_mutation in self._mutant_dict:
                    self._mutant_dict[pdb_file_mutation].extend([pdb_chain.strip(" \n"),
                                                                 pdb_position.strip(" \n"),
                                                                 amino_acid.strip(" \n")])
                else:
                    self._mutant_dict[pdb_file_mutation] = [pdb_chain.strip(" \n"),
                                                            pdb_position.strip(" \n"),
                                                            amino_acid.strip(" \n")]

    def _folder_search(self, expanded_patterns=""):
        """
        Searches the targeted folder for files with a specfic extension, by default it focuses on pdb and
        :param expanded_patterns: String separated by comma's containing file extensions, it is CASE sensitive.
        :return: A numpy array containing all found file.
        """
        number_of_found_files = 0
        file_extension_search_patterns = ["[Cc][Ii][Ff]", "[Pp][Dd][Bb]"]
        if expanded_patterns == "":
            pass
        else:
            file_extension_search_patterns.extend(expanded_patterns.split(","))
        for file_extension in file_extension_search_patterns:
            checked_folder = glob.glob("/Users/gcc/Downloads/crap_tastic_pdbs/*.{}".format(file_extension))
            extension_found_proteins = {found_file.split("/")[5].split(".")[0]: found_file
                                        for found_file in checked_folder}
            number_of_found_files += len(checked_folder)
            self._found_proteins_structures.update(extension_found_proteins.copy())
        print("Potential protein structure files found: {}".format(number_of_found_files))

    def _available_files_planned_mutation_filtering(self):
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

        # protein_environment.edat.dynamic_sphere = False
        # # lennard-jones potential (more accurate)
        # protein_environment.edat.dynamic_lennard = True
        # protein_environment.edat.contact_shell = 4.0
        # protein_environment.edat.update_dynamic = 0.39
        protein_environment = modeller.environ(rand_seed=-49837)
        protein_environment.libs.topology.read(file='$(LIB)/top_heav.lib')
        protein_environment.libs.parameters.read(file='$(LIB)/par.lib')
        protein_environment.io.hetatm = False

        for mutant_pdb_file_dict in self._pdb_file_mutants:
            # Get iteration number of the same pdb file.
            mutant_number = mutant_pdb_file_dict.split(",")[0]
            # Get file name that was matched to the mutation.
            protein_data_bank_file = self._pdb_file_mutants[mutant_pdb_file_dict][-1]
            protein_mutation_information = self._pdb_file_mutants[mutant_pdb_file_dict][0]
            # Create the path to the resulting mutated structure.
            mutant_protein_data_bank_file_name = protein_data_bank_file.rsplit("/", 1)
            # Put the name and the iteration number together of the mutant.
            mutant_protein_data_bank_file_name[-1] = mutant_number + "_" + mutant_protein_data_bank_file_name[-1]
            # Start correcting the PDB.
            complemented_pdb = modeller.scripts.complete_pdb(protein_environment,
                                                             protein_data_bank_file)
            # complemented_pdb = modeller.model(protein_environment, file=protein_data_bank_file)
            complemented_pdb_alignment_array = modeller.alignment(protein_environment)
            complemented_pdb_alignment_array.append_model(complemented_pdb,
                                                          atom_files=protein_data_bank_file,
                                                          align_codes=protein_data_bank_file)
            for protein_chain_index in range(0, len(protein_mutation_information), 3):
                #   [CHAIN              , RESIDUE_TYPE          , RESIDUE_POSITION]
                #   [protein_chain_index, protein_chain_index +1, protein_chain_index +2]
                protein_selection = modeller.selection(
                    complemented_pdb.chains[protein_mutation_information[protein_chain_index]].residues[
                        protein_mutation_information[protein_chain_index + 1]])
                protein_selection.mutate(residue_type=protein_mutation_information[protein_chain_index + 2])

            complemented_pdb_alignment_array.append_model(complemented_pdb, align_codes=protein_data_bank_file)
            complemented_pdb.clear_topology()
            complemented_pdb.generate_topology(complemented_pdb_alignment_array[-1])
            complemented_pdb.transfer_xyz(complemented_pdb_alignment_array)
            complemented_pdb.build(initialize_xyz=False, build_method='INTERNAL_COORDINATES')
            revised_model = modeller.model(env=protein_environment, file=protein_data_bank_file)
            complemented_pdb.res_num_from(revised_model, complemented_pdb_alignment_array)
            complemented_pdb.write(file="".join(mutant_protein_data_bank_file_name))
    #
    # def optimize(self, atmsel, sched):
    #     # conjugate gradient
    #     for step in sched:
    #         step.optimize(atmsel, max_iterations=200, min_atom_shift=0.001)
    #     # md
    #     self.refine(atmsel)
    #     cg = modeller.optimizers.conjugate_gradients()
    #     cg.optimize(atmsel, max_iterations=200, min_atom_shift=0.001)
    #
    # # molecular dynamics
    # def refine(self, atmsel):
    #     # at T=1000, max_atom_shift for 4fs is cca 0.15 A.
    #     md = modeller.optimizers.molecular_dynamics(cap_atom_shift=0.39, md_time_step=4.0,
    #                                                 md_return='FINAL')
    #     init_vel = True
    #     for (its, equil, temps) in ((200, 20, (150.0, 250.0, 400.0, 700.0, 1000.0)),
    #                                 (200, 600,
    #                                  (1000.0, 800.0, 600.0, 500.0, 400.0, 300.0))):
    #         for temp in temps:
    #             md.optimize(atmsel, init_velocities=init_vel, temperature=temp,
    #                         max_iterations=its, equilibrate=equil)
    #             init_vel = False
    #
    # # use homologs and dihedral library for dihedral angle restraints
    # def make_restraints(self, mdl1, aln):
    #     rsr = mdl1.restraints
    #     rsr.clear()
    #     s = modeller.selection(mdl1)
    #     for typ in ('stereo', 'phi-psi_binormal'):
    #         rsr.make(s, restraint_type=typ, aln=aln, spline_on_site=True)
    #     for typ in ('omega', 'chi1', 'chi2', 'chi3', 'chi4'):
    #         rsr.make(s, restraint_type=typ + '_dihedral', spline_range=4.0,
    #                  spline_dx=0.3, spline_min_points=5, aln=aln,
    #                  spline_on_site=True)

    def _execute_deletion(self):
        # TODO Biopython implementation
        pass

        # modelname, respos, restyp, chain, = sys.argv[1:]


# modeller.log.none()
#
# kaas = "/Users/gcc/Desktop/GCC/pipeline/data_scratch/2C35_fixed_missing.pdb"
#
# environment = modeller.environ(rand_seed=-49837)
# modelname, respos, restyp, chain, = sys.argv[1:]
#
# # Disables extra atoms/ligands, for uniformity in assessment of many different proteins.

# #soft sphere potential
# environment.edat.dynamic_sphere=False
# #lennard-jones potential (more accurate)
# environment.edat.dynamic_lennard=True
# environment.edat.contact_shell = 4.0
# environment.edat.update_dynamic = 0.39
#
#
# environment.libs.topology.read(file='$(LIB)/top_heav.lib')
#
# environment.libs.parameters.read(file='$(LIB)/par.lib')
#
# # Instantiate model object of the given structure.
# original_protein_model = modeller.model(environment, file=kaas)
# alignment_original_protein_model_environment = modeller.alignment(environment)
# alignment_original_protein_model_environment.append_model(original_protein_model,atom_files=kaas, align_codes=kaas)
# print(alignment_original_protein_model_environment)


if __name__ == "__main__":
    MultiMutator()

    # Check for appropriate file:
    # if pdb_file ==
    # Modify specific residue.
