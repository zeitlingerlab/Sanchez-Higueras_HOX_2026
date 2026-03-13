#!/usr/bin/bash
#SBATCH --job-name bpnet_training
#SBATCH --output=slurm_%j.log
#SBATCH --array=1-24%20
#SBATCH --mem=200gb
#SBATCH --time=72:00:00
#SBATCH --cpus-per-task=10
source /home/mw2098/.bashrc
conda deactivate
conda activate bpreveal_510
ml bedtools
cd /n/projects/mw2098/collaboration/for_carlos/20260205_manuscript/2_modeling
if [[ ${SLURM_ARRAY_TASK_ID} == 1 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/predictToBigwig.py                 --h5 preds/s2_anthox6a_pbx_flag_nexus_fold1_all.h5                 --bw preds/s2_anthox6a_pbx_flag_nexus_fold1_pbx_pos_all.bw                 --head-id 0                 --task-id 0 --mode profile --verbose

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 2 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/predictToBigwig.py                 --h5 preds/s2_anthox6a_pbx_flag_nexus_fold1_all.h5                 --bw preds/s2_anthox6a_pbx_flag_nexus_fold1_pbx_neg_all.bw                 --head-id 0                 --task-id 1 --mode profile --verbose

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 3 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/predictToBigwig.py                 --h5 preds/s2_anthox6a_pbx_flag_nexus_fold2_all.h5                 --bw preds/s2_anthox6a_pbx_flag_nexus_fold2_pbx_pos_all.bw                 --head-id 0                 --task-id 0 --mode profile --verbose

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 4 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/predictToBigwig.py                 --h5 preds/s2_anthox6a_pbx_flag_nexus_fold2_all.h5                 --bw preds/s2_anthox6a_pbx_flag_nexus_fold2_pbx_neg_all.bw                 --head-id 0                 --task-id 1 --mode profile --verbose

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 5 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/predictToBigwig.py                 --h5 preds/s2_anthox6a_pbx_flag_nexus_fold3_all.h5                 --bw preds/s2_anthox6a_pbx_flag_nexus_fold3_pbx_pos_all.bw                 --head-id 0                 --task-id 0 --mode profile --verbose

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 6 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/predictToBigwig.py                 --h5 preds/s2_anthox6a_pbx_flag_nexus_fold3_all.h5                 --bw preds/s2_anthox6a_pbx_flag_nexus_fold3_pbx_neg_all.bw                 --head-id 0                 --task-id 1 --mode profile --verbose

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 7 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/predictToBigwig.py                 --h5 preds/s2_anthox6a_pbx_ha_nexus_fold1_all.h5                 --bw preds/s2_anthox6a_pbx_ha_nexus_fold1_pbx_pos_all.bw                 --head-id 0                 --task-id 0 --mode profile --verbose

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 8 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/predictToBigwig.py                 --h5 preds/s2_anthox6a_pbx_ha_nexus_fold1_all.h5                 --bw preds/s2_anthox6a_pbx_ha_nexus_fold1_pbx_neg_all.bw                 --head-id 0                 --task-id 1 --mode profile --verbose

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 9 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/predictToBigwig.py                 --h5 preds/s2_anthox6a_pbx_ha_nexus_fold2_all.h5                 --bw preds/s2_anthox6a_pbx_ha_nexus_fold2_pbx_pos_all.bw                 --head-id 0                 --task-id 0 --mode profile --verbose

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 10 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/predictToBigwig.py                 --h5 preds/s2_anthox6a_pbx_ha_nexus_fold2_all.h5                 --bw preds/s2_anthox6a_pbx_ha_nexus_fold2_pbx_neg_all.bw                 --head-id 0                 --task-id 1 --mode profile --verbose

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 11 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/predictToBigwig.py                 --h5 preds/s2_anthox6a_pbx_ha_nexus_fold3_all.h5                 --bw preds/s2_anthox6a_pbx_ha_nexus_fold3_pbx_pos_all.bw                 --head-id 0                 --task-id 0 --mode profile --verbose

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 12 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/predictToBigwig.py                 --h5 preds/s2_anthox6a_pbx_ha_nexus_fold3_all.h5                 --bw preds/s2_anthox6a_pbx_ha_nexus_fold3_pbx_neg_all.bw                 --head-id 0                 --task-id 1 --mode profile --verbose

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 13 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/predictToBigwig.py                 --h5 preds/s2_anthox1a_pbx_flag_nexus_fold1_all.h5                 --bw preds/s2_anthox1a_pbx_flag_nexus_fold1_pbx_pos_all.bw                 --head-id 0                 --task-id 0 --mode profile --verbose

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 14 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/predictToBigwig.py                 --h5 preds/s2_anthox1a_pbx_flag_nexus_fold1_all.h5                 --bw preds/s2_anthox1a_pbx_flag_nexus_fold1_pbx_neg_all.bw                 --head-id 0                 --task-id 1 --mode profile --verbose

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 15 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/predictToBigwig.py                 --h5 preds/s2_anthox1a_pbx_flag_nexus_fold2_all.h5                 --bw preds/s2_anthox1a_pbx_flag_nexus_fold2_pbx_pos_all.bw                 --head-id 0                 --task-id 0 --mode profile --verbose

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 16 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/predictToBigwig.py                 --h5 preds/s2_anthox1a_pbx_flag_nexus_fold2_all.h5                 --bw preds/s2_anthox1a_pbx_flag_nexus_fold2_pbx_neg_all.bw                 --head-id 0                 --task-id 1 --mode profile --verbose

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 17 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/predictToBigwig.py                 --h5 preds/s2_anthox1a_pbx_flag_nexus_fold3_all.h5                 --bw preds/s2_anthox1a_pbx_flag_nexus_fold3_pbx_pos_all.bw                 --head-id 0                 --task-id 0 --mode profile --verbose

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 18 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/predictToBigwig.py                 --h5 preds/s2_anthox1a_pbx_flag_nexus_fold3_all.h5                 --bw preds/s2_anthox1a_pbx_flag_nexus_fold3_pbx_neg_all.bw                 --head-id 0                 --task-id 1 --mode profile --verbose

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 19 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/predictToBigwig.py                 --h5 preds/s2_anthox1a_pbx_ha_nexus_fold1_all.h5                 --bw preds/s2_anthox1a_pbx_ha_nexus_fold1_pbx_pos_all.bw                 --head-id 0                 --task-id 0 --mode profile --verbose

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 20 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/predictToBigwig.py                 --h5 preds/s2_anthox1a_pbx_ha_nexus_fold1_all.h5                 --bw preds/s2_anthox1a_pbx_ha_nexus_fold1_pbx_neg_all.bw                 --head-id 0                 --task-id 1 --mode profile --verbose

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 21 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/predictToBigwig.py                 --h5 preds/s2_anthox1a_pbx_ha_nexus_fold2_all.h5                 --bw preds/s2_anthox1a_pbx_ha_nexus_fold2_pbx_pos_all.bw                 --head-id 0                 --task-id 0 --mode profile --verbose

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 22 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/predictToBigwig.py                 --h5 preds/s2_anthox1a_pbx_ha_nexus_fold2_all.h5                 --bw preds/s2_anthox1a_pbx_ha_nexus_fold2_pbx_neg_all.bw                 --head-id 0                 --task-id 1 --mode profile --verbose

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 23 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/predictToBigwig.py                 --h5 preds/s2_anthox1a_pbx_ha_nexus_fold3_all.h5                 --bw preds/s2_anthox1a_pbx_ha_nexus_fold3_pbx_pos_all.bw                 --head-id 0                 --task-id 0 --mode profile --verbose

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 24 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/predictToBigwig.py                 --h5 preds/s2_anthox1a_pbx_ha_nexus_fold3_all.h5                 --bw preds/s2_anthox1a_pbx_ha_nexus_fold3_pbx_neg_all.bw                 --head-id 0                 --task-id 1 --mode profile --verbose

fi


