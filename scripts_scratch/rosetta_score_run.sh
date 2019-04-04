module purge
module load Python/2.7.11-foss-2015b
module load libffi/3.2.1-foss-2015b
module load foss/2015b
module load libtool/2.4.6-GNU-4.9.3-2.25
module load zlib/1.2.11-foss-2015b

score_jd2.mpi.linuxgccrelease \
-rescore:verbose \
-database /groups/umcg-gcc/tmp03/umcg-sschuurmans/source_code_tools/rosetta_src_2018.33.60351_bundle/main/database \
-out:file:scorefile /groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/133l.sc \
-in:file:native /groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/133l.pdb \
-in:file:s /groups/umcg-gcc/tmp03/umcg-sschuurmans/testing_ground/133l.pdb \
-in:file:fullatom
