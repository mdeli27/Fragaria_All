#/bin/bash
#BSUB -J mapV[46]
#BSUB -q multicore20
#BSUB -M 20000 -R "rusage[mem=20000] "
#BSUB -n 4
#BSUB -o mapV_%I_%J_output.txt
#BSUB -e mapV_%I_%J_error.txt

samples='/netscratch/dep_mercier/grp_novikova/Fragaria/Fragaria_raw/prep/samples'

echo "STARTING JOB"

num=${LSB_JOBINDEX}\p
acc=`sed -n ${num} ${samples}`
echo ${acc}

#raw='/netscratch/dep_mercier/grp_novikova/Fragaria/Fragaria_raw/prep'
input='/netscratch/dep_mercier/grp_novikova/Fragaria/map_vesca'
out='/netscratch/dep_mercier/grp_novikova/Fragaria/map_vesca/vcf_vesca'
ref='/netscratch/dep_mercier/grp_novikova/Fragaria/ref/Fragaria_vesca_v4.0.a1.fa'
#gunzip -c ${raw}/${acc}_1.paired.fq.gz > ${out}/${acc}_1.fq & gunzip -c ${raw}/${acc}_2.paired.fq.gz > ${out}/${acc}_2.fq
#wait
#bwa mem -t 4 -M -R '@RG\tID:vesca_'${acc}'\tSM:'${acc}'\tPL:Illumina\tLB:vesca_'${acc} ${ref} ${out}/${acc}_1.fq ${out}/${acc}_2.fq > ${out}/${acc}.sam
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
	-I ${input}/${acc}.fixmate.sort.markdup.bam \
	-O ${out}/${acc}.g.vcf.gz \
	-ERC GVCF \
	--sample-ploidy 2 \
	--output-mode EMIT_ALL_CONFIDENT_SITES

#/netscratch/dep_mercier/grp_novikova/software/nQuire/nQuire create -b ${out}/${acc}.fixmate.sort.markdup.bam -o ${out}/${acc}
#/netscratch/dep_mercier/grp_novikova/software/nQuire/nQuire denoise ${out}/${acc}.bin -o ${out}/${acc}_denoised > ${out}/${acc}_denoised_info
#/netscratch/dep_mercier/grp_novikova/software/nQuire/nQuire lrdmodel ${out}/${acc}_denoised.bin > ${out}/${acc}_denoised.bin.lrdmodel
echo "FINISHED JOB"

# Submit with bsub < BSUB_TEMPLATE.sh
# Check status with bjobs
# Check output during run with bpeek JOBID

