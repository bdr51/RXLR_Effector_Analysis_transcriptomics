#!/bin/bash
#SBATCH -J createWorkSpace
#SBATCH --mem 1M
#SBATCH --cpus-per-task 1
#SBATCH -o %x.%j.out
#SBATCH -e %x.%j.err

#bwa mem /Users/breedrinkwater/Desktop/Phytopthora/processed_data/trinity_assembly.Trinity.fasta /Users/breedrinkwater/Desktop/Phytopthora/processed_data/trimmed_reads/trimmed_R1.fastq /Users/breedrinkwater/Desktop/Phytopthora/processed_data/trimmed_reads/trimmed_R2.fastq > aligned_output.sam

# Arguments from the cutadapt script
TRIMMED_1=`basename ${1%.fastq.gz}.trim.fastq`
TRIMMED_2=`basename ${2%.fastq.gz}.trim.fastq`
OUTPUT=$3/trinity



# Run BWA index on Trinity assembly file located in the specified OUTPUT directory
bwa index $OUTPUT

# Run BWA mem for alignment
bwa mem $OUTPUT \
$TRIMMED_1 $TRIMMED_2 > $OUTPUT/aligned_output.sam
