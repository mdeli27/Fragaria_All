#! /bin/bash
#BSUB -J filter
#BSUB -q normal
#BSUB -M 30000 -R "rusage[mem=30000] "
#BSUB -n 1
#BSUB -o 1filter_output.txt
#BSUB -e 1filter_error.txt

gatk --java-options "-Xmx20G" SelectVariants \
   -R /netscratch/dep_mercier/grp_novikova/Fragaria/ref/Fragaria_vesca_v4.0.a1.fa \
   -V /netscratch/dep_mercier/grp_novikova/Fragaria/new_map/Fragaria_final.GT.ann.vcf \
   --select-type-to-include SNP \
   --restrict-alleles-to BIALLELIC \
   --output /netscratch/dep_mercier/grp_novikova/Fragaria/new_map/Fragaria_final.GT.filter.BIALLELICSNP.vcf.gz

#vcftools  --vcf /netscratch/dep_mercier/grp_novikova/Fragaria/map/Fragaria_final.GTT.vcf \
#          --positions /netscratch/dep_mercier/grp_novikova/Fragaria/map/4fds_position.list \
#          --out /netscratch/dep_mercier/grp_novikova/Fragaria/map/Fragaria_final.GTT.vcftls.vcf
