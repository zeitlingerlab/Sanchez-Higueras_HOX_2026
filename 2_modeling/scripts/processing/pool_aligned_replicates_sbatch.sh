#!/bin/bash
#SBATCH --job-name=mw2098-2026-03-02
#SBATCH --nodes=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=200GB
#SBATCH --output=mw2098-2026-03-02.out

#!/bin/bash
ml zeitlinger
cd /n/projects/mw2098/collaboration/for_carlos/20260205_manuscript/2_modeling
samtools merge --threads 12 bam/S2_AntHOX1a_PBX_Flag_nexus_combined.bam ../1_processing/bam/S2_AntHOX1a_PBX_Flag_nexus_1.bam ../1_processing/bam/S2_AntHOX1a_PBX_Flag_nexus_2.bam
samtools merge --threads 12 bam/S2_AntHOX1a_PBX_HA_nexus_combined.bam ../1_processing/bam/S2_AntHOX1a_PBX_HA_nexus_1.bam ../1_processing/bam/S2_AntHOX1a_PBX_HA_nexus_2.bam
samtools merge --threads 12 bam/S2_AntHOX6a_PBX_Flag_nexus_combined.bam ../1_processing/bam/S2_AntHOX6a_PBX_Flag_nexus_1.bam ../1_processing/bam/S2_AntHOX6a_PBX_Flag_nexus_2.bam
samtools merge --threads 12 bam/S2_AntHOX6a_PBX_HA_nexus_combined.bam ../1_processing/bam/S2_AntHOX6a_PBX_HA_nexus_1.bam ../1_processing/bam/S2_AntHOX6a_PBX_HA_nexus_2.bam
samtools merge --threads 12 bam/S2_Dfd_Hth_HA_nexus_combined.bam ../1_processing/bam/S2_Dfd_Hth_HA_nexus_1.bam ../1_processing/bam/S2_Dfd_Hth_HA_nexus_2.bam
