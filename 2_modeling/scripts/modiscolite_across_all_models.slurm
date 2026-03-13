#!/usr/bin/bash
#SBATCH --array=1-24%15
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

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/shapToNumpy.py \
--h5 shap/s2_anthox6a_pbx_flag_nexus_fold1_pbx_counts.h5 \
--seqs npz/s2_anthox6a_pbx_flag_nexus_fold1_pbx_counts_seqs \
--scores npz/s2_anthox6a_pbx_flag_nexus_fold1_pbx_counts_scores
mkdir -p modiscolite/s2_anthox6a_pbx_flag_nexus_fold1_pbx_counts
modisco motifs \
-s npz/s2_anthox6a_pbx_flag_nexus_fold1_pbx_counts_seqs.npy \
-a npz/s2_anthox6a_pbx_flag_nexus_fold1_pbx_counts_scores.npy \
-n 10000 \
-w 1000 \
--output modiscolite/s2_anthox6a_pbx_flag_nexus_fold1_pbx_counts/modisco.h5
modisco report -i modiscolite/s2_anthox6a_pbx_flag_nexus_fold1_pbx_counts/modisco.h5 \
-o modiscolite/s2_anthox6a_pbx_flag_nexus_fold1_pbx_counts \
-m /l/Zeitlinger/ZeitlingerLab/Manuscripts/Zld_and_SuHw/public/databases/JASPAR/JASPAR2022_CORE_insects_non-redundant_pfms_meme.txt

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 2 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/shapToNumpy.py \
--h5 shap/s2_anthox6a_pbx_flag_nexus_fold1_pbx_profile.h5 \
--seqs npz/s2_anthox6a_pbx_flag_nexus_fold1_pbx_profile_seqs \
--scores npz/s2_anthox6a_pbx_flag_nexus_fold1_pbx_profile_scores
mkdir -p modiscolite/s2_anthox6a_pbx_flag_nexus_fold1_pbx_profile
modisco motifs \
-s npz/s2_anthox6a_pbx_flag_nexus_fold1_pbx_profile_seqs.npy \
-a npz/s2_anthox6a_pbx_flag_nexus_fold1_pbx_profile_scores.npy \
-n 10000 \
-w 1000 \
--output modiscolite/s2_anthox6a_pbx_flag_nexus_fold1_pbx_profile/modisco.h5
modisco report -i modiscolite/s2_anthox6a_pbx_flag_nexus_fold1_pbx_profile/modisco.h5 \
-o modiscolite/s2_anthox6a_pbx_flag_nexus_fold1_pbx_profile \
-m /l/Zeitlinger/ZeitlingerLab/Manuscripts/Zld_and_SuHw/public/databases/JASPAR/JASPAR2022_CORE_insects_non-redundant_pfms_meme.txt

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 3 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/shapToNumpy.py \
--h5 shap/s2_anthox6a_pbx_flag_nexus_fold2_pbx_counts.h5 \
--seqs npz/s2_anthox6a_pbx_flag_nexus_fold2_pbx_counts_seqs \
--scores npz/s2_anthox6a_pbx_flag_nexus_fold2_pbx_counts_scores
mkdir -p modiscolite/s2_anthox6a_pbx_flag_nexus_fold2_pbx_counts
modisco motifs \
-s npz/s2_anthox6a_pbx_flag_nexus_fold2_pbx_counts_seqs.npy \
-a npz/s2_anthox6a_pbx_flag_nexus_fold2_pbx_counts_scores.npy \
-n 10000 \
-w 1000 \
--output modiscolite/s2_anthox6a_pbx_flag_nexus_fold2_pbx_counts/modisco.h5
modisco report -i modiscolite/s2_anthox6a_pbx_flag_nexus_fold2_pbx_counts/modisco.h5 \
-o modiscolite/s2_anthox6a_pbx_flag_nexus_fold2_pbx_counts \
-m /l/Zeitlinger/ZeitlingerLab/Manuscripts/Zld_and_SuHw/public/databases/JASPAR/JASPAR2022_CORE_insects_non-redundant_pfms_meme.txt

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 4 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/shapToNumpy.py \
--h5 shap/s2_anthox6a_pbx_flag_nexus_fold2_pbx_profile.h5 \
--seqs npz/s2_anthox6a_pbx_flag_nexus_fold2_pbx_profile_seqs \
--scores npz/s2_anthox6a_pbx_flag_nexus_fold2_pbx_profile_scores
mkdir -p modiscolite/s2_anthox6a_pbx_flag_nexus_fold2_pbx_profile
modisco motifs \
-s npz/s2_anthox6a_pbx_flag_nexus_fold2_pbx_profile_seqs.npy \
-a npz/s2_anthox6a_pbx_flag_nexus_fold2_pbx_profile_scores.npy \
-n 10000 \
-w 1000 \
--output modiscolite/s2_anthox6a_pbx_flag_nexus_fold2_pbx_profile/modisco.h5
modisco report -i modiscolite/s2_anthox6a_pbx_flag_nexus_fold2_pbx_profile/modisco.h5 \
-o modiscolite/s2_anthox6a_pbx_flag_nexus_fold2_pbx_profile \
-m /l/Zeitlinger/ZeitlingerLab/Manuscripts/Zld_and_SuHw/public/databases/JASPAR/JASPAR2022_CORE_insects_non-redundant_pfms_meme.txt

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 5 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/shapToNumpy.py \
--h5 shap/s2_anthox6a_pbx_flag_nexus_fold3_pbx_counts.h5 \
--seqs npz/s2_anthox6a_pbx_flag_nexus_fold3_pbx_counts_seqs \
--scores npz/s2_anthox6a_pbx_flag_nexus_fold3_pbx_counts_scores
mkdir -p modiscolite/s2_anthox6a_pbx_flag_nexus_fold3_pbx_counts
modisco motifs \
-s npz/s2_anthox6a_pbx_flag_nexus_fold3_pbx_counts_seqs.npy \
-a npz/s2_anthox6a_pbx_flag_nexus_fold3_pbx_counts_scores.npy \
-n 10000 \
-w 1000 \
--output modiscolite/s2_anthox6a_pbx_flag_nexus_fold3_pbx_counts/modisco.h5
modisco report -i modiscolite/s2_anthox6a_pbx_flag_nexus_fold3_pbx_counts/modisco.h5 \
-o modiscolite/s2_anthox6a_pbx_flag_nexus_fold3_pbx_counts \
-m /l/Zeitlinger/ZeitlingerLab/Manuscripts/Zld_and_SuHw/public/databases/JASPAR/JASPAR2022_CORE_insects_non-redundant_pfms_meme.txt

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 6 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/shapToNumpy.py \
--h5 shap/s2_anthox6a_pbx_flag_nexus_fold3_pbx_profile.h5 \
--seqs npz/s2_anthox6a_pbx_flag_nexus_fold3_pbx_profile_seqs \
--scores npz/s2_anthox6a_pbx_flag_nexus_fold3_pbx_profile_scores
mkdir -p modiscolite/s2_anthox6a_pbx_flag_nexus_fold3_pbx_profile
modisco motifs \
-s npz/s2_anthox6a_pbx_flag_nexus_fold3_pbx_profile_seqs.npy \
-a npz/s2_anthox6a_pbx_flag_nexus_fold3_pbx_profile_scores.npy \
-n 10000 \
-w 1000 \
--output modiscolite/s2_anthox6a_pbx_flag_nexus_fold3_pbx_profile/modisco.h5
modisco report -i modiscolite/s2_anthox6a_pbx_flag_nexus_fold3_pbx_profile/modisco.h5 \
-o modiscolite/s2_anthox6a_pbx_flag_nexus_fold3_pbx_profile \
-m /l/Zeitlinger/ZeitlingerLab/Manuscripts/Zld_and_SuHw/public/databases/JASPAR/JASPAR2022_CORE_insects_non-redundant_pfms_meme.txt

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 7 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/shapToNumpy.py \
--h5 shap/s2_anthox6a_pbx_ha_nexus_fold1_pbx_counts.h5 \
--seqs npz/s2_anthox6a_pbx_ha_nexus_fold1_pbx_counts_seqs \
--scores npz/s2_anthox6a_pbx_ha_nexus_fold1_pbx_counts_scores
mkdir -p modiscolite/s2_anthox6a_pbx_ha_nexus_fold1_pbx_counts
modisco motifs \
-s npz/s2_anthox6a_pbx_ha_nexus_fold1_pbx_counts_seqs.npy \
-a npz/s2_anthox6a_pbx_ha_nexus_fold1_pbx_counts_scores.npy \
-n 10000 \
-w 1000 \
--output modiscolite/s2_anthox6a_pbx_ha_nexus_fold1_pbx_counts/modisco.h5
modisco report -i modiscolite/s2_anthox6a_pbx_ha_nexus_fold1_pbx_counts/modisco.h5 \
-o modiscolite/s2_anthox6a_pbx_ha_nexus_fold1_pbx_counts \
-m /l/Zeitlinger/ZeitlingerLab/Manuscripts/Zld_and_SuHw/public/databases/JASPAR/JASPAR2022_CORE_insects_non-redundant_pfms_meme.txt

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 8 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/shapToNumpy.py \
--h5 shap/s2_anthox6a_pbx_ha_nexus_fold1_pbx_profile.h5 \
--seqs npz/s2_anthox6a_pbx_ha_nexus_fold1_pbx_profile_seqs \
--scores npz/s2_anthox6a_pbx_ha_nexus_fold1_pbx_profile_scores
mkdir -p modiscolite/s2_anthox6a_pbx_ha_nexus_fold1_pbx_profile
modisco motifs \
-s npz/s2_anthox6a_pbx_ha_nexus_fold1_pbx_profile_seqs.npy \
-a npz/s2_anthox6a_pbx_ha_nexus_fold1_pbx_profile_scores.npy \
-n 10000 \
-w 1000 \
--output modiscolite/s2_anthox6a_pbx_ha_nexus_fold1_pbx_profile/modisco.h5
modisco report -i modiscolite/s2_anthox6a_pbx_ha_nexus_fold1_pbx_profile/modisco.h5 \
-o modiscolite/s2_anthox6a_pbx_ha_nexus_fold1_pbx_profile \
-m /l/Zeitlinger/ZeitlingerLab/Manuscripts/Zld_and_SuHw/public/databases/JASPAR/JASPAR2022_CORE_insects_non-redundant_pfms_meme.txt

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 9 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/shapToNumpy.py \
--h5 shap/s2_anthox6a_pbx_ha_nexus_fold2_pbx_counts.h5 \
--seqs npz/s2_anthox6a_pbx_ha_nexus_fold2_pbx_counts_seqs \
--scores npz/s2_anthox6a_pbx_ha_nexus_fold2_pbx_counts_scores
mkdir -p modiscolite/s2_anthox6a_pbx_ha_nexus_fold2_pbx_counts
modisco motifs \
-s npz/s2_anthox6a_pbx_ha_nexus_fold2_pbx_counts_seqs.npy \
-a npz/s2_anthox6a_pbx_ha_nexus_fold2_pbx_counts_scores.npy \
-n 10000 \
-w 1000 \
--output modiscolite/s2_anthox6a_pbx_ha_nexus_fold2_pbx_counts/modisco.h5
modisco report -i modiscolite/s2_anthox6a_pbx_ha_nexus_fold2_pbx_counts/modisco.h5 \
-o modiscolite/s2_anthox6a_pbx_ha_nexus_fold2_pbx_counts \
-m /l/Zeitlinger/ZeitlingerLab/Manuscripts/Zld_and_SuHw/public/databases/JASPAR/JASPAR2022_CORE_insects_non-redundant_pfms_meme.txt

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 10 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/shapToNumpy.py \
--h5 shap/s2_anthox6a_pbx_ha_nexus_fold2_pbx_profile.h5 \
--seqs npz/s2_anthox6a_pbx_ha_nexus_fold2_pbx_profile_seqs \
--scores npz/s2_anthox6a_pbx_ha_nexus_fold2_pbx_profile_scores
mkdir -p modiscolite/s2_anthox6a_pbx_ha_nexus_fold2_pbx_profile
modisco motifs \
-s npz/s2_anthox6a_pbx_ha_nexus_fold2_pbx_profile_seqs.npy \
-a npz/s2_anthox6a_pbx_ha_nexus_fold2_pbx_profile_scores.npy \
-n 10000 \
-w 1000 \
--output modiscolite/s2_anthox6a_pbx_ha_nexus_fold2_pbx_profile/modisco.h5
modisco report -i modiscolite/s2_anthox6a_pbx_ha_nexus_fold2_pbx_profile/modisco.h5 \
-o modiscolite/s2_anthox6a_pbx_ha_nexus_fold2_pbx_profile \
-m /l/Zeitlinger/ZeitlingerLab/Manuscripts/Zld_and_SuHw/public/databases/JASPAR/JASPAR2022_CORE_insects_non-redundant_pfms_meme.txt

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 11 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/shapToNumpy.py \
--h5 shap/s2_anthox6a_pbx_ha_nexus_fold3_pbx_counts.h5 \
--seqs npz/s2_anthox6a_pbx_ha_nexus_fold3_pbx_counts_seqs \
--scores npz/s2_anthox6a_pbx_ha_nexus_fold3_pbx_counts_scores
mkdir -p modiscolite/s2_anthox6a_pbx_ha_nexus_fold3_pbx_counts
modisco motifs \
-s npz/s2_anthox6a_pbx_ha_nexus_fold3_pbx_counts_seqs.npy \
-a npz/s2_anthox6a_pbx_ha_nexus_fold3_pbx_counts_scores.npy \
-n 10000 \
-w 1000 \
--output modiscolite/s2_anthox6a_pbx_ha_nexus_fold3_pbx_counts/modisco.h5
modisco report -i modiscolite/s2_anthox6a_pbx_ha_nexus_fold3_pbx_counts/modisco.h5 \
-o modiscolite/s2_anthox6a_pbx_ha_nexus_fold3_pbx_counts \
-m /l/Zeitlinger/ZeitlingerLab/Manuscripts/Zld_and_SuHw/public/databases/JASPAR/JASPAR2022_CORE_insects_non-redundant_pfms_meme.txt

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 12 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/shapToNumpy.py \
--h5 shap/s2_anthox6a_pbx_ha_nexus_fold3_pbx_profile.h5 \
--seqs npz/s2_anthox6a_pbx_ha_nexus_fold3_pbx_profile_seqs \
--scores npz/s2_anthox6a_pbx_ha_nexus_fold3_pbx_profile_scores
mkdir -p modiscolite/s2_anthox6a_pbx_ha_nexus_fold3_pbx_profile
modisco motifs \
-s npz/s2_anthox6a_pbx_ha_nexus_fold3_pbx_profile_seqs.npy \
-a npz/s2_anthox6a_pbx_ha_nexus_fold3_pbx_profile_scores.npy \
-n 10000 \
-w 1000 \
--output modiscolite/s2_anthox6a_pbx_ha_nexus_fold3_pbx_profile/modisco.h5
modisco report -i modiscolite/s2_anthox6a_pbx_ha_nexus_fold3_pbx_profile/modisco.h5 \
-o modiscolite/s2_anthox6a_pbx_ha_nexus_fold3_pbx_profile \
-m /l/Zeitlinger/ZeitlingerLab/Manuscripts/Zld_and_SuHw/public/databases/JASPAR/JASPAR2022_CORE_insects_non-redundant_pfms_meme.txt

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 13 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/shapToNumpy.py \
--h5 shap/s2_anthox1a_pbx_flag_nexus_fold1_pbx_counts.h5 \
--seqs npz/s2_anthox1a_pbx_flag_nexus_fold1_pbx_counts_seqs \
--scores npz/s2_anthox1a_pbx_flag_nexus_fold1_pbx_counts_scores
mkdir -p modiscolite/s2_anthox1a_pbx_flag_nexus_fold1_pbx_counts
modisco motifs \
-s npz/s2_anthox1a_pbx_flag_nexus_fold1_pbx_counts_seqs.npy \
-a npz/s2_anthox1a_pbx_flag_nexus_fold1_pbx_counts_scores.npy \
-n 10000 \
-w 1000 \
--output modiscolite/s2_anthox1a_pbx_flag_nexus_fold1_pbx_counts/modisco.h5
modisco report -i modiscolite/s2_anthox1a_pbx_flag_nexus_fold1_pbx_counts/modisco.h5 \
-o modiscolite/s2_anthox1a_pbx_flag_nexus_fold1_pbx_counts \
-m /l/Zeitlinger/ZeitlingerLab/Manuscripts/Zld_and_SuHw/public/databases/JASPAR/JASPAR2022_CORE_insects_non-redundant_pfms_meme.txt

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 14 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/shapToNumpy.py \
--h5 shap/s2_anthox1a_pbx_flag_nexus_fold1_pbx_profile.h5 \
--seqs npz/s2_anthox1a_pbx_flag_nexus_fold1_pbx_profile_seqs \
--scores npz/s2_anthox1a_pbx_flag_nexus_fold1_pbx_profile_scores
mkdir -p modiscolite/s2_anthox1a_pbx_flag_nexus_fold1_pbx_profile
modisco motifs \
-s npz/s2_anthox1a_pbx_flag_nexus_fold1_pbx_profile_seqs.npy \
-a npz/s2_anthox1a_pbx_flag_nexus_fold1_pbx_profile_scores.npy \
-n 10000 \
-w 1000 \
--output modiscolite/s2_anthox1a_pbx_flag_nexus_fold1_pbx_profile/modisco.h5
modisco report -i modiscolite/s2_anthox1a_pbx_flag_nexus_fold1_pbx_profile/modisco.h5 \
-o modiscolite/s2_anthox1a_pbx_flag_nexus_fold1_pbx_profile \
-m /l/Zeitlinger/ZeitlingerLab/Manuscripts/Zld_and_SuHw/public/databases/JASPAR/JASPAR2022_CORE_insects_non-redundant_pfms_meme.txt

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 15 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/shapToNumpy.py \
--h5 shap/s2_anthox1a_pbx_flag_nexus_fold2_pbx_counts.h5 \
--seqs npz/s2_anthox1a_pbx_flag_nexus_fold2_pbx_counts_seqs \
--scores npz/s2_anthox1a_pbx_flag_nexus_fold2_pbx_counts_scores
mkdir -p modiscolite/s2_anthox1a_pbx_flag_nexus_fold2_pbx_counts
modisco motifs \
-s npz/s2_anthox1a_pbx_flag_nexus_fold2_pbx_counts_seqs.npy \
-a npz/s2_anthox1a_pbx_flag_nexus_fold2_pbx_counts_scores.npy \
-n 10000 \
-w 1000 \
--output modiscolite/s2_anthox1a_pbx_flag_nexus_fold2_pbx_counts/modisco.h5
modisco report -i modiscolite/s2_anthox1a_pbx_flag_nexus_fold2_pbx_counts/modisco.h5 \
-o modiscolite/s2_anthox1a_pbx_flag_nexus_fold2_pbx_counts \
-m /l/Zeitlinger/ZeitlingerLab/Manuscripts/Zld_and_SuHw/public/databases/JASPAR/JASPAR2022_CORE_insects_non-redundant_pfms_meme.txt

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 16 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/shapToNumpy.py \
--h5 shap/s2_anthox1a_pbx_flag_nexus_fold2_pbx_profile.h5 \
--seqs npz/s2_anthox1a_pbx_flag_nexus_fold2_pbx_profile_seqs \
--scores npz/s2_anthox1a_pbx_flag_nexus_fold2_pbx_profile_scores
mkdir -p modiscolite/s2_anthox1a_pbx_flag_nexus_fold2_pbx_profile
modisco motifs \
-s npz/s2_anthox1a_pbx_flag_nexus_fold2_pbx_profile_seqs.npy \
-a npz/s2_anthox1a_pbx_flag_nexus_fold2_pbx_profile_scores.npy \
-n 10000 \
-w 1000 \
--output modiscolite/s2_anthox1a_pbx_flag_nexus_fold2_pbx_profile/modisco.h5
modisco report -i modiscolite/s2_anthox1a_pbx_flag_nexus_fold2_pbx_profile/modisco.h5 \
-o modiscolite/s2_anthox1a_pbx_flag_nexus_fold2_pbx_profile \
-m /l/Zeitlinger/ZeitlingerLab/Manuscripts/Zld_and_SuHw/public/databases/JASPAR/JASPAR2022_CORE_insects_non-redundant_pfms_meme.txt

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 17 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/shapToNumpy.py \
--h5 shap/s2_anthox1a_pbx_flag_nexus_fold3_pbx_counts.h5 \
--seqs npz/s2_anthox1a_pbx_flag_nexus_fold3_pbx_counts_seqs \
--scores npz/s2_anthox1a_pbx_flag_nexus_fold3_pbx_counts_scores
mkdir -p modiscolite/s2_anthox1a_pbx_flag_nexus_fold3_pbx_counts
modisco motifs \
-s npz/s2_anthox1a_pbx_flag_nexus_fold3_pbx_counts_seqs.npy \
-a npz/s2_anthox1a_pbx_flag_nexus_fold3_pbx_counts_scores.npy \
-n 10000 \
-w 1000 \
--output modiscolite/s2_anthox1a_pbx_flag_nexus_fold3_pbx_counts/modisco.h5
modisco report -i modiscolite/s2_anthox1a_pbx_flag_nexus_fold3_pbx_counts/modisco.h5 \
-o modiscolite/s2_anthox1a_pbx_flag_nexus_fold3_pbx_counts \
-m /l/Zeitlinger/ZeitlingerLab/Manuscripts/Zld_and_SuHw/public/databases/JASPAR/JASPAR2022_CORE_insects_non-redundant_pfms_meme.txt

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 18 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/shapToNumpy.py \
--h5 shap/s2_anthox1a_pbx_flag_nexus_fold3_pbx_profile.h5 \
--seqs npz/s2_anthox1a_pbx_flag_nexus_fold3_pbx_profile_seqs \
--scores npz/s2_anthox1a_pbx_flag_nexus_fold3_pbx_profile_scores
mkdir -p modiscolite/s2_anthox1a_pbx_flag_nexus_fold3_pbx_profile
modisco motifs \
-s npz/s2_anthox1a_pbx_flag_nexus_fold3_pbx_profile_seqs.npy \
-a npz/s2_anthox1a_pbx_flag_nexus_fold3_pbx_profile_scores.npy \
-n 10000 \
-w 1000 \
--output modiscolite/s2_anthox1a_pbx_flag_nexus_fold3_pbx_profile/modisco.h5
modisco report -i modiscolite/s2_anthox1a_pbx_flag_nexus_fold3_pbx_profile/modisco.h5 \
-o modiscolite/s2_anthox1a_pbx_flag_nexus_fold3_pbx_profile \
-m /l/Zeitlinger/ZeitlingerLab/Manuscripts/Zld_and_SuHw/public/databases/JASPAR/JASPAR2022_CORE_insects_non-redundant_pfms_meme.txt

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 19 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/shapToNumpy.py \
--h5 shap/s2_anthox1a_pbx_ha_nexus_fold1_pbx_counts.h5 \
--seqs npz/s2_anthox1a_pbx_ha_nexus_fold1_pbx_counts_seqs \
--scores npz/s2_anthox1a_pbx_ha_nexus_fold1_pbx_counts_scores
mkdir -p modiscolite/s2_anthox1a_pbx_ha_nexus_fold1_pbx_counts
modisco motifs \
-s npz/s2_anthox1a_pbx_ha_nexus_fold1_pbx_counts_seqs.npy \
-a npz/s2_anthox1a_pbx_ha_nexus_fold1_pbx_counts_scores.npy \
-n 10000 \
-w 1000 \
--output modiscolite/s2_anthox1a_pbx_ha_nexus_fold1_pbx_counts/modisco.h5
modisco report -i modiscolite/s2_anthox1a_pbx_ha_nexus_fold1_pbx_counts/modisco.h5 \
-o modiscolite/s2_anthox1a_pbx_ha_nexus_fold1_pbx_counts \
-m /l/Zeitlinger/ZeitlingerLab/Manuscripts/Zld_and_SuHw/public/databases/JASPAR/JASPAR2022_CORE_insects_non-redundant_pfms_meme.txt

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 20 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/shapToNumpy.py \
--h5 shap/s2_anthox1a_pbx_ha_nexus_fold1_pbx_profile.h5 \
--seqs npz/s2_anthox1a_pbx_ha_nexus_fold1_pbx_profile_seqs \
--scores npz/s2_anthox1a_pbx_ha_nexus_fold1_pbx_profile_scores
mkdir -p modiscolite/s2_anthox1a_pbx_ha_nexus_fold1_pbx_profile
modisco motifs \
-s npz/s2_anthox1a_pbx_ha_nexus_fold1_pbx_profile_seqs.npy \
-a npz/s2_anthox1a_pbx_ha_nexus_fold1_pbx_profile_scores.npy \
-n 10000 \
-w 1000 \
--output modiscolite/s2_anthox1a_pbx_ha_nexus_fold1_pbx_profile/modisco.h5
modisco report -i modiscolite/s2_anthox1a_pbx_ha_nexus_fold1_pbx_profile/modisco.h5 \
-o modiscolite/s2_anthox1a_pbx_ha_nexus_fold1_pbx_profile \
-m /l/Zeitlinger/ZeitlingerLab/Manuscripts/Zld_and_SuHw/public/databases/JASPAR/JASPAR2022_CORE_insects_non-redundant_pfms_meme.txt

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 21 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/shapToNumpy.py \
--h5 shap/s2_anthox1a_pbx_ha_nexus_fold2_pbx_counts.h5 \
--seqs npz/s2_anthox1a_pbx_ha_nexus_fold2_pbx_counts_seqs \
--scores npz/s2_anthox1a_pbx_ha_nexus_fold2_pbx_counts_scores
mkdir -p modiscolite/s2_anthox1a_pbx_ha_nexus_fold2_pbx_counts
modisco motifs \
-s npz/s2_anthox1a_pbx_ha_nexus_fold2_pbx_counts_seqs.npy \
-a npz/s2_anthox1a_pbx_ha_nexus_fold2_pbx_counts_scores.npy \
-n 10000 \
-w 1000 \
--output modiscolite/s2_anthox1a_pbx_ha_nexus_fold2_pbx_counts/modisco.h5
modisco report -i modiscolite/s2_anthox1a_pbx_ha_nexus_fold2_pbx_counts/modisco.h5 \
-o modiscolite/s2_anthox1a_pbx_ha_nexus_fold2_pbx_counts \
-m /l/Zeitlinger/ZeitlingerLab/Manuscripts/Zld_and_SuHw/public/databases/JASPAR/JASPAR2022_CORE_insects_non-redundant_pfms_meme.txt

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 22 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/shapToNumpy.py \
--h5 shap/s2_anthox1a_pbx_ha_nexus_fold2_pbx_profile.h5 \
--seqs npz/s2_anthox1a_pbx_ha_nexus_fold2_pbx_profile_seqs \
--scores npz/s2_anthox1a_pbx_ha_nexus_fold2_pbx_profile_scores
mkdir -p modiscolite/s2_anthox1a_pbx_ha_nexus_fold2_pbx_profile
modisco motifs \
-s npz/s2_anthox1a_pbx_ha_nexus_fold2_pbx_profile_seqs.npy \
-a npz/s2_anthox1a_pbx_ha_nexus_fold2_pbx_profile_scores.npy \
-n 10000 \
-w 1000 \
--output modiscolite/s2_anthox1a_pbx_ha_nexus_fold2_pbx_profile/modisco.h5
modisco report -i modiscolite/s2_anthox1a_pbx_ha_nexus_fold2_pbx_profile/modisco.h5 \
-o modiscolite/s2_anthox1a_pbx_ha_nexus_fold2_pbx_profile \
-m /l/Zeitlinger/ZeitlingerLab/Manuscripts/Zld_and_SuHw/public/databases/JASPAR/JASPAR2022_CORE_insects_non-redundant_pfms_meme.txt

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 23 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/shapToNumpy.py \
--h5 shap/s2_anthox1a_pbx_ha_nexus_fold3_pbx_counts.h5 \
--seqs npz/s2_anthox1a_pbx_ha_nexus_fold3_pbx_counts_seqs \
--scores npz/s2_anthox1a_pbx_ha_nexus_fold3_pbx_counts_scores
mkdir -p modiscolite/s2_anthox1a_pbx_ha_nexus_fold3_pbx_counts
modisco motifs \
-s npz/s2_anthox1a_pbx_ha_nexus_fold3_pbx_counts_seqs.npy \
-a npz/s2_anthox1a_pbx_ha_nexus_fold3_pbx_counts_scores.npy \
-n 10000 \
-w 1000 \
--output modiscolite/s2_anthox1a_pbx_ha_nexus_fold3_pbx_counts/modisco.h5
modisco report -i modiscolite/s2_anthox1a_pbx_ha_nexus_fold3_pbx_counts/modisco.h5 \
-o modiscolite/s2_anthox1a_pbx_ha_nexus_fold3_pbx_counts \
-m /l/Zeitlinger/ZeitlingerLab/Manuscripts/Zld_and_SuHw/public/databases/JASPAR/JASPAR2022_CORE_insects_non-redundant_pfms_meme.txt

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 24 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/shapToNumpy.py \
--h5 shap/s2_anthox1a_pbx_ha_nexus_fold3_pbx_profile.h5 \
--seqs npz/s2_anthox1a_pbx_ha_nexus_fold3_pbx_profile_seqs \
--scores npz/s2_anthox1a_pbx_ha_nexus_fold3_pbx_profile_scores
mkdir -p modiscolite/s2_anthox1a_pbx_ha_nexus_fold3_pbx_profile
modisco motifs \
-s npz/s2_anthox1a_pbx_ha_nexus_fold3_pbx_profile_seqs.npy \
-a npz/s2_anthox1a_pbx_ha_nexus_fold3_pbx_profile_scores.npy \
-n 10000 \
-w 1000 \
--output modiscolite/s2_anthox1a_pbx_ha_nexus_fold3_pbx_profile/modisco.h5
modisco report -i modiscolite/s2_anthox1a_pbx_ha_nexus_fold3_pbx_profile/modisco.h5 \
-o modiscolite/s2_anthox1a_pbx_ha_nexus_fold3_pbx_profile \
-m /l/Zeitlinger/ZeitlingerLab/Manuscripts/Zld_and_SuHw/public/databases/JASPAR/JASPAR2022_CORE_insects_non-redundant_pfms_meme.txt

fi


