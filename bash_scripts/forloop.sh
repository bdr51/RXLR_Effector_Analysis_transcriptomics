#!/bin/bash

# Directory containing the input files
INPUT_DIR="/Users/breedrinkwater/Desktop/Phytopthora"
SCRIPT="/Users/breedrinkwater/Desktop/Phytopthora/processed_data/cutadapt.sh"

# Find all paired-end files (R1 and R2)
for R1_FILE in $INPUT_DIR/*_R1.paired.fastq.gz; do
    # Derive the R2 file name based on R1 file
    R2_FILE="${R1_FILE/_R1.paired.fastq.gz/_R2.paired.fastq.gz}"
    
    # Check if the R2 file exists
    if [[ -f "$R2_FILE" ]]; then
        echo "Processing files: $R1_FILE and $R2_FILE"
        
        # Run the cutadapt script
        bash $SCRIPT "$R1_FILE" "$R2_FILE"
    else
        echo "Warning: Missing R2 file for $R1_FILE"
    fi
done

