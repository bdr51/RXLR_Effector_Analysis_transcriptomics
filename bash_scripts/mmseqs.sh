!/bin/bash

# Script paths and files
TRINITY_FASTA="trinity.Trinity.fasta"
TARGET_FASTA="/Users/breedrinkwater/Desktop/Phytopthora/processed_data/Ppluv_combine.fasta"

OUTPUT_DIR="/Users/breedrinkwater/Desktop/Phytopthora/processed_data"
TRINITY_DB="${OUTPUT_DIR}/trinity_db"
TARGET_DB="${OUTPUT_DIR}/target_db"
OUTPUT_DB="${OUTPUT_DIR}/output_db"
TMP_DIR="${OUTPUT_DIR}/tmp"
COMBINED_DB="${OUTPUT_DIR}/combined_db"

#Creating index for rep
mmseqs createindex "$OUTPUT_DB/rep" "$TMP_DIR/rep.index"

#Creating the combined database
mmseqs createdb "$TRINITY_FASTA" "$TARGET_FASTA" "$COMBINED_DB" --dbtype 2

#Perform clustering on the combined database
mmseqs cluster "$COMBINED_DB" "$OUTPUT_DB/pear" --min-seq-id 0.9 -c 0.8 --split-memory-limit 2G --$

#Map Trinity database to Target database
mmseqs map "$TRINITY_DB" "$TARGET_DB" "$OUTPUT_DB" "$TMP_DIR" --threads 8 --target-search-mode 1


