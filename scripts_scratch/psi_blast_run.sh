#!/bin/sh
#SBATCH --job-name=test_psi_blast
#SBATCH --ntasks=40
#SBATCH --nodes=1
#SBATCH --qos=regular
#SBATCH --mem=64000MI
#SBATCH --time=24:00:00
#SBATCH --error=/groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/psi_error/psi_run_error.txt
#SBATCH --output=/groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/psi_output/psi_run_ouput.txt
module purge
module load BLAST+/2.7.1-foss-2015b


# $1 threads
# $2 db
# $3 query
# $4 out_file_name
# $5 out_folder




psiblast \
-num_threads $1 \
-outfmt 7 \
-num_iterations 2 \
-evalue 1 \
-db $2 \
-comp_based_stats 1 \
-inclusion_ethresh 0.001 \
-num_descriptions 3000 \
-pseudocount 2 \
-query $3 \
-export_search_strategy $5$4.ss \
-out_ascii_pssm $5$4.pssm \
-num_alignments 300 \
-out_pssm $5$4.cp \
-out $5$4.pb


# -export_search_strategy /groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/2C35_flattened.ss \
# -out_ascii_pssm /groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/2C35_flattened.pssm \
# -num_alignments 300 \
# -out_pssm /groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/2C35_flattened.cp \
# -out /groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/2C35_flattened.pb