#!/bin/bash

# Set variables for input and output
INPUT_FASTA="combined.fasta"
RNA_DB="rna_db"
CLUSTER_RESULT="resultDB_clu"
TEMP_DIR="resultDB_tmp"
REPRESENTATIVE_DB="representativeDB"
OUTPUT_FASTA="representative_sequences.fasta"

# Function to check command status and print a message
check_status() {
    if [ $? -eq 0 ]; then
        echo "$1 completed successfully."
    else
        echo "$1 failed. Exiting script."
        exit 1
    fi
}

# Create the database
mmseqs createdb $INPUT_FASTA $RNA_DB
check_status "Database creation"

# Perform clustering with specified memory and threads
mmseqs cluster $RNA_DB $CLUSTER_RESULT $TEMP_DIR --split-memory-limit 2G --threads 1 -k 13
check_status "Clustering"

# Create a subdatabase with representative sequences
mmseqs createsubdb $CLUSTER_RESULT $RNA_DB $REPRESENTATIVE_DB
check_status "Subdatabase creation"

# Convert the representative database to FASTA format
mmseqs convert2fasta $REPRESENTATIVE_DB $OUTPUT_FASTA
check_status "FASTA conversion"

