#! /bin/bash
#BSUB -J gunzip
#BSUB -q normal
#BSUB -M 10000 -R "rusage[mem=10000] "
#BSUB -n 1
#BSUB -o gunzip_output.txt
#BSUB -e gunzip_error.txt


cd /netscratch/dep_mercier/grp_novikova/Fragaria/new_map

gzip -c Fragaria_final.GT.filter.4fds.vcf  > Fragaria_final.GT.filter.4fds.vcf.gz
