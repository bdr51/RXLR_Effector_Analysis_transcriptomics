
## Phytophthora pluvialis RNA-Seq and RXLR Effector Analysis

This repository contains the scripts used for RNA-Seq processing, transcriptome assembly, RXLR effector identification, and differential expression analysis of *Phytophthora pluvialis* in resistant and susceptible *Pinus radiata* clones. The analysis compares pathogen-infected versus control samples at multiple time points.

## Overview

Two main pipelines were conducted in this study:

1. **Transcriptome Assembly and Quantification Pipeline**

   * Raw RNA-Seq reads were quality-checked, trimmed, assembled into transcripts, clustered to remove redundancy, and quantified.
   * Tools used include:

     * FastQC (v0.12.1) – quality control
     * Cutadapt (v5.0) – adapter trimming and filtering
     * Trinity (v2.15.2) – transcriptome assembly
     * MMseqs2 – clustering similar transcripts
     * Salmon (v1.10.3) – transcript quantification
     * DESeq2 (v1.47.5) – differential expression analysis in R

2. **RXLR Effector Identification and Differential Expression Pipeline**

   * Reads were aligned to an RXLR effector database using DIAMOND BLASTX, filtered for high-confidence matches, and analyzed for differential expression.
   * DESeq2 in R was used to compare effector expression between resistant and susceptible clones over multiple time points.

## File Structure

Only `.sh` and `.Rmd` scripts are included here.

### Shell Scripts (`.sh`)

| Script                                  | Description                                                                  | Output                              |
| --------------------------------------- | ---------------------------------------------------------------------------- | ----------------------------------- |
| `Trinity.sh`                            | Runs Trinity on individual paired-end reads for transcriptome assembly.      | `*.Trinity.fasta`                   |
| `combined.sh`                           | Combines Trinity-assembled transcriptomes into a single FASTA file.          | `all_trinity_assemblies.fasta`      |
| `cluster.sh`                            | Automates clustering of transcripts using MMseqs2 to remove redundancy.      | `representative_sequences.fasta`    |
| `salmon_quant.sh`                       | Runs Salmon to quantify transcript abundance against the combined reference. | `quant_output/`                     |
| `cutadapt.sh`                           | Trims adapters and filters low-quality sequences from RNA-Seq reads.         | Trimmed reads                       |
| `forloop.sh`                            | Loops through all paired-end reads for trimming with Cutadapt.               | Trimmed reads                       |
| `fastQC.sh`                             | Performs quality checks on raw and trimmed reads using FastQC.               | QC reports                          |
| `mmseqs.sh`                             | Runs MMseqs2 clustering pipeline for assembled transcripts.                  | Clustered transcripts               |
| `raw_read_effectors/reads_effectors.sh` | Performs DIAMOND BLASTX of RNA-Seq reads against RXLR effector database.     | `raw_read_effectors/blast_results/` |

### R Markdown Scripts (`.Rmd`)

| Script                                   | Description                                                         | Output                                                                 |
| ---------------------------------------- | ------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| `Effectors.rmd`                          | Differential expression analysis of RXLR effector proteins.         | Tables and plots of effector up/down regulation                        |
| `assemblies_differential-expression.rmd` | Differential expression analysis using the assembled transcriptome. | Tables and visualizations of up/down regulated genes in *P. pluvialis* |

## Usage

1. **Shell Scripts**

   * Ensure you have all dependencies installed (FastQC, Cutadapt, Trinity, MMseqs2, Salmon, DIAMOND).
   * Execute scripts in the order required by your pipeline (trimming → QC → assembly → clustering → quantification → BLASTX).

   Example:

   ```bash
   bash cutadapt.sh
   bash fastQC.sh
   bash Trinity.sh
   bash combined.sh
   bash mmseqs.sh
   bash salmon_quant.sh
   bash raw_read_effectors/reads_effectors.sh
   ```

2. **R Markdown Scripts**

   * Open the `.Rmd` files in RStudio or another R environment.
   * Ensure all required R packages are installed (DESeq2, tidyverse, etc.).
   * Run all code chunks to generate tables and visualisations.

## Data and Metadata

* RNA-Seq data consists of two clones of *P. radiata*:

  * Clone 06 (resistant)
  * Clone 41 (susceptible)
* Samples were collected at four time points: T0, T1, T3, T5
* Treatments: pathogen (*P. pluvialis*) or control (water)
* Three replicates per condition

Metadata and reference files (not included in this repo) are required for running the analyses.

## References

* FastQC: [https://www.bioinformatics.babraham.ac.uk/projects/fastqc/](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
* Cutadapt: [https://cutadapt.readthedocs.io](https://cutadapt.readthedocs.io)
* Trinity: [https://github.com/trinityrnaseq/trinityrnaseq](https://github.com/trinityrnaseq/trinityrnaseq)
* MMseqs2: [https://github.com/soedinglab/mmseqs2](https://github.com/soedinglab/mmseqs2)
* Salmon: [https://salmon.readthedocs.io](https://salmon.readthedocs.io)
* DIAMOND BLASTX: [https://github.com/bbuchfink/diamond](https://github.com/bbuchfink/diamond)
* DESeq2: [https://bioconductor.org/packages/DESeq2/](https://bioconductor.org/packages/DESeq2/)
