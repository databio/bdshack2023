#!/bin/bash
#SBATCH -A BDSHackathon 
#SBATCH -J jobname
#SBATCH -o out_file
#SBATCH -e err_file
#SBATCH -p standard
#SBATCH -c 1

# Step 1
#load programs
module load gcc/7.1.0 bowtie2/2.2.9 samtools openmpi/3.1.4 rsem

# Step 2
# commands for running the program
REF="/home/aca9pw/ref/grcm38_cDNA_ERCC/grcm38_ercc_rsem"

rsem-calculate-expression -p 1 --bowtie2 --single-cell-prior --paired-end /scratch/aca9pw/janes_lab/ray_scRNA/2-trim/19152-L_R1.trim.fastq.gz /scratch/aca9pw/janes_lab/ray_scRNA/2-trim/19152-L_R2.trim.fastq.gz $REF ./3-rsem/19152-L



