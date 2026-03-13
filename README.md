---
Author: Melanie Weilert
Date: February 2026
Purpose: HOX manuscript, ChIP-nexus and BPNet component

# Introduction

This is an overview of analysis and modeling reproducibility for the ChIP-nexus and BPNet component of Carlos's manuscript regarding Cnidarian Hox TF binding in S2 cell lines in Drosophila.

1. Environment summary
2. Process sequencing data (Snakemake)

Please keep in mind that the Stowers Institute infrastructure relies on an HPC that runs SLURM jobs as well as allows for interactive sessions hosted using both CPUs and GPUs. Because of this, much of the work reported below will be designed under that workflow.

# 1. Environment


This is the environment used to align and process genomics data based on the given `Snakefile`. This is part of a container set up by Jonathon Russell from the Stowers Institute to manage the custom Zeitlinger lab pipeline environment requirements.

All experimental samples and reprocessed samples from GEO are listed under: `/n/projects/mw2098/collaboration/for_schuttengruber/20260108_gaf/0_setup/1_define_samples.xlsx`. We ran a `snakemake` pipeline to process all samples. The command was run to allocated SLURM queued jobs using the following script:

```
sbatch code/0_setup/2_process_samples.slurm
```

## Versions

In brief, the versions of key packages are as follows for this environment:

+ python=3.11.5
  + os
  + math
  + itertools
  + csv=1.0
  + numpy=1.24.3
  + pandas=2.0.3
  + openpyxl=3.0.10
+ R=4.2.3
  + optparse_1.7.3
  + testit_0.13
  + parallel_4.2.3
  + dplyr_1.1.2
  + plyranges_1.18.0
  + readxl_1.4.3
  + readr_2.1.4
  + Rsamtools_2.14.0
  + BiocParallel_1.32.6
  + RCurl_1.98-1.12
  + ShortRead_1.56.1
  + GenomicAlignments_1.34.1
  + GenomicRanges_1.50.2
  + magrittr_2.0.3
  + rtracklayer_1.58.0
  + Rcpp_1.0.11
  + stringr_1.5.1
+ ucsc
+ fastx-toolkit=0.0.14
+ cutadapt=4.2
+ macs2=2.2.7.1
+ samtools=1.15.1
+ bowtie2=2.3.5.1
+ zcat=1.9
+ snakemake=7.32.4

### Supplementary software

Other packages are required for processing the pipeline:
+ Java OpenJDK==1.8.0_191
+ PICARD==2.23.8
+ STAR==2.7.3a

# 2. Set up modeling base environment

## GPU usage

This is the environment used to perform modeling and analysis in Python. We performed all deep learning modeling using a Keras/TensorFlow framework on NVIDIA® A100 TensorCore 40GB GPUs (CUDA v11.8).

## Clone the BPReveal repo

First, clone the BPReveal (v.5.1.0) software implementation of BPNet:

`git clone /n/projects/cm2363/public-bpreveal/5.1.0/repo`

## Create environment

Here, we create an Anaconda3 environment (`bpreveal_510`) by which we can process our scripts, train our models, and analyze our code. You can follow the instructions in the `bpreveal` repo to install your own version of this package.

To run this script the following software needs to be in your environment:

+ python=3.11.7
+ conda==24.1.1
+ mamba==1.5.0

In brief, the versions of key packages are as follows for this environment:

+ pysam==0.22.0
+ pybedtools==0.9.1
+ pybigwig==0.3.22
+ numpy==1.26.4
+ pandas==2.2.0
+ matplotlib==3.8.3
+ plotnine==0.12.4
+ pathos==0.3.2
+ jupyterlab==4.1.1
+ nb_conda==2.2.1
+ cuda-toolkit==11.8.0
+ keras==2.15.0
+ tensorflow==2.15.0
+ tensorflow-probability==0.23.0
+ cmake==3.28.3
+ h5py==3.10.0
+ tqdm==4.66.2
+ gxx_linux-64==13.2.0
+ gfortran==13.2.0

# Step 3: Analysis.

Upon processing and storage in `code/2_modeling`, data was then modeled and analyzed. Analysis was conducted in both Python and R. For Python, analysis environment is the same as the modeling environment described above (`bpreveal_510`). For R, `sessionInfo()` is reported with relevant packages and versions at the bottom of each rendered markdown file. Markdown files are numbered in the order by which they were run. Raw figures can be found here as well as code and associated scripts to run analysis.


# NOTE: Additional HOX TFs reported

In this initial work, we incorporated data involving Cnidarian AntHOX1a and Drosophila Dfd HOX TF experiments. While not in the initial submission, we decided to include these analysis/modeling for the sake of comprehensive reporting, though the raw data is not available in GEO. Please contact the corresponding author for more information regarding these experiments.


