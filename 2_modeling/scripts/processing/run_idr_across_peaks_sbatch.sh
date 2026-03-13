#!/bin/bash
#SBATCH --job-name=mw2098-2026-03-03
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50GB
#SBATCH --output=mw2098-2026-03-03.out

#!/bin/bash
source ~/.bashrc; conda deactivate; conda activate idr
cd /n/projects/mw2098/collaboration/for_carlos/20260205_manuscript/2_modeling
~/anaconda3/envs/idr/bin/idr --peak-list macs2/S2_AntHOX6a_PBX_Flag_nexus_peaks.narrowPeak --samples ../1_processing/peaks/S2_AntHOX6a_PBX_Flag_nexus_1_peaks.narrowPeak ../1_processing/peaks/S2_AntHOX6a_PBX_Flag_nexus_2_peaks.narrowPeak --idr-threshold 0.05 --input-file-type narrowPeak --output-file idr/S2_AntHOX6a_PBX_Flag_nexus_1_vs_2_idr.txt
~/anaconda3/envs/idr/bin/idr --peak-list macs2/S2_AntHOX6a_PBX_HA_nexus_peaks.narrowPeak --samples ../1_processing/peaks/S2_AntHOX6a_PBX_HA_nexus_1_peaks.narrowPeak ../1_processing/peaks/S2_AntHOX6a_PBX_HA_nexus_2_peaks.narrowPeak --idr-threshold 0.05 --input-file-type narrowPeak --output-file idr/S2_AntHOX6a_PBX_HA_nexus_1_vs_2_idr.txt
~/anaconda3/envs/idr/bin/idr --peak-list macs2/S2_Dfd_Hth_HA_nexus_peaks.narrowPeak --samples ../1_processing/peaks/S2_Dfd_Hth_HA_nexus_1_peaks.narrowPeak ../1_processing/peaks/S2_Dfd_Hth_HA_nexus_2_peaks.narrowPeak --idr-threshold 0.05 --input-file-type narrowPeak --output-file idr/S2_Dfd_Hth_HA_nexus_1_vs_2_idr.txt
~/anaconda3/envs/idr/bin/idr --peak-list macs2/S2_AntHOX1a_PBX_Flag_nexus_peaks.narrowPeak --samples ../1_processing/peaks/S2_AntHOX1a_PBX_Flag_nexus_1_peaks.narrowPeak ../1_processing/peaks/S2_AntHOX1a_PBX_Flag_nexus_2_peaks.narrowPeak --idr-threshold 0.05 --input-file-type narrowPeak --output-file idr/S2_AntHOX1a_PBX_Flag_nexus_1_vs_2_idr.txt
~/anaconda3/envs/idr/bin/idr --peak-list macs2/S2_AntHOX1a_PBX_HA_nexus_peaks.narrowPeak --samples ../1_processing/peaks/S2_AntHOX1a_PBX_HA_nexus_1_peaks.narrowPeak ../1_processing/peaks/S2_AntHOX1a_PBX_HA_nexus_2_peaks.narrowPeak --idr-threshold 0.05 --input-file-type narrowPeak --output-file idr/S2_AntHOX1a_PBX_HA_nexus_1_vs_2_idr.txt
