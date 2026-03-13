#!/usr/bin/bash
#SBATCH --array=1-8%15
#SBATCH --job-name=modiscolite
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=70
#SBATCH --mem=100gb
#SBATCH --time=48:00:00
#SBATCH --output=slurm_%j.log
source /home/mw2098/.bashrc
conda deactivate
ml meme
conda activate bpreveal_510
cd /n/projects/mw2098/collaboration/for_carlos/20260205_manuscript/2_modeling
if [[ ${SLURM_ARRAY_TASK_ID} == 1 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/motifScan.py json/prepareMotifSeqletCutoffs_s2_anthox6a_pbx_flag_nexus_pbx_counts.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 2 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/motifScan.py json/prepareMotifSeqletCutoffs_s2_anthox6a_pbx_flag_nexus_pbx_profile.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 3 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/motifScan.py json/prepareMotifSeqletCutoffs_s2_anthox6a_pbx_ha_nexus_pbx_counts.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 4 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/motifScan.py json/prepareMotifSeqletCutoffs_s2_anthox6a_pbx_ha_nexus_pbx_profile.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 5 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/motifScan.py json/prepareMotifSeqletCutoffs_s2_anthox1a_pbx_flag_nexus_pbx_counts.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 6 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/motifScan.py json/prepareMotifSeqletCutoffs_s2_anthox1a_pbx_flag_nexus_pbx_profile.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 7 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/motifScan.py json/prepareMotifSeqletCutoffs_s2_anthox1a_pbx_ha_nexus_pbx_counts.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 8 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/motifScan.py json/prepareMotifSeqletCutoffs_s2_anthox1a_pbx_ha_nexus_pbx_profile.json

fi


