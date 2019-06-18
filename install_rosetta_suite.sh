#!/bin/sh
#SBATCH --job-name=compile_rosetta
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --qos=dev
#SBATCH --mincpus=48
#SBATCH --time=24:00:00
#SBATCH --error=/groups/umcg-gcc/tmp03/umcg-sschuurmans/source_code_tools/compiling_error/rosetta_compilation_error.txt
#SBATCH --output=/groups/umcg-gcc/tmp03/umcg-sschuurmans/source_code_tools/compiling_output/rosetta_compilation_output.txt

module purge
module load Python/2.7.11-foss-2015b
module load libffi/3.2.1-foss-2015b
module load foss/2015b
module load GLib/2.52.3-foss-2015b
module load libtool/2.4.6-GNU-4.9.3-2.25
module load zlib/1.2.11-foss-2015b


cd /groups/umcg-gcc/tmp03/umcg-sschuurmans/source_code_tools/rosetta_src_2018.33.60351_bundle/main/source/
/groups/umcg-gcc/tmp03/umcg-sschuurmans/source_code_tools/rosetta_src_2018.33.60351_bundle/main/source/scons.py -j 48 mode=release bin extras=mpi
