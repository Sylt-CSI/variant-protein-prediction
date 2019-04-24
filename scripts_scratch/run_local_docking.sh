#!/bin/sh
#SBATCH --job-name=regular_docking
#SBATCH --qos=regular
#SBATCH --ntasks=34
#SBATCH --nodes=1
#SBATCH --time=24:00:00
#SBATCH --error=/groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/docking_error/docking_error.txt
#SBATCH --output=/groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/docking_output/docking_output.txt

module purge
module load Python/2.7.11-foss-2015b
module load libffi/3.2.1-foss-2015b
module load foss/2015b
module load libtool/2.4.6-GNU-4.9.3-2.25
module load zlib/1.2.11-foss-2015b

return_point=$(readlink -f ./)

docking_dir=$3/local_docking/

mkdir -p $docking_dir

cd $docking_dir

mpirun /groups/umcg-gcc/tmp03/umcg-sschuurmans/source_code_tools/rosetta_src_2018.33.60351_bundle/main/source/build/src/release/linux/2.6/64/x86/gcc/4.9/mpi/docking_protocol.mpi.linuxgccrelease \
-in:file:s $2 \
-out:path:all $docking_dir \
-nstruct 136 \
-partners R_A \
-dock_pert 3 8 \
-ex1 \
-ex2aro \
-out:suffix _local_dock

cd $return_point

#$1 /groups/umcg-gcc/tmp03/umcg-sschuurmans/source_code_tools/rosetta_src_2018.33.60351_bundle/main/database
#$2 /groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/1TNR_ORIGNAL_RESULTS/1tnr.pdb
#$3 /groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/snubbie \