#!/bin/sh
#SBATCH --job-name=test_psi_blast
#SBATCH --ntasks=40
#SBATCH --nodes=1
#SBATCH --qos=dev
#SBATCH --mem=64000MI
#SBATCH --time=24:00:00
#SBATCH --error=/groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/psi_error/psi_run_error.txt
#SBATCH --output=/groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/psi_output/psi_run_ouput.txt
module purge
module load BLAST+/2.7.1-foss-2015b

psiblast \
-num_threads 40 \
-outfmt 7 \
-num_iterations 2 \
-evalue 1 \
-db /groups/umcg-gcc/tmp03/umcg-sschuurmans/db/full_nr/nr_db_out \
-comp_based_stats 1 \
-inclusion_ethresh 0.001 \
-num_descriptions 3000 \
-pseudocount 2 \
-query /groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/2C35_flattened.fa \
-export_search_strategy /groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/2C35_flattened.ss \
-out_ascii_pssm /groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/2C35_flattened.pssm \
-num_alignments 300 \
-out_pssm /groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/2C35_flattened.cp \
-out /groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/2C35_flattened.pb