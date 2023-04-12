#! /bin/bash
#BSUB -J sfs[1]
#BSUB -q normal
#BSUB -M 2000 -R "rusage[mem=2000] "
#BSUB -n 1
#BSUB -o sfs_%I_%J_output.txt
#BSUB -e sfs_%I_%J_error.txt

intervals='/netscratch/dep_mercier/grp_novikova/Fragaria/ref/intervals' #7

#source ~/.profile
#conda init bash
#conda activate py2

num=$(($i+${LSB_JOBINDEX}))
export l=$num\p
chr=`sed -n $l $intervals | cut -f1`
st=1
end=`sed -n $l $intervals | cut -f2`
python2 /biodata/dep_mercier/grp_novikova/scripts_backup/Mdelibas/Inputsfs.py -d /netscratch/dep_mercier/grp_novikova/Fragaria/new_map -f Fragaria_final.GT.vcf.gz.colnames -v Fragaria_final.GT.vcf.gz.colnames.pop2 -c $chr -s $st -e $end -n $num -D /netscratch/dep_mercier/grp_novikova/Fragaria/new_map/sfs

