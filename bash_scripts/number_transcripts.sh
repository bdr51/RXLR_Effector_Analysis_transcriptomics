#!/bin/bash

for i in $(seq -w 1 36); do
  fasta="${i}.mapped.trinity/trinity.Trinity.fasta"
  if [[ -f "$fasta" ]]; then
    count=$(grep -c "^>" "$fasta")
    echo "$i: $count transcripts"
total=$((total + count))

  else
    echo "$i: missing fasta file"
  fi
done

echo "Total transcripts across all samples: $total"
