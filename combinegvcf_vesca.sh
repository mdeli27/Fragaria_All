#! /bin/bash
#BSUB -J combine_Fvb7
#BSUB -q multicore20
#BSUB -M 80000 -R "rusage[mem=80000]"
#BSUB -n 6
#BSUB -o Fvb7_%J_output.txt
#BSUB -e Fvb7_%J_error.txt


echo "STARTING JOB"

num=${LSB_JOBINDEX}
ref=/netscratch/dep_mercier/grp_novikova/Fragaria/ref/Fragaria_vesca_v4.0.a1
vcf=/netscratch/dep_mercier/grp_novikova/Fragaria/new_map/vcf_Ticao
out=/netscratch/dep_mercier/grp_novikova/Fragaria/new_map

gatk --java-options "-Xmx75G" CombineGVCFs \
   	-R ${ref}.fa \
	--variant ${vcf}/N.5-1.g.vcf.gz \
	--variant ${vcf}/N.21-7.g.vcf.gz \
	--variant ${vcf}/N.18-2.g.vcf.gz \
	--variant ${vcf}/N.1-6.g.vcf.gz \
	--variant ${vcf}/N.7-6.g.vcf.gz \
	--variant ${vcf}/N.1-7.g.vcf.gz \
	--variant ${vcf}/N.14-7.g.vcf.gz \
	--variant ${vcf}/N.15-8.g.vcf.gz \
	--variant ${vcf}/N.42-6.g.vcf.gz \
	--variant ${vcf}/N.02-7.g.vcf.gz \
	--variant ${vcf}/N.42-8.g.vcf.gz \
	--variant ${vcf}/N.15-2.g.vcf.gz \
	--variant ${vcf}/N.02-4.g.vcf.gz \
	--variant ${vcf}/N.02-6.g.vcf.gz \
	--variant ${vcf}/N.05-15.g.vcf.gz \
	--variant ${vcf}/N.06-1.g.vcf.gz \
	--variant ${vcf}/N.06-4.g.vcf.gz \
	--variant ${vcf}/N.06-6.g.vcf.gz \
	--variant ${vcf}/N.06-7.g.vcf.gz \
	--variant ${vcf}/N.06-10.g.vcf.gz \
	--variant ${vcf}/N.06-15.g.vcf.gz \
	--variant ${vcf}/N.03-4.g.vcf.gz \
	--variant ${vcf}/N.46-5.g.vcf.gz \
	--variant ${vcf}/N.03-5.g.vcf.gz \
	--variant ${vcf}/N.02-1.g.vcf.gz \
	--variant ${vcf}/N.42-10.g.vcf.gz \
	--variant ${vcf}/N.8-8.g.vcf.gz \
	--variant ${vcf}/N.9-8.g.vcf.gz \
	--variant ${vcf}/N.47-7.g.vcf.gz \
	--variant ${vcf}/N.22-10.g.vcf.gz \
	--variant ${vcf}/N.44-8.g.vcf.gz \
	--variant ${vcf}/N.03-6.g.vcf.gz \
	--variant ${vcf}/N.47-4.g.vcf.gz \
	--variant ${vcf}/N.43-8.g.vcf.gz \
	--variant ${vcf}/N.45-3.g.vcf.gz \
	--variant ${vcf}/N.02-3.g.vcf.gz \
	--variant ${vcf}/N.03-10.g.vcf.gz \
	--variant ${vcf}/N.17-4.g.vcf.gz \
	--variant ${vcf}/N.44-5.g.vcf.gz \
	--variant ${vcf}/N.11-4.g.vcf.gz \
	--variant ${vcf}/N.7-1.g.vcf.gz \
	--variant ${vcf}/N.6-6.g.vcf.gz \
	--variant ${vcf}/N.16-3.g.vcf.gz \
	-L Fvb7 \
	-O ${out}/Combine_4species_Fvb7.g.vcf.gz


echo "FINISHED JOB"

# Submit with bsub < BSUB_TEMPLATE.sh
# Check status with bjobs
# Check output during run with bpeek JOBID
