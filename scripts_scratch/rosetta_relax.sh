#!/bin/bash
#SBATCH --job-name=regular_relax
#SBATCH --qos=regular
#SBATCH --ntasks=34
#SBATCH --mem=90gb
#SBATCH --nodes=1
#SBATCH --time=48:00:00
#SBATCH --error=/groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/relax_error/%j_relax_error.txt
#SBATCH --output=/groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/relax_output/%j_relax_ouput.txt
#SBATCH --exclude=umcg-node002,umcg-node004
#SBATCH --export=NONE


module purge
module load Python/2.7.11-foss-2015b
module load libffi/3.2.1-foss-2015b
module load foss/2015b
module load libtool/2.4.6-GNU-4.9.3-2.25
module load zlib/1.2.11-foss-2015b

return_point=$(readlink -f ./)

relax_dir=$3relax/

mkdir -p $relax_dir

cd $relax_dir

mpirun /groups/umcg-gcc/tmp03/umcg-sschuurmans/source_code_tools/rosetta_src_2018.33.60351_bundle/main/source/bin/relax.mpi.linuxgccrelease \
-database $1 \
-in:file:s $2 \
-nstruct 64 \
-out:path:all $relax_dir \
-run:ignore_zero_occupancy false \
-run:constant_seed \
-out:suffix _relax \
-relax:fast \
-relax:constrain_relax_to_start_coords \
-relax:ramp_constraints false \
-ex1 \
-ex2 \
-use_input_sc \
-flip_HNQ \
-no_optH false

cd $return_point