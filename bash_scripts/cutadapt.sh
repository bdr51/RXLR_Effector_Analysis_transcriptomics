cd /Users/breedrinkwater/Desktop/Phytopthora/processed_data
#!/bin/bash
#SBATCH -J createWorkSpace
#SBATCH --mem 1M
#SBATCH --cpus-per-task 1
#SBATCH -o %x.%j.out
#SBATCH -e %x.%j.err


INPUT_1=$1
INPUT_2=$2
TRIMMED_1=`basename ${1%.fastq.gz}.trim.fastq`
TRIMMED_2=`basename ${2%.fastq.gz}.trim.fastq`
#ANALYSIS_FOLDER_trinity=${TRIMMED_1%.sorted_R1.paired.trim.fastq}
#ANALYSIS_FOLDER_trinity="${TRIMMED_1%.sorted_R1.paired.trim.fastq}"
ANALYSIS_FOLDER="${TRIMMED_1%.sorted_R1.paired.trim.fastq}.trinity"

mkdir $ANALYSIS_FOLDER

echo "Using output directory: $ANALYSIS_FOLDER"

echo $INPUT_1
echo $INPUT_2
echo $TRIMMED_1
echo $TRIMMED_2
echo $ANALYSIS_FOLDER
echo "Current directory: $(pwd)"

  
cutadapt -u 12 -U 12 -o $ANALYSIS_FOLDER/$TRIMMED_1 -p $ANALYSIS_FOLDER/$TRIMMED_2 $INPUT_1 $INPUT_2 

sh /Users/breedrinkwater/Desktop/Phytopthora/processed_data/trinity.sh $ANALYSIS_FOLDER/$TRIMMED_1 $ANALYSIS_FOLDER/$TRIMMED_2 $ANALYSIS_FOLDER

#sh /Users/breedrinkwater/Desktop/Phytopthora/processed_data/bwa_mem.sh $ANALYSIS_FOLDER/$TRIMMED_1 $ANALYSIS_FOLDER/$TRIMMED_2 $ANALYSIS_FOLDER

#sh /Users/breedrinkwater/Desktop/Phytopthora/processed_data/samtools.sh $ANALYSIS_FOLDER/$TRIMMED_1 $ANALYSIS_FOLDER/$TRIMMED_2 $ANALYSIS_FOLDER
