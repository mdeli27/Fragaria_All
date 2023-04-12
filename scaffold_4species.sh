#/bin/bash
#BSUB -J scaffold
#BSUB -q multicore20
#BSUB -M 40000 -R "rusage[mem=40000] "
#BSUB -n 1
#BSUB -o scaf_%I_%J_output.txt
#BSUB -e scaf_%I_%J_error.txt


input='/netscratch/dep_mercier/grp_novikova/Fragaria/new_map/Ticao_BAM'
out='/netscratch/dep_mercier/grp_novikova/Fragaria/new_map/vcf_Ticao'
ref='/netscratch/dep_mercier/grp_novikova/Fragaria/ref/Fragaria_vesca_v4.0.a1.fa'

gatk --java-options "-Xmx35G" HaplotypeCaller \
  -R ${ref} \
  -I ${input}/${acc}.rmdup.bam \
  -L
  -O ${out}/${acc}.g.vcf.gz \
  
  --output-mode EMIT_ALL_CONFIDENT_SITES
