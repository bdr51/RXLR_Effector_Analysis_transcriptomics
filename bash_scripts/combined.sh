#!/bin/bash

# Set paths to input FASTA files and output variables
TRINITY_FASTA="../01.mapped.trinity/trinity.Trinity.fasta"
TARGET_FASTA="../Ppluv_combine.fasta"
COMBINED_FASTA="combined.fasta"
COMBINED_DB="combined_db"

# Check if input files exist
if [[ ! -f "$TRINITY_FASTA" ]]; then
  echo "Error: $TRINITY_FASTA not found!"
  exit 1
fi

if [[ ! -f "$TARGET_FASTA" ]]; then
  echo "Error: $TARGET_FASTA not found!"
  exit 1
fi

# Combine the two FASTA files
echo "Combining $TRINITY_FASTA and $TARGET_FASTA into $COMBINED_FASTA..."
cat "$TRINITY_FASTA" "$TARGET_FASTA" > "$COMBINED_FASTA"

# Check if the combined FASTA file was created
if [[ ! -f "$COMBINED_FASTA" ]]; then
  echo "Error: Failed to create combined FASTA file!"
  exit 1
fi

# Create the MMseqs database
echo "Creating MMseqs database $COMBINED_DB from $COMBINED_FASTA..."
mmseqs createdb "$COMBINED_FASTA" "$COMBINED_DB" --dbtype 2

# Check if the database was created successfully
if [[ $? -eq 0 ]]; then
  echo "MMseqs database $COMBINED_DB created successfully!"
else
  echo "Error: Failed to create MMseqs database!"
  exit 1
fi

