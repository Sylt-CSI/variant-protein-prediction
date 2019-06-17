# Protein variant prediction (graduation project)

## Background
These scripts and the report have been written for the University Medical Center Groningen: Genomic Coordination Center (GCC) at the department of genetics.
With this project an attempt was made to make protein structural data useful for variant prediction based on the methods used by [VIPUR](https://academic.oup.com/nar/article/44/6/2501/2499465), which deemed to be unsuccessful.
To still acquire structural knowledge a self developed method called Single Protein Variant Analyses Approach (SPVAA) had been developed and the webservice [HOPE](http://www.cmbi.ru.nl/hope/) had been tested. 

The scripts within this repository are used by SPVAA and can introduce mutations in specific chains and residue positions. 
Within the pipeline the whole structure is being refined. 

The defaults of many scripts are made for single system but can be modified or can be filled in with a parameter.


## Table of contents


- [Report](#report)
- [Prerequisites](#prerequisites)
- [SPVAA](#spvaa)
  - [mutant_file_generator.py](#mutant_file_generatorpy)
  - [multi_mutation.py](#multi_mutationpy)
  - [Backrub_pipeline.py](#backrub_pipelinepy)


## Report
The report contains the flow of the scripts, the aspects that were investigated and the results.

## Prerequisites
#### VIPUR
[Probe](http://kinemage.biochem.duke.edu/software/probe.php)\
[PSI-BLAST](https://blast.ncbi.nlm.nih.gov/Blast.cgi?CMD=Web&PAGE_TYPE=BlastDocs&DOC_TYPE=Download)\
[PyMOL](https://github.com/schrodinger/pymol-open-source) (With Python bindings) or [PyRosetta](http://www.pyrosetta.org/) (License required)\
[Rosetta](https://www.rosettacommons.org/) (License required) (MPI recommended)\
[VIPUR script and materials](https://osf.io/bd2h4/)

#### SPVAA
[Modeller](https://salilab.org/modeller/) (License required)\
[Python 2.7](https://www.python.org/download/releases/2.7/)\
[Rosetta](https://www.rosettacommons.org/) (License required) (MPI recommended)\
[SLURM](https://slurm.schedmd.com/overview.html)

To make Modeller and Rosetta work follow the instructions given by them.\
Do not forget to add all requested dirs from modeller to your path otherwise Modeller does not work.

## SPVAA
Before executing the the pipeline several steps have to be taken manually, first a file should be made wherein mutations to single residues are described.
The format starts with the original residue position in the Fasta file new residue.\

The classification is NOT OPTIONAL but is also not used, if not known it is recommended to use Na/NA because it must be filled in at the current state.

Example: 
    
    sample from: filtered_tnfrsf1a_muts.tsv
    
    Thr109Ala PATHOGENIC
    Thr110Ile POPULATION
    Val111Leu POPULATION
    Gln111Lys Uncertain significance (VOUS)
    Arg112Pro PATHOGENIC
    Val112Leu Likely pathogenic
    His112Tyr PATHOGENIC
    Val112Met NA
    


#### mutant_file_generator.py
The first step is making an appropriate format to work with for Modeller, this can be done with the multi_mutation.py script.
The format will be generated based on te mutations (file described previously) and the PDB given to it.

Options of mutant_file_generator.py:

    -O = The name of the file where the mutants will be stored in.
    -P = The name of the pdb file where mutants should be generated for.
    -M = TSV file that contains the mutants with a column protein name.
    -C = Select the chain from the PDB where the mutant should be generated 
         (multiple chains: A,X,Z), no spaces!).
    -S = Start position of pdb within a Fasta, if not specified it starts at
         the position of the PDB. (goes for all chains) e.g 1TNR resides in 
         positions 44-182, the pdb itself starts at 15 If specified you can 
         make it start at 44 instead of 15." (OPTIONAL)
Example of running the mutant_file_generator.py:

    scripts_scratch/mutant_file_generator.py 
        -O data_scratch/TNFRS1A_TNFA_modified_list.txt 
        -P data_scratch/1tnr3_TNFA.pdb 
        -M data_scratch/filtered_tnfrsf1a_muts.tsv  
        -C R,T,S 
        -S 44

An extra file is generated with the extension .mut, originally this file was used for Rosetta's [DDG monomer](https://www.rosettacommons.org/docs/latest/application_documentation/analysis/ddg-monomer), but is no longer used and still has to be removed. The file can be ignored and/or removed.

From mutant_file_generator.py a file is produced that describes mutations for a specific PDB, a chain and position.

    Sample from the file generated by the mutant_file_generator.py (TNFRS1A_TNFA_modified_list.txt)
    
    196,1tnr3_TNFA:R:65:ALA
    196,1tnr3_TNFA:T:65:ALA
    196,1tnr3_TNFA:S:65:ALA
    197,1tnr3_TNFA:R:66:ILE
    197,1tnr3_TNFA:T:66:ILE
    197,1tnr3_TNFA:S:66:ILE
    198,1tnr3_TNFA:R:67:LEU
    198,1tnr3_TNFA:T:67:LEU
    198,1tnr3_TNFA:S:67:LEU
    199,1tnr3_TNFA:R:67:LYS
    199,1tnr3_TNFA:T:67:LYS
    199,1tnr3_TNFA:S:67:LYS
    200,1tnr3_TNFA:R:68:PRO
    200,1tnr3_TNFA:T:68:PRO
    200,1tnr3_TNFA:S:68:PRO
    201,1tnr3_TNFA:R:68:LEU
    201,1tnr3_TNFA:T:68:LEU
    201,1tnr3_TNFA:S:68:LEU
    202,1tnr3_TNFA:R:68:TYR
    202,1tnr3_TNFA:T:68:TYR
    202,1tnr3_TNFA:S:68:TYR
    203,1tnr3_TNFA:R:68:MET
    203,1tnr3_TNFA:T:68:MET
    203,1tnr3_TNFA:S:68:MET

The first number, before the comma, from table is the iteration number and gives the information in which protein the mutation should be introduced,
if the number is identical it will be in the same model.
After the comma comes the name of the protein that is going to be mutated, it is used as key by the software, it could be beneficial when further developed to mutate multiple proteins at once.
The single letter describes the chain where the mutation should take place and the number describes the index of the chain that should be modified.
The final three characters represent the new amino acid that can be introduced by [multi_mutation.py](#multi_mutation.py).


#### multi_mutation.py

With the produced table from [mutant_file_generator.py](#mutant_file_generator.py) it is possible to introduce mutations into the specified PDB file with Modeller.

Options multi_mutation.py:
    
    (Mutually exclusive)
    -ifi = A single folder that contains all the pdb files where mutations should be integrated in (Not working properly at the moment.).
    -ifo = A single pdb where mutations should be introduced in. 
    
    -ep = Specify extra file extensions that should be looked for when searching for PDB. CIF is not supported by Modeller.
    -mm = Give a mutation file that describes which residues at which chain it should mutate.
    -ofo = Output folder where the mutated PDB's will be stored, if nothing specified it will go to the input directory
    
Example of running multi_mutation.py

    python scripts_scratch/multi_mutation.py
        -ifi /Users/gcc/Desktop/GCC/pipeline/data_scratch/1tnr3_TNFA.pdb 
        -mm /Users/gcc/Desktop/GCC/pipeline/data_scratch/TNFRS1A_TNFA_modified_list.txt 
        -ofo /Users/gcc/Desktop/GCC/pipeline/data_scratch/mutated_1tnr3_TNFA_pdb_s/    
    
By running this all mutations are made that are specified in table as separate PDB.

Output PDB files from the example:

    1tnr3_TNFA_196_65_ALA_65_ALA_65_ALA.pdb
    1tnr3_TNFA_197_66_ILE_66_ILE_66_ILE.pdb
    1tnr3_TNFA_198_67_LEU_67_LEU_67_LEU.pdb
    1tnr3_TNFA_199_67_LYS_67_LYS_67_LYS.pdb
    1tnr3_TNFA_200_68_PRO_68_PRO_68_PRO.pdb
    1tnr3_TNFA_201_68_LEU_68_LEU_68_LEU.pdb
    1tnr3_TNFA_202_68_TYR_68_TYR_68_TYR.pdb
    1tnr3_TNFA_203_68_MET_68_MET_68_MET.pdb


#### Backrub_pipeline.py

The final step is lowering the energy state of the mutated proteins and with [Backrub](https://www.rosettacommons.org/docs/latest/application_documentation/structure_prediction/backrub) and [Relax](https://www.rosettacommons.org/docs/latest/application_documentation/structure_prediction/relax) from the Rosetta suite. 
It is recommend to run this process within [tmux](https://github.com/tmux/tmux/wiki) or [Screen](https://www.gnu.org/software/screen/) because the processes are monitored by a Python script and will follow each other up when monitored.
A "weak" checkpointing system is integrated which looks if a score file has been made, when crashes it will state it is already finished. Without changes it produces 1000 Backrubbed models with 10000 Monte Carlo moves and 64 Relaxed structures will be made. The scripts have to be modified to change these values.
To run this pipeline SLURM is required because the scripts are built for a SLURM cluster.

Options Backrub_pipeline.py:

    -rdb = Path to Rosetta database required for Backrub and Relax
    -pdb = The pdb structure that will be backrubbed and relaxed, must contain lignand and protein.
    -bscri = The Rosetta backrub script with fullpath.
    -rscri = The Rosetta relax script with fullpath.
    -out = Output directory of where the backrubbed and relaxed structures will be stored.
    -ignore = Ignores when an error occures with a previous part in the pipeline and continues with wath there is.
    -dry = Prints the command that will be used to launch the slurm job scripts.
    
Example Backrub_pipeline.py

    python2.7 rosetta_backrub_relax_dock_pipeline.py 
        -pdb /groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY.pdb 
        -out /groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/1TNR3_TNFA_GLY_18/


Example output Backrub_pipeline.py

    testing_ground/1TNR3_TNFA_GLY_18/
    ├── backrub
    │   ├── 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0001_last.pdb
    │   ├── 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0001_low.pdb
    │   ├── 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0001.pdb
    │   ├── ...........
    │   └── score_back_rub.sc
    └── relax
        ├── 1tnr3_TNFA_67_18_GLY_18_GLY_18_GLY_back_rub_0759_relax_0001.pdb
        ├── ...........
        └── score_relax.sc