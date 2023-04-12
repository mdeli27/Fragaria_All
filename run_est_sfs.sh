#! /bin/bash
#BSUB -J sfs
#BSUB -q normal
#BSUB -M 30000 -R "rusage[mem=30000] "
#BSUB -n 1
#BSUB -o sfs_output.txt
#BSUB -e sfs_error.txt

allele_n=44
snp_vcf="Nkunapalari_filt.snps.vcf.gz"
prefix="Nkunapalari_filt"
n_samples=11

####outgroup1 - column number 127 sample 183 
####outgroup2 - columnn number 104 sample 184
#Change column numbers!
bcftools view -H ${snp_vcf} | cut -f 4,5,21 | sed 's/:[0123456789,\._ATGC\|]*//g' | sed 's/\t/,/g' |  awk -F, '{am=0;tm=0;gm=0;cm=0;as=0;ts=0;gs=0;cs=0;af=0;tf=0;gf=0;cf=0; if($1 ~ /[aA]/)  am=gsub(/0/,"");if($1 ~ /[tT]/) tm=gsub(/0/,"");if($1 ~ /[gG]/) gm=gsub(/0/,"");if($1 ~ /[cC]/) cm=gsub(/0/,""); if($2 ~ /[aA]/)  am=gsub(/1/,"");if($2 ~ /[tT]/) tm=gsub(/1/,"");if($2 ~ /[gG]/) gm=gsub(/1/,"");if($2 ~ /[cC]/) cm=gsub(/1/,""); printf "%d,%d,%d,%d\n", am,cm,gm,tm }' > ${prefix}_outgr_sfs 


bcftools view -H ${snp_vcf} | cut -f 4,5,10,11,12,13,14,15,16,17,18,19,20 | sed 's/:[0123456789,\._ATGC\|]*//g' | sed 's/\t/,/g' |  awk -F, '{am=0;tm=0;gm=0;cm=0;as=0;ts=0;gs=0;cs=0;af=0;tf=0;gf=0;cf=0; if($1 ~ /[aA]/)  am=gsub(/0/,"");if($1 ~ /[tT]/) tm=gsub(/0/,"");if($1 ~ /[gG]/) gm=gsub(/0/,"");if($1 ~ /[cC]/) cm=gsub(/0/,""); if($2 ~ /[aA]/)  am=gsub(/1/,"");if($2 ~ /[tT]/) tm=gsub(/1/,"");if($2 ~ /[gG]/) gm=gsub(/1/,"");if($2 ~ /[cC]/) cm=gsub(/1/,""); printf "%d,%d,%d,%d\n", am,cm,gm,tm }' > ${prefix}_sfs_snps 


sed 's/1/0/g' ${prefix}_outgr_sfs | sed 's/2/1/' > ${prefix}_outgr_sfs2
#Need to check if works
paste ${prefix}_sfs_snps ${prefix}_outgr_sfs2  | sed -E 's/[[:space:]]+/ /g' | awk -F [,\ ] '{if ($1 + $2 + $3 + $4 == '"$allele_n"') {print $1","$2","$3","$4" "$5","$6","$7","$8 } }' > ${prefix}_var.input
grep -v 0,0,0,0 ${prefix}_var.input | grep -v $allele_n > ${prefix}_var_small.input
/netscratch/dep_mercier/grp_novikova/software/est-sfs-release-2.04/est-sfs est_config ${prefix}_var_small.input seed-file.txt ${prefix}_sfs.txt ${prefix}-pvalues.txt
