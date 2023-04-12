#! /bin/bash
#BSUB -J filter
#BSUB -q normal

#BSUB -M 30000 -R "rusage[mem=30000] "
#BSUB -n 1
#BSUB -o filter_output.txt
#BSUB -e filter_error.txt


#gatk --java-options "-Xmx20G" SelectVariants \
#  -R /netscratch/dep_mercier/grp_novikova/Fragaria/ref/Fragaria_vesca_v4.0.a1.fa \
#  -V /netscratch/dep_mercier/grp_novikova/Fragaria/map/Fragaria_final.GTT.ann.vcf \
#  --select-type-to-include SNP \
#  --restrict-alleles-to BIALLELIC \
#  -O /netscratch/dep_mercier/grp_novikova/Fragaria/map/Fragaria_final.GTT.ann.BIALLELICSNP.vcf

vcftools  --vcf /netscratch/dep_mercier/grp_novikova/Fragaria/map/Fragaria_final.GTT.vcf \
          --positions /netscratch/dep_mercier/grp_novikova/Fragaria/map/4fds_position.list \
          --out /netscratch/dep_mercier/grp_novikova/Fragaria/map/Fragaria_final.GTT.vcftls.vcf
