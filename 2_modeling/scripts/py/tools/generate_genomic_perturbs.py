
"""
Melanie Weilert
April 2023
Purpose: Given a set of motifs and corresponding sequences/predictions, generate in silico genomic perturbations.

This will measure the predictions across the entire/a portion of the predicted window,
the pseudocounts (pc), max (relative to reference),
and sum of signal across all tasks across all motif windows for each mutation.

Intructions:
1. Activate `bpreveal` conda environment.
2. `python /n/projects/mw2098/shared_code/bpreveal/tools/generate_genomic_perturbs.py [options]`
3. For help: `python /n/projects/mw2098/shared_code/bpreveal/tools/generate_genomic_perturbs.py -h`
"""

# Setup
import sys
import os
import json
import pandas as pd
import keras
import numpy as np
import pickle as pkl
import tensorflow
import logging
from functools import reduce
from tqdm import tqdm
from pathos.multiprocessing import ProcessingPool as Pool
from itertools import combinations, chain
from optparse import OptionParser
import keras.backend as K
# from keras.models import load_model

from bpreveal.utils import loadModel

# sys.path.insert(0, f'/home/mw2098/bin/bpreveal/src')
# import losses

sys.path.insert(0, f'/n/projects/mw2098/shared_code/bpreveal/functions')
from motifs import extract_seqs_from_df, resize_coordinates
from perturb import generate_alt_sequences
from functional import logitsToProfile, one_hot_encode_sequences

import warnings
warnings.filterwarnings("ignore")
logger = logging.getLogger(__name__)
logger.addHandler(logging.NullHandler())

#Set up options
parser = OptionParser()
parser.add_option("-i", "--motifs_df_path",
                  help="Path to the tab-separated, header-containing file of the motif coordinates of interest.")
parser.add_option("-r", "--motif_groups_df_path",
                  help="Path to the tab-separated, header-containing file of the motif-group (peak) coordinates matching the motifs.")

parser.add_option("-m", "--model_dir",
                  help="Path to the trained model (specified in `chrombpnet`")

parser.add_option("-o", "--output_prefix",
                  help="Output prefix for the chromosome-separated .tsv.gz files.")
parser.add_option("-f", "--fasta_file",
                  help="Path to the .fasta file to extract sequences from.")
parser.add_option("--tasks_in_model_order",
                  help="Comma separated tasks in the order that the BPReveal model heads are set up.")

parser.add_option("--input_seqlen", default = 2114, type = "int",
                  help="Input sequence length of model. [default: %default]")
parser.add_option("--output_seqlen", default = 1000, type = "int",
                  help="Output profile length of model. [default: %default]")

parser.add_option("-u", "--comb_max", default = None, type = "int",
                  help="Upper limit of simultaneous mutations to conduct across each region. [default: %default]")
parser.add_option("-l", "--comb_min", default = None, type = "int",
                  help="Lower limit of simultaneous mutations to conduct across each region. [default: %default]")

parser.add_option("--region_index_column", default = 'region_index', type = "str",
                  help="Column name that motifs_df and motif_groups_df have in common to keep region combinations consistent. [default: %default]")
parser.add_option("--motif_window_start_column", default = 'motif_window_start', type = "str",
                  help="Column name that motifs_df contains to denote OUTPUT within-window coordinates of motifs. [default: %default]")
parser.add_option("--motif_window_end_column", default = 'motif_window_end', type = "str",
                  help="Column name that motifs_df contains to denote OUTPUT within-window coordinates of motifs. [default: %default]")
parser.add_option("--motif_name_column", default = 'name', type = "str",
                  help="Column name that motifs_df contains to denote pattern/motif names for unique labeling. [default: %default]")
parser.add_option("--motif_chrom_column", default = 'chrom', type = "str",
                  help="Column name that motifs_df contains to denote chromosome names. [default: %default]")

parser.add_option("-n", "--nodes", default = 6, type = "int",
                  help="Parallel workers for generating perturbation sequences. [default: %default]")
