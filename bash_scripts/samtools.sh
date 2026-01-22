#!/bin/bash

# Define file paths

#BAM_OUTPUT="aligned_reads.bam"
#SORTED_BAM="sorted_reads.bam"
#REFERENCE="/Users/breedrinkwater/Desktop/Phytopthora/processed_data/trinity_assembly.Trinity.fasta"
#OUTPUT_STATS="alignment_stats.txt"

OUTPUT=$3/trinity
BWA_OUTPUT=${OUTPUT}/aligned_output.sam
BAM_OUTPUT="${OUTPUT}/aligned_reads.bam"
SORTED_BAM="${OUTPUT}/sorted_reads.bam"
OUTPUT_STATS="alignment_stats.txt"


# Step 1: Convert SAM to BAM
samtools view -bS $BWA_OUTPUT > $BAM_OUTPUT

# Step 2: Sort the BAM file
samtools sort $BAM_OUTPUT -o $SORTED_BAM

# Step 3: Index the sorted BAM file
samtools index $SORTED_BAM

# Step 4: Generate alignment statistics
samtools flagstat $SORTED_BAM > $OUTPUT_STATS

# Step 5: Making a coverage report 
samtools depth $SORTED_BAM > coverage_report.txt

# completion message
echo "Samtools pipeline completed. Output files:"
echo "- BAM file: $BAM_OUTPUT"
echo "- Sorted BAM file: $SORTED_BAM"
echo "- Alignment stats: $OUTPUT_STATS"
echo "- Coverage report: coverage_report.txt"
# Uncomment below if gene count output is included
# echo "- Gene read counts: gene_read_counts.txt"

