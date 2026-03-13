
"""
Melanie Weilert
May 2023
"""

##################################################################
# Computational setup
##################################################################
#Packages
import os
import sys
import pandas as pd
import keras
import json
from optparse import OptionParser
import numpy as np
import itertools
import tensorflow as tf
import keras.backend as K
# from keras.models import load_model
from tqdm import tqdm
import pickle as pkl

from bpreveal.utils import loadModel

# Settings
sys.path.insert(0, f'/n/projects/mw2098/shared_code/bpreveal/functions/')
from functional import shuffle_seqs, one_hot_encode_sequence, one_hot_encode_sequences, \
    one_hot_decode_sequence, insert_motif, logitsToProfile
from motifs import extract_seqs_from_df, resize_coordinates
# sys.path.insert(0, f'/n/projects/mw2098/publications/2024_weilert_acc/public/software/bpreveal_404/src/')
# import losses

#Set up options
parser = OptionParser()
parser.add_option("--model_dir",
                  help="Directory of the BPReveal model")
parser.add_option("--null_sequence_np_filepath",
                  help="Filepath to the .npz file that contains 1he null sequences to run trials across")
parser.add_option("--tasks_separated_by_commas",
                  help="Comma separated tasks aligned with the given BPReveal model")
parser.add_option("--output_tsv_path",
                  help="Output .tsv.gz filepath to save the predictions to")
parser.add_option("--seqA_txt_filepath",
                  help="Filepath of tab-separated file that contains the column 'seq' to represent all motif affinities to be injected.")
parser.add_option("--motifA_name",
                  help="Name of the anchored motif to be injected")
parser.add_option("--motifA_output_position", default = 300, type = "int",
                  help="WRT the output window, where is the anchored motifA to be injected?")
parser.add_option("--seqB_txt_filepath",
                  help="Filepath of tab-separated file that contains the column 'seq' to represent all motif affinities to be injected.")
parser.add_option("--motifB_name",
                  help="Name of the anchored motif to be injected")
parser.add_option("--motifB_distance_minimum", default = 20, type = "int",
                  help="WRT motifA, what is the minimum distance for anchored motifB to be injected?")
parser.add_option("--motifB_distance_maximum", default = 350, type = "int",
                  help="WRT motifA, what is the maximum distance for anchored motifB to be injected?")
parser.add_option("--motifB_distance_step", default = 5, type = "int",
                  help="WRT motifA, what is the step between min-max distances for anchored motifB to be injected?")
parser.add_option("--input_length", default = 2114, type = "int",
                  help="Input sequence length of model. [default: %default]")
parser.add_option("--output_length", default = 1000, type = "int",
                  help="Output sequence length of model. [default: %default]")
parser.add_option("--null_sequence_np_prefix", default = 'seqs_1he', type = "str",
                  help="Npz subarray prefix to access the 1he seqquences [default: %default]")
parser.add_option("--is_mnase", default = 'no', type = 'str',
                  help="If MNase models, then measure depletion and positioning effect rather than total counts effect [default: %default]")
parser.add_option("--keep_entire_profile", default = False, action="store_true",
                  help="If selected, then the code will use the whole prediction profile without summarizing, saving as .pkl file. [default: %default]")

(options, args) = parser.parse_args()