parser.add_option("-t", "--trials", default = 8, type = "int",
                  help="Number of trials for generating perturbed motifs. [default: %default]")
parser.add_option("--use_whole_window", default = False, action="store_true",
                  help="If selected, then the code will use the whole prediction window instead of the designated `--summary_window` parameter. This option overwrites the `--summary_window` approach. [default: %default]")

parser.add_option("--keep_entire_profile", default = False, action="store_true",
                  help="If selected, then the code will use the whole prediction profile without summarizing. This option overwrites the `--use_whole_window` approach. [default: %default]")

parser.add_option("-w", "--summary_window", default = 50, type = "int",
                  help="Window around motif to compute the max/sum summary predictions. [default: %default]")
parser.add_option("-p", "--pseudo_count_quantile", default = .2, type = "int",
                  help="Threshold to compute pseudo count values across each window for each task/mutant. [default: %default]")
parser.add_option("--is_mnase", default = 'no', type = 'str',
                  help="If MNase models, then measure depletion and positioning effect rather than total counts effect [default: %default]")
parser.add_option("--motif_group_context", default = 'output', type = 'str',
                  help="Are the motif_groups_df coordiantes relative to the input sequence size ir the output? [default: %default]")

(options, args) = parser.parse_args()




#Generate the mutated sequences, predict them, then average across trials
#Return a task->preds dictionary
#Wrap this in a function to reduce memory leakage
def predict_and_average(trials, ref_seqs, motif_sets, windows_n, tasks, example_idxs,
                        comb_max, comb_min, model_dir, region_index_column, nodes):
    
    #Initialize pool of nodes
    p = Pool(nodes=nodes)

    #For x trials, (1) generate sequences, (2) predict from sequences
    preds_by_trial = []

    for trial in range(trials):
        #Return list of perturbed sequences for each region...list[mut->1000x4, mut->1000x4, ...]
        perturb_seqs_list = p.map(generate_alt_sequences, ref_seqs, motif_sets,
                                  ['pattern_name_unique']*windows_n,
                                  ['window_start_input']*windows_n,
                                  ['window_end_input']*windows_n,
                                  [comb_max]*windows_n, [comb_min]*windows_n)
        s = []
        pis_df = pd.DataFrame(columns = ['mut',region_index_column])
        for window in range(windows_n):
            #Collect the sequences
            perturb_seq = perturb_seqs_list[window]
            perturb_seq_array = np.array([v for v in perturb_seq.values()])
            s.append(perturb_seq_array)

            #Record the indexes
            pi = pd.DataFrame([k for k in perturb_seq.keys()], columns = ['mut'])
            pi[region_index_column] = example_idxs[window]
            pis_df = pd.concat([pis_df, pi])
        pis_df['perturb_idx'] = range(pis_df.shape[0])
        s = np.vstack(s)

        #Load model of interest
        K.clear_session()

        #Predict and append to trial list
        model = loadModel(model_dir) #, custom_objects = {'multinomialNll' : losses.multinomialNll, 'reweightableMse': losses.dummyMse})
        preds_raw_arr = model.predict(s, verbose = 0)

        #Convert logits and logcounts to standard coverage
        profiles_dict = {}
        for i,task in enumerate(tasks):
            profile_by_task = []
            for j in range(preds_raw_arr[0].shape[0]):
                profile = logitsToProfile(logitsAcrossSingleRegion = preds_raw_arr[i][j],
                                          logCountsAcrossSingleRegion = preds_raw_arr[i + len(tasks)][j])
                profile_by_task.append(profile)
            #Return a np.array of [regions x position x channel] that has been converted to standard coverage
            profiles_dict[task] = np.array(profile_by_task)
        #Return a list of trials of task -> [regions x position x channel]
        preds_by_trial.append(profiles_dict)

    #Average trials together: task -> region x position x strand where region = each perturb_idx of pis_df
    perturb_preds = {task: np.mean(np.array([preds_by_trial[trial][task] for trial in range(trials)]), axis = 0) for task in tasks}
    return perturb_preds, pis_df

