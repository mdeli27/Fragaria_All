#! /bin/bash
#BSUB -J makeRef
#BSUB -q normal
#BSUB -M 10000 -R "rusage[mem=10000] "
#BSUB -n 1
#BSUB -o makeref_output.txt
#BSUB -e makeref_error.txt



cd //biodata/dep_mercier/grp_novikova/A.Lyrata/ref/Alyrata/new_MN47_assembly/final_MN47
ref='MN47_220222.fasta'
java -jar ${PICARD_HOME}/picard.jar CreateSequenceDictionary R=${ref} O=${ref}.dict
bwa index ${ref}
samtools faidx ${ref}

