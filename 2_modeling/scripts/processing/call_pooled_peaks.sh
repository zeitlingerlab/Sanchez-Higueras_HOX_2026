#!/bin/bash
ml zeitlinger
cd /n/projects/mw2098/collaboration/for_carlos/20260205_manuscript/2_modeling
macs2 callpeak -f BAM --keep-dup all --nomodel --shift -75 --extsize 150 -t bam/S2_AntHOX1a_PBX_Flag_nexus_combined.bam --outdir macs2 -n S2_AntHOX1a_PBX_Flag_nexus
macs2 callpeak -f BAM --keep-dup all --nomodel --shift -75 --extsize 150 -t bam/S2_AntHOX1a_PBX_HA_nexus_combined.bam --outdir macs2 -n S2_AntHOX1a_PBX_HA_nexus
macs2 callpeak -f BAM --keep-dup all --nomodel --shift -75 --extsize 150 -t bam/S2_AntHOX6a_PBX_Flag_nexus_combined.bam --outdir macs2 -n S2_AntHOX6a_PBX_Flag_nexus
macs2 callpeak -f BAM --keep-dup all --nomodel --shift -75 --extsize 150 -t bam/S2_AntHOX6a_PBX_HA_nexus_combined.bam --outdir macs2 -n S2_AntHOX6a_PBX_HA_nexus
macs2 callpeak -f BAM --keep-dup all --nomodel --shift -75 --extsize 150 -t bam/S2_Dfd_Hth_HA_nexus_combined.bam --outdir macs2 -n S2_Dfd_Hth_HA_nexus
