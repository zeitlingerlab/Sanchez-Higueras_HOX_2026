#!/bin/bash
#SBATCH --job-name marginalizations
#SBATCH --output=slurm_%j.log
#SBATCH --mem=75gb
#SBATCH --time=48:00:00
#SBATCH --partition=gpu
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=10
source /home/mw2098/.bashrc
conda deactivate
conda activate bpreveal_404
cd /n/projects/mw2098/collaboration/for_carlos/20260205_manuscript/2_modeling
/home/mw2098/anaconda3/envs/bpreveal_510/bin/python scripts/py/tools/generate_insilico_perturbs_across_affinities.py \
--model_dir models/s2_anthox6a_pbx_ha_nexus_fold1.keras \
--null_sequence_np_filepath npz/random_seqs_seed_2346_input_3056_trials_256_array.npz \
--tasks_separated_by_commas pbx \
--output_tsv_path tsv/insilico/insilico_hox_marginalizations_s2_anthox6a_pbx_ha_nexus.tsv.gz \
--seqA_txt_filepath tsv/insilico_hox_seqs.tsv \
--motifA_name all \
--motifA_output_position 500 \
--seqB_txt_filepath tsv/mapped_motifs/filler.tsv.gz \
--motifB_name empty \
--motifB_output_position 530 \
--input_length 3056 \
--output_length 1000