def bpreveal_generate_insilico_perturbs_across_affinities(
model_dir,
null_sequence_np_filepath,
tasks_separated_by_commas,
output_tsv_path,
seqA_txt_filepath,
motifA_name,
seqB_txt_filepath,
motifB_name,
motifA_output_position = 300,
motifB_distance_minimum = 20,
motifB_distance_maximum = 350,
motifB_distance_step = 5,
input_length = 2114,
output_length = 1000,
null_sequence_np_prefix = 'seqs_1he',
is_mnase = 'no',
keep_entire_profile = False
):
    #Read in required data
    null_seqs = np.load(null_sequence_np_filepath)[null_sequence_np_prefix]
    motifA_seqs_df = pd.read_csv(seqA_txt_filepath, sep = '\t')
    motifB_seqs_df = pd.read_csv(seqB_txt_filepath, sep = '\t')
    tasks = tasks_separated_by_commas.split(',')
    motifA_input_position = int((input_length-output_length)/2 + motifA_output_position)
    colnames_of_df = ['seqA', 'motifA', 'seqB', 'motifB', 'state', 'distance']

    #Collect predictions by trial
    preds_by_trial_df = pd.DataFrame() #For if we decide to summarize values
    predictions_all_dict = {t: {} for t in tasks} #For if we decide to keep profiles

    for t in tqdm(range(null_seqs.shape[0])):

        #Prepare null sequence and anchored sequence information
        null_seq = one_hot_decode_sequence(null_seqs[t])
        injected_seqs = [null_seq]
        left_is_motifA_df = pd.DataFrame([['none']*1, [motifA_name]*1, ['none']*1, [motifB_name]*1, ['null'], ['none']]).transpose()
        right_is_motifA_df = pd.DataFrame([['none']*1, [motifB_name]*1, ['none']*1, [motifA_name]*1, ['null'], ['none']]).transpose()

        for sA in motifA_seqs_df.seq.values:
            seqA = insert_motif(seq = null_seq, motif = sA, position = motifA_input_position)
            injected_seqs = injected_seqs + [seqA]

            left_df = pd.DataFrame([[sA]*1, [motifA_name]*1, ['none']*1, [motifB_name]*1, ['A'], ['none']]).transpose()
            right_df = pd.DataFrame([['none']*1, [motifB_name]*1, [sA]*1, [motifA_name]*1, ['B'], ['none']]).transpose()
            left_is_motifA_df = pd.concat([left_is_motifA_df, left_df])
            right_is_motifA_df = pd.concat([right_is_motifA_df, right_df])

        distances = range(motifB_distance_minimum, motifB_distance_maximum, motifB_distance_step)
        for d in distances:
            motifB_input_position = motifA_input_position + d
            for sB in motifB_seqs_df.seq.values:
                seqB = insert_motif(seq = null_seq, motif = sB, position = motifB_input_position)
                injected_seqs = injected_seqs + [seqB]

                left_df = pd.DataFrame([['none']*1, [motifA_name]*1, [sB]*1, [motifB_name]*1, ['B'], [d]]).transpose()
                right_df = pd.DataFrame([[sB]*1, [motifB_name]*1, ['none']*1, [motifA_name]*1, ['A'], [d]]).transpose()
                left_is_motifA_df = pd.concat([left_is_motifA_df, left_df])
                right_is_motifA_df = pd.concat([right_is_motifA_df, right_df])

            for sA in motifA_seqs_df.seq.values:
                for sB in motifB_seqs_df.seq.values:
                    seqAB = insert_motif(seq = null_seq, motif = sA, position = motifA_input_position)
                    seqAB = insert_motif(seq = seqAB, motif = sB, position = motifB_input_position)
                    injected_seqs = injected_seqs + [seqAB]

                    left_df = pd.DataFrame([[sA]*1, [motifA_name]*1, [sB]*1, [motifB_name]*1, ['AB'], [d]]).transpose()
                    right_df = pd.DataFrame([[sB]*1, [motifB_name]*1, [sA]*1, [motifA_name]*1, ['AB'], [d]]).transpose()
                    left_is_motifA_df = pd.concat([left_is_motifA_df, left_df])
                    right_is_motifA_df = pd.concat([right_is_motifA_df, right_df])

        injected_seqs_1he = one_hot_encode_sequences(injected_seqs)
        left_is_motifA_df.columns = colnames_of_df
        right_is_motifA_df.columns = colnames_of_df

        if keep_entire_profile:

            K.clear_session()
            model = loadModel(model_dir) #, custom_objects = {'multinomialNll' : losses.multinomialNll, 'reweightableMse': losses.dummyMse})
            preds_raw_arr = model.predict(injected_seqs_1he, verbose = 0)
            
            #Collect counts predictions
            for k,task in enumerate(tasks):
                profiles = np.array([logitsToProfile(logitsAcrossSingleRegion = preds_raw_arr[k][ss],
                                              logCountsAcrossSingleRegion = preds_raw_arr[k + len(tasks)][ss]) 
                    for ss in range(len(injected_seqs))])
                # print(profiles.shape)
                predictions_all_dict[task][t] = profiles
            
        else:

            #If MNase, then don't measure total reads, measure depletion effect as well as positioning effect
            if is_mnase=='yes':
                print('MNase selected...modified post-processing.')
                #Predict results in chunks so that the GPU can handle it
                # step_size = 100000
                print('Predicting sequences...')
                step_size = 100000
                nucA_left_boundary = motifA_output_position-75
                nucA_right_boundary = motifA_output_position+75
                nucB_left_boundary = motifB_output_position-75
                nucB_right_boundary = motifB_output_position+75

                all_preds_df = pd.DataFrame()
                for s in range(0, injected_seqs_1he.shape[0], step_size):
                    K.clear_session()
                    model = loadModel(model_dir) #, custom_objects = {'multinomialNll' : losses.multinomialNll, 'reweightableMse': losses.dummyMse})
                    upper_bound = int(np.min(np.array([(s + step_size), injected_seqs_1he.shape[0]])))
                    seqs = injected_seqs_1he[s:upper_bound]
                    preds_raw_arr = model.predict(seqs)
                    preds_null_arr = model.predict(np.reshape(null_seqs[t], (1, input_length, 4)))

                    left_df = left_is_motifA_df[s:upper_bound]
                    right_df = right_is_motifA_df[s:upper_bound]

                    #Collect counts predictions
                    for k,task in enumerate(tasks):
                        assert len(preds_raw_arr[k + len(tasks)].shape)==2
                        null = logitsToProfile(logitsAcrossSingleRegion = preds_null_arr[k][0],
                                                  logCountsAcrossSingleRegion = preds_null_arr[k + len(tasks)][0])

                        #For each region, calculate customized features.
                        deplete_left_batch = []
                        deplete_right_batch = []
                        position_left_batch = []
                        position_right_batch = []
                        for ss in range(len(seqs)):
                            profile = logitsToProfile(logitsAcrossSingleRegion = preds_raw_arr[k][ss],
                                                      logCountsAcrossSingleRegion = preds_raw_arr[k + len(tasks)][ss])


                            deplete_left = np.sum(profile[(nucA_left_boundary):(nucA_right_boundary)])
                            deplete_right = np.sum(profile[(nucB_left_boundary):(nucB_right_boundary)])

                            position_left = np.sum(np.abs(profile[:(nucA_left_boundary)] - null[:(nucA_left_boundary)])) + \
                                np.sum(np.abs(profile[(nucA_right_boundary):] - null[(nucA_right_boundary):]))
                            position_right = np.sum(np.abs(profile[:(nucB_left_boundary)] - null[:(nucB_left_boundary)])) + \
                                np.sum(np.abs(profile[(nucB_right_boundary):] - null[(nucB_right_boundary):]))

                            deplete_left_batch.append(deplete_left)
                            deplete_right_batch.append(deplete_right)
                            position_left_batch.append(position_left)
                            position_right_batch.append(position_right)

                        left_df[f'{task}_deplete'] = deplete_left_batch
                        left_df[f'{task}_position'] = position_left_batch
                        right_df[f'{task}_deplete'] = deplete_right_batch
                        right_df[f'{task}_position'] = position_right_batch

                    preds_df = pd.concat([left_df, right_df])
                    if motifB_name != 'empty':
                        all_preds_df = pd.concat([all_preds_df, preds_df])
                    else:
                        all_preds_df = left_df
                all_preds_df['trial'] = t
                preds_by_trial_df = pd.concat([preds_by_trial_df, all_preds_df])
            else:
                #Predict results in chunks so that the GPU can handle it
                # step_size = 100000
                print('Predicting sequences...')
                step_size = 100000
                all_preds_df = pd.DataFrame()
                for s in range(0, injected_seqs_1he.shape[0], step_size):
                    K.clear_session()
                    model = loadModel(model_dir) #, custom_objects = {'multinomialNll' : losses.multinomialNll, 'reweightableMse': losses.dummyMse})
                    upper_bound = int(np.min(np.array([(s + step_size), injected_seqs_1he.shape[0]])))
                    seqs = injected_seqs_1he[s:upper_bound]
                    preds_raw_arr = model.predict(seqs)
                    left_df = left_is_motifA_df[s:upper_bound]
                    right_df = right_is_motifA_df[s:upper_bound]

                    #Collect counts predictions
                    for k,task in enumerate(tasks):
                        assert len(preds_raw_arr[k + len(tasks)].shape)==2
                        left_df[task] = preds_raw_arr[k + len(tasks)]
                        right_df[task] = preds_raw_arr[k + len(tasks)]
                    preds_df = pd.concat([left_df, right_df])
                    if motifB_name != 'empty':
                        all_preds_df = pd.concat([all_preds_df, preds_df])
                    else:
                        all_preds_df = left_df
                all_preds_df['trial'] = t
                preds_by_trial_df = pd.concat([preds_by_trial_df, all_preds_df])

    print('Writing predictions...')
    if keep_entire_profile:
        #Average across features
        # print(np.mean(np.array([predictions_all_dict['mnase'][t] for t in range(null_seqs.shape[0])]), axis = 0).shape)
        predictions_averaged_dict = {task: np.mean(np.array([v for v in predictions_all_dict[task].values()]), axis = 0) for task in tasks}

        #Save as .pkl file
        output_prefix = output_tsv_path.replace('.tsv.gz', '')
        with open(f'{output_prefix}_profiles.pkl', 'wb') as handle:
            pkl.dump(predictions_averaged_dict, handle, protocol=pkl.HIGHEST_PROTOCOL)
        left_is_motifA_df.to_csv(f'{output_prefix}_indexes.tsv.gz', sep = '\t', index = False)
    else:
        if is_mnase=='yes':
            tasks_w_measurements = [f'{t}_deplete' for t in tasks] + [f'{t}_position' for t in tasks]
            preds_all_df = preds_by_trial_df.groupby(colnames_of_df)[tasks_w_measurements].mean().reset_index()
        else:
            preds_all_df = preds_by_trial_df.groupby(colnames_of_df)[tasks].mean().reset_index()

        #Export to TSV
        preds_all_df.to_csv(output_tsv_path, sep = '\t', index = False)

#Run featured function
bpreveal_generate_insilico_perturbs_across_affinities(
model_dir = options.model_dir,
null_sequence_np_filepath = options.null_sequence_np_filepath,
tasks_separated_by_commas = options.tasks_separated_by_commas,
output_tsv_path = options.output_tsv_path,
seqA_txt_filepath = options.seqA_txt_filepath,
motifA_name = options.motifA_name,
seqB_txt_filepath = options.seqB_txt_filepath,
motifB_name = options.motifB_name,
motifA_output_position = options.motifA_output_position,
motifB_distance_minimum = options.motifB_distance_minimum,
motifB_distance_maximum = options.motifB_distance_maximum,
motifB_distance_step = options.motifB_distance_step,
input_length = options.input_length,
output_length = options.output_length,
null_sequence_np_prefix = options.null_sequence_np_prefix,
is_mnase = options.is_mnase,
keep_entire_profile = options.keep_entire_profile
)
