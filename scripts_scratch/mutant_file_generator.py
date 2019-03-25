#!/bin/bash/env python3
from __future__ import print_function

import argparse


class MutantFileGenerator:

    def __init__(self):
        """
        Execute the script
        """
        self._amino_acid_three_letter_one_letter_translation_dict = \
            {
                "ALA": "A",
                "CYS": "C",
                "ARG": "R",
                "GLU": "E",
                "ASN": "N",
                "ASP": "D",
                "GLN": "Q",
                "GLY": "G",
                "HIS": "H",
                "ILE": "I",
                "LEU": "L",
                "LYS": "K",
                "MET": "M",
                "PHE": "F",
                "PRO": "P",
                "SER": "S",
                "THR": "T",
                "TRP": "W",
                "TYR": "Y",
                "VAL": "V"
            }

        csv_file, mutant_file, pdb_file, self._chain = self._mutant_file_generator_argument_parser()
        self._pdb_residue_order = self._pdb_residue_order_mapper(pdb_file)
        _ddg_file = mutant_file.replace(".", "_") + ".mut"
        self._pdb_file = pdb_file.split("/")[-1].split(".")[0]
        with open(mutant_file, "w") as self._resulting_mutant_file, open(_ddg_file, "w") as self._ddg_file:
            with open(csv_file, "rb") as protein_mutant_csv:
                self._read_csv_file(protein_mutant_csv)

    def _mutant_file_generator_argument_parser(self):
        """
        Adds arguments that handle the in and output for the mutation file.
        :return: Mutation_CSV, Output mutation file, Protein pdb file, Chain
        """
        argument_parser = argparse.ArgumentParser(description="Handling arguments for mutant file generator")
        argument_parser.add_argument("-O",
                                     required=True,
                                     type=str,
                                     nargs=1,
                                     metavar="O",
                                     help="The name and where the the file will be stored.")
        argument_parser.add_argument("-P",
                                     required=True,
                                     type=str,
                                     nargs=1,
                                     metavar="P",
                                     help="The name of the pdb file where mutants should be generated for.")
        argument_parser.add_argument("-M",
                                     required=True,
                                     type=str,
                                     nargs=1,
                                     metavar="M",
                                     help="CSV file that contains the mutants with a column protein name.")
        argument_parser.add_argument("-C",
                                     required=True,
                                     type=str,
                                     nargs=1,
                                     metavar="C",
                                     help="Select the chain from the PDB where the mutant should be generated.")

        parsed_args = argument_parser.parse_args()
        return parsed_args.M[0], parsed_args.O[0], parsed_args.P[0], parsed_args.C[0]

    def _read_csv_file(self, csv_reader):
        """
        Read the CSV file and combine it with the other information and write it to a file.
        Does only work currently for a single pdb with a single mutation.
        e.g.

        # Mutant generator
        0,2C35:A:20:Ala
        1,2C35:A:41:Glu
        2,2C35:A:44:Tyr
        3,2C35:A:49:His
        4,2C35:A:49:Asp
        5,2C35:A:49:Cys
        6,2C35:A:51:Tyr
        7,2C35:A:51:Arg
        8,2C35:A:51:Gln
        9,2C35:A:54:Asp

        # DDG_monomer generator
        total 3



        :param csv_reader: reads the CSV pattern
        """
        final_number = 0
        # Skip the header
        csv_reader.readline()
        print("ikmaakkat", file=self._ddg_file)
        while True:
            line = csv_reader.readline().split(",", 3)
            replacing_amino_acid = line[0][-4:-1]
            residue_number = line[0][6:-4]
            if len(line) == 1:
                self._ddg_file.seek(0)
                print("total {}".format(final_number), file=self._ddg_file)
                break
            else:
                final_number += 1

            print(
                str(final_number) + "," + self._pdb_file,
                self._chain,
                replacing_amino_acid.upper(),
                residue_number,
                sep=":",
                file=self._resulting_mutant_file)
            try:
                print(
                    "1\n{} {} {}".format(
                        self._pdb_residue_order[int(residue_number)],
                        residue_number,
                        self._amino_acid_three_letter_one_letter_translation_dict[replacing_amino_acid.upper()]),
                    file=self._ddg_file)
            except KeyError:
                print("Requested residue mutation not matching with PDB residue appearance at position: {}"
                      .format(int(residue_number)))
        # self._resulting_mutant_file.seek(0)
        # print("total", number, file=self._resulting_mutant_file)

    def _pdb_residue_order_mapper(self, pdb_file):
        residue_dict = {}
        start = 0
        current_number = None
        with open(pdb_file, "rb") as pdb_file_reader:
            for line in pdb_file_reader:
                if line.startswith(b"ATOM"):
                    line = [i for i in line.strip(b"\n").split(b" ") if len(i) > 0]
                    if current_number != line[5]:
                        current_number = line[5]
                        start += 1
                        residue_dict[start] = self._amino_acid_three_letter_one_letter_translation_dict[line[3]]
                    else:
                        pass

        return residue_dict


if __name__ == "__main__":
    MutantFileGenerator()
