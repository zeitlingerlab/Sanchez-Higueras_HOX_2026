#!/bin/bash
#SBATCH --job-name=process_data
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=10gb
#SBATCH --time=120:00:00
#SBATCH --output=slurm_%j.log
source ~/.bashrc
module load zeitlinger
module load star/2.7.3a
ulimit -n 100000
cd /n/projects/mw2098/collaboration/for_carlos/20260205_manuscript/1_processing
snakemake --latency-wait 120 --profile slurm --resources disk_mb=50000
