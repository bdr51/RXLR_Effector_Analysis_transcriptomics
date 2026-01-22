#!/bin/bash
#SBATCH -J createWorkSpace
#SBATCH --mem 1M
#SBATCH --cpus-per-task 1
#SBATCH -o %x.%j.out
#SBATCH -e %x.%j.err

export PATH="/opt/homebrew/anaconda3/envs/rosetta/bin:$PATH"
export DYLD_LIBRARY_PATH=/usr/local/Cellar/gcc/14.2.0_1/lib/gcc/14:$DYLD_LIBRARY_PATH
 
#READ1=/Users/breedrinkwater/Desktop/Phytopthora/processed_data/trimmed_reads/trimmed_R1.fastq
#READ2=/Users/breedrinkwater/Desktop/Phytopthora/processed_data/trimmed_reads/trimmed_R2.fastq
#OUTPUT=/Users/breedrinkwater/Desktop/Phytopthora/processed_data/trinity_assembly

CPU=1
READ1=$1
READ2=$2
OUTPUT=$3/trinity
echo "Trinity output directory is: $OUTPUT"

#conda init
#conda activate rosetta


Trinity --seqType fq \
        --max_memory 50G \
	--left $READ1 \
	--right $READ2 \
	--CPU $CPU \
	--output $OUTPUT


