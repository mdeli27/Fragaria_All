#! /bin/bash
#BSUB -J snpEff
#BSUB -q normal
#BSUB -M 10000 -R "rusage[mem=10000] "
#BSUB -n 1
#BSUB -o 1snpEff_output.txt
#BSUB -e 1snpEff_error.txt


cd /netscratch/dep_mercier/grp_novikova/Fragaria/new_map

#gunzip -c Fragaria_final.GT.vcf.gz > Fragaria_final.GT.vcf

java -Xmx8g -jar /netscratch/dep_mercier/grp_novikova/software/snpEff/snpEff.jar  Fvesca_v4.0.a1 Fragaria_final.GT.vcf > Fragaria_final.GT.ann.vcf

