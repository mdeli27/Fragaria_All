#! /bin/bash
#BSUB -J deepvariant_N.15_5
#BSUB -q multicore20
#BSUB -M 100000 -R "rusage[mem=100000] "
#BSUB -n 20
#BSUB -o N.15_5_deepvariant_output.txt
#BSUB -e N.15_5_deepvariant_error.txt

export LC_ALL=C
export TMPDIR="$PWD/tmp_dir"
INPUT_DIR='/netscratch/dep_mercier/grp_novikova/Fragaria/ref'
OUTPUT_DIR='/netscratch/dep_mercier/grp_novikova/Fragaria/new_map/Ticao_BAM'

singularity run --bind $TMPDIR:$TMPDIR  \
  /netscratch/dep_mercier/grp_novikova/Neobatrachus/Jie/software/deepvariant_1.4.0.sif /opt/deepvariant/bin/run_deepvariant \
  --num_shards=20 \
  --model_type=WGS \
  --ref=${INPUT_DIR}/Fragaria_vesca_v4.0.a1.fa\
  --reads=${OUTPUT_DIR}/N.15-5.rmdup.bam \
  --output_vcf=${OUTPUT_DIR}/N.15-5.output.vcf.gz \
  --output_gvcf=${OUTPUT_DIR}/N.15-5.output.g.vcf.gz \
  --intermediate_results_dir ${OUTPUT_DIR}/intermediate_results_dir_2 

