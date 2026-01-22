#SBATCH -J createWorkSpace
#SBATCH --mem 1M
#SBATCH --cpus-per-task 1
#SBATCH -o %x.%j.out
#SBATCH -e %x.%j.err

bwa index /Users/breedrinkwater/Desktop/Phytopthora/processed_data/trinity_assembly.Trinity.fasta
