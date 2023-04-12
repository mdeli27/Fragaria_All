#/bin/bash
#BSUB -J map[51-100]
#BSUB -q multicore20
#BSUB -M 40000 -R "rusage[mem=40000] "
#BSUB -n 1
#BSUB -o map_%I_%J_output.txt
#BSUB -e map_%I_%J_error.txt

samples='/biodata/dep_mercier/grp_novikova/scripts_backup/Mdelibas/samples.txt'

echo "STARTING JOB"

num=${LSB_JOBINDEX}\p
acc=`sed -n ${num} ${samples} | cut -f1`
pl=`sed -n ${num} ${samples} | cut -f2`
echo ${acc}

#raw='/biodata/dep_mercier/grp_novikova/Potamogeton/potamogeton_raw_data_plate1_July2021'
input='/netscratch/dep_mercier/grp_novikova/Fragaria/new_map/Ticao_BAM'
out='/netscratch/dep_mercier/grp_novikova/Fragaria/new_map/vcf_Ticao_chr'
ref='/netscratch/dep_mercier/grp_novikova/Fragaria/ref/Fragaria_vesca_v4.0.a1.fa'
#ref='/netscratch/dep_mercier/grp_novikova/Potamogeton/Christian_assembly/4832_hifiasm_p_ctg_10x_arcs_clean.fa' 
#gunzip -c ${raw}/${acc}_1.fq.gz > ${out}/${acc}_1.fq & gunzip -c ${raw}/${acc}_2.fq.gz > ${out}/${acc}_2.fq
#wait
#bwa mem -t 4 -M -R '@RG\tID:pot_'${acc}'\tSM:'${acc}'\tPL:Illumina\tLB:pot_'${acc} ${ref} ${out}/${acc}_1.fq ${out}/${acc}_2.fq > ${out}/${acc}.sam
#rm ${out}/${acc}_*.fq
#samtools view -bh -t ${ref}.fa.fai -o ${out}/${acc}.bam ${out}/${acc}.sam
#rm ${out}/${acc}.sam 
#samtools fixmate -rm ${out}/${acc}.bam ${out}/${acc}.fixmate.bam
#samtools sort ${out}/${acc}.fixmate.bam -o ${out}/${acc}.fixmate.sort.bam -T ${out}/${acc}_temp
#samtools markdup -rs ${out}/${acc}.fixmate.sort.bam ${out}/${acc}.fixmate.sort.markdup.bam
#samtools index ${out}/${acc}.fixmate.sort.markdup.bam
#rm ${out}/${acc}.fixmate.bam
#rm ${out}/${acc}.fixmate.sort.bam
#rm ${out}/${acc}.bam

#module load goleft/0.2.3
#goleft covstats ${out}/${acc}.fixmate.sort.markdup.bam >${out}/${acc}.covstats

#####Call SNPs
gatk --java-options "-Xmx35G" HaplotypeCaller \
  -R ${ref} \
  -I ${input}/${acc}.rmdup.bam \
  -O ${out}/${acc}.g.vcf.gz \
  -ERC GVCF \
  -L Fvb1 \
  --sample-ploidy ${pl} \
  --output-mode EMIT_ALL_CONFIDENT_SITES

#/netscratch/dep_mercier/grp_novikova/software/nQuire/nQuire create -b ${out}/${acc}.fixmate.sort.markdup.bam -o ${out}/${acc}
#/netscratch/dep_mercier/grp_novikova/software/nQuire/nQuire denoise ${out}/${acc}.bin -o ${out}/${acc}_denoised > ${out}/${acc}_denoised_info
#/netscratch/dep_mercier/grp_novikova/software/nQuire/nQuire lrdmodel ${out}/${acc}_denoised.bin > ${out}/${acc}_denoised.bin.lrdmodel
echo "FINISHED JOB"

# Submit with bsub < BSUB_TEMPLATE.sh
# Check status with bjobs
# Check output during run with bpeek JOBID

