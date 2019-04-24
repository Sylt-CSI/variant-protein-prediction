from __future__ import print_function


class OutputAnalysisFilters():
    # Amino acids group made by Evan Baugh.
    # https://en.wikipedia.org/wiki/File:Amino_Acids.svg        With some extra fantasy.
    AMINOCHANGE_GROUPS = [
        'GP',  # special cases (small + large)
        'AVIL',  # relative small hydrophobic
        'MFWY',  # large hydrophobic
        'HKR',  # charged positive
        'NQ',  # large polar uncharged
        'DE',  # charged negative
        'CST'  # special + small polar uncharged
    ]

    def __init__(self, pssm_file, mutation_file, ddg_ouput_file):

        # self._point_mutation_dict = {}
        self._read_ddg_ouput_file(ddg_ouput_file)
        # self._read_mutation_file(mutation_file)
        # self._read_pssm(pssm_file)

    def _read_ddg_ouput_file(self, ddg_ouput_file):
        with open(ddg_ouput_file, "r") as ddg_file:
            for line in ddg_file:
                if len(line.strip("\n")) == 0:
                    pass
                else:
                    print([feature for feature in line.strip("\n").split(" ") if len(feature) > 0][1:])

    def _read_pssm(self, pssm_file):
        """
        Reads the PSSM file line for line and collects all the mutations for the line.
        :param pssm_file: A file containing a single position specific scoring matrix.
        """
        with open(pssm_file, "r") as pssm:
            pssm.readline()  # skip blank line
            pssm.readline()  # skip text header
            amino_acids = [potential_amino_acid_char for potential_amino_acid_char in
                           pssm.readline().strip("\n").split(" ") if
                           len(potential_amino_acid_char) > 0]
            #  A: [2, 22], C: [6, 26],
            stored_amino_acid_matrix_row_index = self._dict_matrix_map_generator(amino_acids)
            for line in pssm:
                characters = line.strip("\n").split(" ")
                cleaned_line = []
                for character in characters:
                    if len(character) == 0:  # Skip the spaces in filtering since they are of no use.
                        pass
                    elif len(character) > 2 and "-" in character:
                        stitched_characters = character.split("-")
                        if stitched_characters[0] == "":
                            stitched_characters[1] = "-" + stitched_characters[1]
                            stitched_characters[2:] = map(lambda unstitched_character: "-" + unstitched_character,
                                                          stitched_characters[2:])
                            stitched_characters.pop(0)
                        else:
                            stitched_characters[1:] = map(lambda unstitched_character: "-" + unstitched_character,
                                                          stitched_characters[1:])
                        cleaned_line.extend(stitched_characters)
                    else:
                        cleaned_line.append(character)
                if len(cleaned_line) == 0:
                    break
                else:
                    native = cleaned_line[stored_amino_acid_matrix_row_index[cleaned_line[1]][0]]
                    if cleaned_line[0] in self._point_mutation_dict:
                        for mutated_amino_acid in self._point_mutation_dict[cleaned_line[0]]:
                            mutated = cleaned_line[stored_amino_acid_matrix_row_index[mutated_amino_acid][0]]
                            print(int(native), int(mutated), (int(native) - int(mutated)), float(cleaned_line[42]))

    @staticmethod
    def _dict_matrix_map_generator(amino_acids):
        """
        Giving the headers a dict map will be made, every index gets +2 because when a row is read two the position and the original amino acid are added.
        :param amino_acids: Header of amino aicds.
        :return: Dictionary with amino acid as key and a list as value with the index within the header.
        """
        matrix_map = {}
        for amino_acid_index, amino_acid in enumerate(amino_acids):
            if amino_acid in matrix_map:
                matrix_map[amino_acid].append(amino_acid_index + 2)
            else:
                matrix_map[amino_acid] = [amino_acid_index + 2]
        return matrix_map

    def _read_mutation_file(self, mutation_file):
        """
        This method SHOULD NOT exist and should have been dealt with in mutant file generator
        Gets the positions and amino acid mutations
        :param mutation_file: A mutation file that is made for ddg monomer
        """
        with open(mutation_file, "r") as mutations:
            mutations.readline()  # Skip first line ,it is nonsense for this use case for this use.
            mutations.readline()  # second line is also nonsense
            for line in mutations:
                if not line[0].isalpha():
                    pass
                else:
                    mutation_info = line.split(" ")
                    if mutation_info[1] in self._point_mutation_dict:
                        self._point_mutation_dict[mutation_info[1]].append(mutation_info[2].strip("\n"))
                    else:
                        self._point_mutation_dict[mutation_info[1]] = [mutation_info[2].strip("\n")]


if __name__ == "__main__":
    OutputAnalysisFilters("/Users/gcc/Desktop/GCC/VIPUR_CODE_OSF/github-archive/example_output/2C35_VIPUR/2C35.pssm",
                          "data_scratch/kaas_txt.mut",
                          "/Users/gcc/Desktop/GCC/VIPUR_CODE_OSF/github-archive/example_output/2C35_VIPUR/ddg_predictions.out")