#Take dictionary of predictions and tidy and summarize for processing downstream
#Wrap this in a function to reduce memory leakage
def summarize_perturbations(tasks, pis_df, motifs_df, perturb_preds, region_index_column, output_seqlen,
                            pseudo_count_quantile, use_whole_window, is_mnase, flank, summary_window):

    summary_list = [] #append `summary_dict_by_task` for each task
    for task in tasks:
        summary_dict_by_task = {}
        counter = 0
        for perturb_idx in pis_df['perturb_idx']:
            #Subset to the correct prediction
            perturb_pred = perturb_preds[task][perturb_idx]

            #Collect associated information
            example_idx = pis_df[region_index_column][pis_df['perturb_idx']==perturb_idx]
            motif_set = motifs_df[motifs_df[region_index_column]==example_idx.values[0]]
            mut = pis_df['mut'][pis_df['perturb_idx']==perturb_idx]

            #Get pseudocounts across the predicted region
            pc = np.percentile(perturb_pred, pseudo_count_quantile * 100)

            if use_whole_window:
                #logger.info('--use_whole_window marked, summarizing entire window...' + chrom + '...')
                #Summarize the whole window predictions
                pred_sum = np.sum(np.abs(perturb_pred))
                summary_dict_by_task[counter] = [perturb_idx, example_idx.values[0], mut.values[0], pc, pred_sum]
                counter += 1
                
            else:
                #Collect the associated reference prediction
                ref_perturb_idx = pis_df[(pis_df[region_index_column]==example_idx.values[0]) & (pis_df['mut']=='Reference')].perturb_idx
                ref_perturb_pred = perturb_preds[task][ref_perturb_idx.values[0]]

                #For each motif in a motif_set...
                for idx,motif in motif_set.iterrows():

                    #Collect boundaries of current motif
                    centerpoint = int(np.floor((motif['window_end_input'] - motif['window_start_input'])/2) + motif['window_start_input'] - flank)
                    lower_bounds = int(centerpoint - np.floor(summary_window/2))
                    upper_bounds = int(centerpoint + np.floor(summary_window/2))

                    #If boundaries are exceeded beyond the window, create null entry
                    if (lower_bounds<=0) or (upper_bounds>=output_seqlen):
                        summary_dict_by_task[counter] = [perturb_idx, example_idx.values[0], mut.values[0], motif.pattern_name_unique, pc, None, None]
                    
                    elif is_mnase=='yes':
                        #Collect values across regions of interest (nucleosome center and diff from position)
                        sig_bounded = perturb_pred[lower_bounds:upper_bounds] #window_len x strand
                        pred_sum = np.sum(np.abs(sig_bounded))
                        pred_diff = np.sum(np.abs(perturb_pred[:lower_bounds] - ref_perturb_pred[:lower_bounds])) + \
                            np.sum(np.abs(perturb_pred[upper_bounds:] - ref_perturb_pred[upper_bounds:]))  

                        summary_dict_by_task[counter] = [perturb_idx, example_idx.values[0], mut.values[0], motif.pattern_name_unique, pc, pred_sum, pred_diff]
                    
                    else:
                        #Call ref sig across motif slice within the summary_window and find max on pos and neg strand
                        max_sig_idx = np.argmax(ref_perturb_pred[lower_bounds:upper_bounds], axis = 0)

                        #Collect values across regions of interest.
                        sig_bounded = perturb_pred[lower_bounds:upper_bounds] #window_len x strand
                        pred_sum = np.sum(np.abs(sig_bounded))
                        pred_max = sig_bounded[max_sig_idx]

                        summary_dict_by_task[counter] = [perturb_idx, example_idx.values[0], mut.values[0], motif.pattern_name_unique, pc, pred_sum, pred_max]
                        
                    counter += 1

        s_df = pd.DataFrame.from_dict(summary_dict_by_task, orient='index')
        # print(s_df.head())

        if use_whole_window:
                        s_df.columns = ['perturb_idx', region_index_column, 'mut', f'{task}/pc', f'{task}/pred_sum']

        elif is_mnase=='yes':
            s_df.columns = ['perturb_idx', region_index_column,'mut','motif',
                                      f'{task}/pc', f'{task}/pred_deplete', f'{task}/pred_position']

        else:
            s_df.columns = ['perturb_idx', region_index_column,'mut','motif',
                                      f'{task}/pc', f'{task}/pred_sum', f'{task}/pred_max']
        #Append to list
        summary_list.append(s_df)

    #Collect different task columns and assign to single df
    print('Collecting all perturbs into pd.df...')
    if use_whole_window:
        summary_df = reduce(lambda x,y: pd.merge(x,y, on=['perturb_idx',region_index_column,'mut'], how='outer'),
                            summary_list)
    else:
        summary_df = reduce(lambda x,y: pd.merge(x,y, on=['perturb_idx',region_index_column,'mut','motif'],
                                                 how='outer'),
                            summary_list)
    return summary_df

