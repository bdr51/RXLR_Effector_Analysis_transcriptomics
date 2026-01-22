fastQC_phyto.sbatch#!/bin/bash
#SBATCH -J createWorkSpace
#SBATCH --mem 1M
#SBATCH --cpus-per-task 1
#SBATCH -o %x.%j.out
#SBATCH -e %x.%j.err


# Specify the output directory
OUTPUT_DIR="processed_data"

# Create the output directory if it doesn't exist
mkdir -p $OUTPUT_DIR

# Run FastQC on both R1 and R2 files
fastqc /Users/breedrinkwater/Desktop/Phytopthora/02.mapped.sorted_R1.paired.fastq.gz -o $OUTPUT_DIR
fastqc /Users/breedrinkwater/Desktop/Phytopthora/02.mapped.sorted_R2.paired.fastq.gz -o $OUTPUT_DIR
