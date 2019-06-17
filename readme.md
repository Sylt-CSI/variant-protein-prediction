# Protein variant prediction (project)

###Background
These scripts and the report have been written for the University Medical Center Groningen: Genomic Coordination Center (GCC) at the department of genetics.
With this project an attempt was made to make protein structural data useful for variant prediction based on the methods used by [VIPUR](https://academic.oup.com/nar/article/44/6/2501/2499465), which deemed to be unsuccessful.
To still acquire structural knowledge a self developed method called Single Protein Variant Analyses Approach (SPVAA) had been developed and the webservice [HOPE](http://www.cmbi.ru.nl/hope/) had been tested. 

The scripts within this repository are used by SPVAA and can introduce mutations in specific chains and residue positions.

With these script in the repos mutations can be introduced at specific postions in chains and can be relaxed, the defaults of many scripts are made for single system but can be adjusted or can be filled in as parameter.


###Table of contents

1.[ Report](#Report)\
2.[ Prerequisites](#Prerequisites)\
3.[ Usage SPVAA](#Usage SPVAA)\
3.1[ Mutant](#mutant_file_generator.py) \
4.[ Usage HOPE](#Usage HOPE)


## Report
The report is 

## Prerequisites
VIPUR\
[Probe](http://kinemage.biochem.duke.edu/software/probe.php)\
[PSI-BLAST](https://blast.ncbi.nlm.nih.gov/Blast.cgi?CMD=Web&PAGE_TYPE=BlastDocs&DOC_TYPE=Download)\
[PyMOL](https://github.com/schrodinger/pymol-open-source) (With Python bindings) or [PyRosetta](http://www.pyrosetta.org/) (License required)\
[Rosetta](https://www.rosettacommons.org/) (License required) (MPI recommended)\
[VIPUR script and materials](https://osf.io/bd2h4/)

SPVAA\
[Modeller](https://salilab.org/modeller/) (License required)\
[Python 2.7](https://www.python.org/download/releases/2.7/)\
[Rosetta](https://www.rosettacommons.org/) (License required) (MPI recommended)

To make Modeller and Rosetta work follow the instructions given by them.\
Do not forget to add all requested dirs from modeller to your path otherwise Modeller does not work.

## Usage SPVAA


#### mutant_file_generator.py

#### multi_mutation.py

#### Backrub_pipeline.py

## Usage HOPE

A tool that gives information regarding single mutations in a protein structure and has been published in: **Protein structure analysis of mutations causing inheritable diseases. An e-Science approach with life scientist friendly interfaces** [Venselaar et al. 2010](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-11-548) 