#Entire prediction step
def bpreveal_generate_perturbations(motifs_df_path, motif_groups_df_path,
                           model_dir, output_prefix,
                           fasta_file,
                           tasks_in_model_order,
                           input_seqlen = 2114, output_seqlen = 1000,
                           region_index_column = 'region_index',
                           motif_window_start_column = 'motif_window_start',
                           motif_window_end_column = 'motif_window_end',
                           motif_name_column = 'name',
                           motif_chrom_column = 'chrom',
                           comb_max = None, comb_min = None,
                           nodes = 6, trials = 16, use_whole_window = False, is_mnase = 'no',
                           keep_entire_profile = False,
                           summary_window = 51, pseudo_count_quantile = .2, motif_group_context = 'output'):
    #
    assert (comb_min>=1) or (comb_min == None), 'Minimum combinations cannot be 0 or negative.'

    # Make directories
    output_dir = os.path.dirname(output_prefix)
    os.makedirs(output_dir, exist_ok=True)

    #Define BPreveal tasks
    assert isinstance(tasks_in_model_order, str), 'Input tasks are given as a list, not a comma-separated string, please correct.'
    tasks = tasks_in_model_order.split(',')
    flank = np.floor((input_seqlen - output_seqlen) // 2)

    #Get unique motif names
    motifs_df = pd.read_csv(motifs_df_path, sep = '\t')
    motifs_df = motifs_df.sort_values([region_index_column, motif_name_column])
    motifs_df['pattern_name_unique'] = motifs_df[motif_name_column] + '-' + (motifs_df.groupby([region_index_column, motif_name_column]).cumcount()+1).astype(str)

    #Get reference sequences
    if motif_group_context == 'output':
        regions_df = pd.read_csv(motif_groups_df_path, sep = '\t')

        """
        Because the output length of the consolidated motif positions based on `regions_df` references
        aren't the same as the output length of 
        the models, I'm gonna do some annoying bullshit to get the coordinates to align. This will ensure that
        the motif coordinates we point to are the actual mutated sequences. 
        You really should fix this better, melanie. Oh well, at least its right.
        """
        expected_output_length = list(set(regions_df.end - regions_df.start))[0]

        #What happens if the output length of the model doesn't match the reference `region_df` length r.e. the motif positions? Then correct.
        if expected_output_length<output_seqlen:
            extra_flank = int(np.floor((output_seqlen - expected_output_length)/2))
            #Get motif positions relative to the input seqlen
            motifs_df[motif_window_start_column] = motifs_df[motif_window_start_column] + extra_flank
            motifs_df[motif_window_end_column] = motifs_df[motif_window_end_column] + extra_flank

        #Idk, I don't feel like filtering out smaller lengths today, means eliminating motifs.
        elif expected_output_length>output_seqlen:
            assert list(set(regions_df.end - regions_df.start))[0]==output_seqlen, \
            'Error: Input motif group regions are not same dimension as `output_seqlen`, which was the selected option. Please resize and check coordinates.'

        regions_input_df = resize_coordinates(regions_df, input_seqlen, 'center')

        #Get motif positions relative to the input seqlen
        motifs_df['window_start_input'] = motifs_df[motif_window_start_column] + flank
        motifs_df['window_end_input'] = motifs_df[motif_window_end_column] + flank
        
    else: 
        regions_input_df = pd.read_csv(motif_groups_df_path, sep = '\t')
        assert list(set(regions_input_df.end - regions_input_df.start))[0]==input_seqlen, \
        'Error: Input motif group regions are not same dimension as `input_seqlen`, which was the selected option. Please resize and check coordinates.'
        
        motifs_df['window_start_input'] = motifs_df[motif_window_start_column]
        motifs_df['window_end_input'] = motifs_df[motif_window_end_column]

    seqs = extract_seqs_from_df(coords_df = regions_input_df, fasta_path = fasta_file, chrom_column = 'chrom', start_column = 'start', end_column = 'end')
    seqs_1he = one_hot_encode_sequences(seqs)

    for chrom in tqdm(motifs_df[motif_chrom_column].unique()):

        print('Generating sequences together' + str(chrom) + '...')

        #Subset regions based on chromosome
        example_idxs = motifs_df[motifs_df[motif_chrom_column]==chrom][region_index_column].unique()

        #Set up lists of matching idxs, seqs, and motifs
        ref_seqs = [seqs_1he[i] for i in example_idxs]
        motif_sets = [motifs_df[motifs_df[region_index_column].astype(int)==i] for i in example_idxs]
        windows_n = len(example_idxs)

        perturb_preds, pis_df = predict_and_average(trials = trials, ref_seqs = ref_seqs, motif_sets = motif_sets, windows_n = windows_n, tasks = tasks,
                                            comb_max = comb_max, comb_min = comb_min, model_dir = model_dir, example_idxs = example_idxs, 
                                            region_index_column = region_index_column, nodes= nodes)

        if keep_entire_profile:

            with open(f'{output_prefix}_{chrom}.pkl', 'wb') as handle:
                pkl.dump(perturb_preds, handle, protocol=pkl.HIGHEST_PROTOCOL)
            pis_df.to_csv(f'{output_prefix}_index_{chrom}.tsv.gz', sep = '\t', index = False)

        else:
            print('Summarizing perturbations across ' + str(chrom))
            

            summary_df = summarize_perturbations(tasks = tasks, pis_df = pis_df, motifs_df = motifs_df, output_seqlen = output_seqlen,
                                                 perturb_preds = perturb_preds, region_index_column = region_index_column,
                                                 pseudo_count_quantile = pseudo_count_quantile, use_whole_window = use_whole_window, 
                                                 is_mnase = is_mnase, flank = flank, summary_window = summary_window)

            print('Writing perturbs to a .tsv.gz...')
            summary_df.to_csv(f'{output_prefix}_{chrom}.tsv.gz', sep = '\t', index = False)
            
    return None

#Run featured function
bpreveal_generate_perturbations(motifs_df_path = options.motifs_df_path,
                                motif_groups_df_path = options.motif_groups_df_path,
                                model_dir = options.model_dir,
                                output_prefix = options.output_prefix,
                                fasta_file = options.fasta_file,
                                tasks_in_model_order = options.tasks_in_model_order,
                                input_seqlen = options.input_seqlen,
                                output_seqlen = options.output_seqlen,
                                region_index_column = options.region_index_column,
                                motif_window_start_column = options.motif_window_start_column,
                                motif_window_end_column = options.motif_window_end_column,
                                motif_name_column = options.motif_name_column,
                                motif_chrom_column = options.motif_chrom_column,
                                comb_max = options.comb_max,
                                comb_min = options.comb_min,
                                nodes = options.nodes,
                                trials = options.trials,
                                use_whole_window = options.use_whole_window,
                                keep_entire_profile = options.keep_entire_profile,
                                summary_window = options.summary_window,
                                pseudo_count_quantile = options.pseudo_count_quantile,
                                is_mnase = options.is_mnase,
                                motif_group_context = options.motif_group_context)
