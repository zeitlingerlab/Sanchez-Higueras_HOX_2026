#!/usr/bin/bash
#SBATCH --job-name bpnet_training
#SBATCH --output=slurm_%j.log
#SBATCH --array=1-64%20
#SBATCH --mem=200gb
#SBATCH --time=72:00:00
#SBATCH --cpus-per-task=10
source /home/mw2098/.bashrc
conda deactivate
conda activate bpreveal_510
ml bedtools
cd /n/projects/mw2098/collaboration/for_carlos/20260205_manuscript/2_modeling
if [[ ${SLURM_ARRAY_TASK_ID} == 1 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_HA_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 2 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_HA_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_32_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_32_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_32_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 3 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_Flag_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_32_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_32_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_32_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 4 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_HA_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_7_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_7_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_ha_nexus_n_dil_layers_7_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 5 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_HA_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_10_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_10_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_ha_nexus_n_dil_layers_10_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 6 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_Flag_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_256_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_256_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_256_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 7 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_HA_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_128_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_128_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_128_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 8 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_HA_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_16_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_16_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_16_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 9 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_Flag_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_9_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_9_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_flag_nexus_n_dil_layers_9_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 10 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_HA_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_7_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_7_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_ha_nexus_n_dil_layers_7_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 11 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_HA_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_10_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_10_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_ha_nexus_n_dil_layers_10_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 12 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_HA_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_10_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_10_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_ha_nexus_n_dil_layers_10_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 13 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_Flag_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_9_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_9_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_flag_nexus_n_dil_layers_9_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 14 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_Flag_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_16_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_16_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_16_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 15 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_HA_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_128_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_128_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_128_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 16 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_Flag_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 17 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_Flag_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_256_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_256_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_256_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 18 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_Flag_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_256_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_256_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_256_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 19 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_HA_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_256_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_256_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_256_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 20 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_Flag_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_7_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_7_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_flag_nexus_n_dil_layers_7_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 21 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_Flag_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_16_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_16_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_16_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 22 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_Flag_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_7_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_7_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_flag_nexus_n_dil_layers_7_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 23 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_HA_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_16_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_16_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_16_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 24 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_Flag_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_10_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_10_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_flag_nexus_n_dil_layers_10_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 25 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_Flag_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_32_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_32_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_32_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 26 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_HA_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_9_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_9_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_ha_nexus_n_dil_layers_9_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 27 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_HA_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_128_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_128_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_128_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 28 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_Flag_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 29 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_Flag_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_32_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_32_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_32_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 30 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_Flag_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_16_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_16_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_16_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 31 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_Flag_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_7_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_7_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_flag_nexus_n_dil_layers_7_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 32 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_Flag_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_9_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_9_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_flag_nexus_n_dil_layers_9_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 33 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_HA_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_7_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_7_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_ha_nexus_n_dil_layers_7_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 34 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_HA_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_16_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_16_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_16_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 35 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_Flag_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 36 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_Flag_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_7_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_7_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_flag_nexus_n_dil_layers_7_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 37 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_HA_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_7_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_7_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_ha_nexus_n_dil_layers_7_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 38 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_HA_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_10_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_10_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_ha_nexus_n_dil_layers_10_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 39 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_HA_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_128_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_128_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_128_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 40 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_Flag_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_10_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_10_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_flag_nexus_n_dil_layers_10_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 41 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_HA_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_16_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_16_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_16_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 42 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_HA_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_32_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_32_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_32_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 43 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_HA_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 44 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_HA_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_9_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_9_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_ha_nexus_n_dil_layers_9_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 45 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_Flag_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_32_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_32_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_32_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 46 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_HA_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_32_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_32_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_32_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 47 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_Flag_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_128_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_128_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_128_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 48 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_Flag_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_9_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_9_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_flag_nexus_n_dil_layers_9_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 49 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_HA_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_256_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_256_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_256_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 50 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_HA_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_256_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_256_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_256_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 51 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_Flag_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_10_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_10_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_flag_nexus_n_dil_layers_10_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 52 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_Flag_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 53 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_HA_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 54 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_HA_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_9_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_9_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_ha_nexus_n_dil_layers_9_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 55 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_Flag_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_10_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_10_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_flag_nexus_n_dil_layers_10_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 56 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_Flag_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_128_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_128_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_128_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 57 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_HA_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_256_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_256_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_256_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 58 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_Flag_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_256_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_256_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_256_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 59 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_HA_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_9_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_9_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_ha_nexus_n_dil_layers_9_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 60 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_Flag_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_16_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_16_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_16_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 61 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_Flag_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_128_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_128_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_128_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 62 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_Flag_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_128_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_128_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_flag_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_128_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 63 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX6a_PBX_HA_nexus_combined_negative.bw                             --pred preds/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.bw                             --regions bed/bpreveal/optimize/s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox6a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_64_output_length_1000_counts_loss_weight_100_pbx_neg_test.json

fi


if [[ ${SLURM_ARRAY_TASK_ID} == 64 ]] ; then

    /home/mw2098/anaconda3/envs/bpreveal_510/bin/python /home/mw2098/bin/bpreveal_510//src/metrics.py                             --reference bw/S2_AntHOX1a_PBX_HA_nexus_combined_positive.bw                             --pred preds/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_32_output_length_1000_counts_loss_weight_100_pbx_pos_test.bw                             --regions bed/bpreveal/optimize/s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_32_output_length_1000_counts_loss_weight_100_test.bed                             --threads 10 --json-output --apply-abs --skip-zeroes | tee json/optimize/metrics_s2_anthox1a_pbx_ha_nexus_n_dil_layers_8_conv1_kernel_size_7_profile_kernel_size_7_filters_32_output_length_1000_counts_loss_weight_100_pbx_pos_test.json

fi


