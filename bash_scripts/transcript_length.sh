#!/bin/bash

echo "Sample,Transcript Count,Min Length,Max Length,Average Length" > transcript_lengths_summary.csv

for i in $(seq -w 1 36); do
  fasta="${i}.mapped.trinity/trinity.Trinity.fasta"
  
  if [[ -f "$fasta" ]]; then
    # Use awk to calculate transcript lengths
    awk '
    /^>/ {
      if (seqlen > 0) {
        print seqlen
      }
      seqlen=0
      next
    }
    {
      seqlen += length($0)
    }
    END {
      if (seqlen > 0) {
        print seqlen
      }
    }' "$fasta" > lengths.tmp

    count=$(wc -l < lengths.tmp)
    min=$(sort -n lengths.tmp | head -n 1)
    max=$(sort -n lengths.tmp | tail -n 1)
    avg=$(awk '{ sum += $1 } END { if (NR > 0) print int(sum / NR + 0.5) }' lengths.tmp)

    echo "$i,$count,$min,$max,$avg" >> transcript_lengths_summary.csv
  else
    echo "$i,missing" >> transcript_lengths_summary.csv
  fi
done

rm -f lengths.tmp

