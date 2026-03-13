message(" ")
message(" ")
message(" a88888b.  .d888888   .88888.   88888888b                               dP                                     ")
message("d8'   `88 d8'    88  d8'   `88  88                                      88                                     ")
message("88        88aaaaa88a 88        a88aaaa       .d8888b. 88d888b. .d8888b. 88 dP    dP .d8888b. .d8888b. 88d888b. ")
message("88        88     88  88   YP88  88           88'  `88 88'  `88 88'  `88 88 88    88 Y8ooooo. 88ooood8 88'  `88 ")
message("Y8.   .88 88     88  Y8.   .88  88           88.  .88 88    88 88.  .88 88 88.  .88       88 88.  ... 88       ")
message(" Y88888P' 88     88   `88888'   88888888P    `88888P8 dP    dP `88888P8 dP `8888P88 `88888P' `88888P' dP       ")
message("oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo~~~~.88~ooooooooooooooooooooooooooo")
message("                                                                            d8888P                             ")
message(" ")
message(" ")
## CAGEfightr analysis Rscript based on both Yue and Simon original script with arguments to be parsed from the command line.

## WARNING : This script is designed for Mus musculus genome and will not run for any other genome except if minor modifications notified below are applied.

## WELCOME : Check if the following packages are installed. They should be installed in R if your are using Stowers resources.

##SCRIPT START BELOW
if (!grepl('4.2.0', R.Version()$version.string, fixed = TRUE)) {
  warning("This script is designed for R 4.2.0 currently.")
} else {
  message("R 4.2.0 found!")
}

#Loading packages
if (class(try(find.package("optparse"), silent = FALSE)) == "try-error") {
  install.packages("optparse")
  require(optparse)
} else { require(optparse) }

if (class(try(find.package("CAGEfightR"), silent = FALSE)) == "try-error") {
  if (!require("BiocManager", quietly = TRUE)) { install.packages("BiocManager") }
  BiocManager::install("CAGEfightR")
  require(CAGEfightR)
} else { require(CAGEfightR) }

suppressPackageStartupMessages(library(optparse, warn.conflicts=F, quietly=T))

################################
#        Parsing options       #
################################

option_list <- list(
  
  
  ###MANDATORY ARGUMENTS###
  
  make_option(c("-p", "--bigwig_positive"),
              type="character",
              help="Path to positive bigwig track."),
  make_option(c("-n", "--bigwig_negative"),
              type="character",
              help="Path to negative bigwig track."),
  make_option(c("-w", "--numworkers"),
              type="integer",
              help="Number of workers to use in the computationally intensive portions of the script."),
  
  ###OPTIONAL ARGUMENTS###
  
  make_option(c("--balanceThreshold"),
              type="double",
              default=0.95, 
              help="Battacharya coefficient. A value of 1 means that both directions are perfectly equilibrated. [default %default]",
              metavar="number"),
  make_option(c("--BCscore"),
              type="double",
              default=0.2, 
              help="Minimum score for calling a bidirectional cluster. [default %default]",
              metavar="number"),
  make_option(c("--UCscore"), type="double", default=1, 
              help="Minimum score for calling a unidirectional cluster. [default %default]",
              metavar="number"),
  make_option(c("--signalThresholdBeingTranscribed"),
              type="integer",
              default=5, 
              help="Minimum number of reads count to be accounted as a TSS [default %default]",
              metavar="number"),
  make_option(c("-s", "--saveAs"),
              type="character",
              default='all',
              help="Format of the results returned. Must be either : 'bed', 'rds' or 'all'.")
)

object_options <- OptionParser(option_list=option_list)


if (class(try(parse_args(object_options))) == "try-error") {
  print_help(object_options)
} else {
  opt <- parse_args(object_options)
}

if (!any(opt$saveAs == "bed", opt$saveAs == "rds", opt$saveAs == "all")) {
  stop("The argument 'saveAs' must be either : 'bed', 'rds' or 'all'.")
}

message("==========> Loading packages...")
suppressPackageStartupMessages(library(rtracklayer, warn.conflicts=F, quietly=T))
suppressPackageStartupMessages(require(CAGEfightR, warn.conflicts=F, quietly=T))
suppressPackageStartupMessages(require(parallel, warn.conflicts=F, quietly=T))
suppressPackageStartupMessages(require(plyranges, warn.conflicts=F, quietly=T))
suppressPackageStartupMessages(library(dplyr, warn.conflicts=F, quietly=T))
#Modify the lines below accordingly to run on another genome
############# HARDCODED FOR MOUSE  #############
suppressPackageStartupMessages(library(BSgenome.Dmelanogaster.UCSC.dm6, warn.conflicts=F, quietly=T))
suppressPackageStartupMessages(library(TxDb.Dmelanogaster.UCSC.dm6.ensGene, warn.conflicts=F, quietly=T))


#Loading private functions
source("/l/Zeitlinger/ZeitlingerLab/Manuscripts/Zld_and_SuHw/analysis/2_modeling/scripts/r/granges_common.r")
source("/l/Zeitlinger/ZeitlingerLab/Manuscripts/Zld_and_SuHw/analysis/2_modeling/scripts/r/metapeak_yue.r")

################################
#      Internal parameters     #
################################

#NOTE : I'm hardcoding the value of some variables for clarity in the arguments and for the seek of reproducibility with what have been done before.

# opt$bigwig_positive<-'bw/mesc_wt_2i_procapseq_forward.bw'
# opt$bigwig_negative<-'bw/mesc_wt_2i_procapseq_reverse.bw'
# opt$numworkers<-10

#CAGEfightR section
balanceThreshold = opt$balanceThreshold                                     # Battacharya coefficient. A value of 1 means that both directions are perfectly equilibrated.
BCscore = opt$BCscore                                                       # minimum score for calling a bidirectional cluster
UCscore = opt$UCscore                                                       # minimum score for calling a unidirectional cluster
signalThresholdBeingTranscribed = opt$signalThresholdBeingTranscribed       # minimum value to be considered as genuine signal

#Bidirectional cluster analysis section
size_divergent_cage_maximum = 600         # maximum distance between two divergent CAGE signals

#Unidirectional cluster analysis section
upstreamMargin = 1000                     # We measure signal up to a 1000 bp away upstream of the thick position
downstreamMargin = 1                      # We don't look at the signal passed the thick position

#Genome annotation section
txdb = TxDb.Dmelanogaster.UCSC.dm6.ensGene # KnownGene annotation package (############# HARDCODED FOR FLY  #############)
bsgenome<-BSgenome.Dmelanogaster.UCSC.dm6
tssUpstream = 1000
tssDownstream = 1000
proximalUpstream = 1000



message("Here are the arguments given :")
message("bigwig_positive : ", opt$bigwig_positive)
message("bigwig_negative : ", opt$bigwig_negative)
message("Number of workers : ", opt$numworkers)
message("Saving in the format : ", opt$saveAs)

cat(
"Here are the current internal parameters used :\n",
"balanceThreshold = ", balanceThreshold, "\n",
"BCscore = ", BCscore, "\n",
"UCscore = ", UCscore, "\n",
"signalThresholdBeingTranscribed = ", signalThresholdBeingTranscribed, "\n",
"size_divergent_cage_maximum = ", size_divergent_cage_maximum, "\n",
"upstreamMargin = ", upstreamMargin, "\n",
"downstreamMargin = ", downstreamMargin, "\n",
"tssUpstream = ", tssUpstream, "\n",
"tssDownstream = ", tssDownstream, "\n",
"proximalUpstream = ", proximalUpstream, "\n")



################################
#        Loading files         #
################################
message("==========> Generating temporary bigwig files necessary for CAGEfightR...")
temp_bw_pos <- tempfile(tmpdir = getwd(), pattern=gsub(".bw", "_temp", basename(opt$bigwig_positive)), fileext=".bw")
on.exit(file.remove(temp_bw_pos), add = TRUE)
temp_bw_neg <- tempfile(tmpdir = getwd(), pattern=gsub(".bw", "_temp", basename(opt$bigwig_negative)), fileext=".bw")
on.exit(file.remove(temp_bw_neg), add = TRUE)

#This allow to make any bigwig compatible with CAGEfightR because it is expecting single-based bigwigs and not only a single value for a interval like most of the bigwigs for compression purposes.
track <- rtracklayer::import.bw(opt$bigwig_positive)
if ( !all(unique(width(track[track$score != 0])) == 1) ) {
  track[track$score != 0]  %>% CAGEfightR::convertGRanges2GPos() %>% export.bw(temp_bw_pos)
} else {
    file.copy(opt$bigwig_positive, temp_bw_pos)
}


track <- rtracklayer::import.bw(opt$bigwig_negative)
if ( !all(unique(width(track[track$score != 0])) == 1) ) {
  track[track$score != 0]  %>% CAGEfightR::convertGRanges2GPos() %>% export.bw(temp_bw_neg)
} else {
  file.copy(opt$bigwig_negative, temp_bw_neg)
}

rm(track)

bw_plus <- rtracklayer::BigWigFileList(temp_bw_pos)
bw_minus <- rtracklayer::BigWigFileList(temp_bw_neg)
names(bw_plus) <- names(bw_minus) <- "CAGE"

cage.bw <- list(pos = opt$bigwig_positive,
                neg = opt$bigwig_negative)


################################
#      CAGEfightR section      #
################################
message("==========> Running CAGEfightR...")

#### Generating CAGEfightR calls ####
# Import CTSSs from bigwig files
CTSSs <- CAGEfightR::quantifyCTSSs(plusStrand = bw_plus, minusStrand = bw_minus, genome = seqinfo(bsgenome))

# Calculate the TPM scaled reads
CTSSs <- CTSSs %>% CAGEfightR::calcTPM() %>% CAGEfightR::calcPooled()


message("==========> Identifying bidirectional clusters")
BCs <- CAGEfightR::clusterBidirectionally(CTSSs, balanceThreshold=balanceThreshold)


message("==========> Identifying unidirectional clusters")
UCs <- CAGEfightR::clusterUnidirectionally(CTSSs)


Bidirectional_CAGE_calls <- BCs[BCs$score>BCscore,]
Unidirectional_CAGE_calls <- UCs[UCs$score>UCscore,]

saveRDS(object = Bidirectional_CAGE_calls, file = paste(gsub("pos|positive|.pos|.positive|_pos|_positive", "", basename(tools::file_path_sans_ext(opt$bigwig_positive))), "_region_raw_BCs.rds", sep = ""))
saveRDS(object = Unidirectional_CAGE_calls, file = paste(gsub("pos|positive|.pos|.positive|_pos|_positive", "", basename(tools::file_path_sans_ext(opt$bigwig_positive))), "_region_raw_UCs.rds", sep = ""))

#############################################
#      Bidirectional clusters analysis      #
#############################################
message("==========> Bidirectional clusters analysis...")

# Select enhancers that have divergent transcription events within size_divergent_cage_maximum
enhancers <- Bidirectional_CAGE_calls[width(Bidirectional_CAGE_calls) < size_divergent_cage_maximum,]

# Resize enhancer width to 1
gr <- resize(enhancers, 1, "center") 

# Find CAGE-seq summit at enhancers
# Get metapeak matrix for CAGE-seq
margin = size_divergent_cage_maximum/2
gr<-check_chromosome_boundaries(gr, resize_boundary = margin + margin, genome = bsgenome)
mt <- exo_metapeak_matrix(gr, sample = cage.bw, upstream = margin, downstream = margin)

pos.mt <- mt["pos"][[1]]
neg.mt <- mt["neg"][[1]]

#Identifying where the summit on positive strand and negative strand are. Remove any maximal position below a certain threshold determined by signalThresholdBeingTranscribed
summit_pos.list <- apply(X = pos.mt, MARGIN = 1,
                         FUN = function(x) {
                           maxposition <- which.max(x[(margin + 1):size_divergent_cage_maximum]) + margin
                           if (x[maxposition] >= signalThresholdBeingTranscribed) {
                             maxposition
                           } else {
                             NA_integer_
                           }
                         }
)

summit_neg.list <- apply(X = neg.mt, MARGIN = 1,
                         FUN = function(x) {
                           maxposition <- which.max(x[1:margin])
                           if (x[maxposition] >= signalThresholdBeingTranscribed) {
                             maxposition
                           } else {
                             NA_integer_
                           }
                         }
)




# Get summit position relative to the enhancer center
gr$pos_summit <- summit_pos.list - margin -1
gr$neg_summit <- summit_neg.list - margin -1

gr <- gr[!is.na(gr$pos_summit) | !is.na(gr$neg_summit)]

# Make sure the postive summit is at the right side of the negative summit
#gr <- gr[gr$pos_summit > gr$neg_summit,] #This line won't work with the NAs but it should not happened with Simon's way

# Calculate summit distance
gr$summit_distance <- gr$pos_summit - gr$neg_summit

# Order enhancer granges based on summit distance
gr <- gr[order(gr$summit_distance, decreasing = T)]

#Reassembling the ranges based on the newly determined negative and positive summit.
ranges <-  plyranges::as_iranges(do.call(rbind, parallel::mclapply(X = seq(length(gr)), FUN = function(row) {
  if (is.na(gr[row]$pos_summit) & !is.na(gr[row]$neg_summit)) {
    as.data.frame(IRanges(start = start(gr[row]) + gr[row]$neg_summit, end = start(gr[row]) + gr[row]$neg_summit))
  } else if (!is.na(gr[row]$pos_summit) & is.na(gr[row]$neg_summit)){
    as.data.frame(IRanges(start = start(gr[row]) + gr[row]$pos_summit, end = start(gr[row]) + gr[row]$pos_summit))
  } else if (!is.na(gr[row]$pos_summit) & !is.na(gr[row]$neg_summit)) {
    as.data.frame(IRanges(start = start(gr[row]) + gr[row]$neg_summit, end = start(gr[row]) + gr[row]$pos_summit))
  }
}, mc.cores = opt$numworkers)))

strands <- do.call(c, parallel::mclapply(X = seq(length(gr)), FUN = function(row) {
  if (is.na(gr[row]$pos_summit) & !is.na(gr[row]$neg_summit)) {
    "-"
  } else if (!is.na(gr[row]$pos_summit) & is.na(gr[row]$neg_summit)){
    "+"
  } else if (!is.na(gr[row]$pos_summit) & !is.na(gr[row]$neg_summit)) {
    "+"
  }
}, mc.cores = opt$numworkers))

true_signal_CAGE <-  do.call(c, parallel::mclapply(X = seq(length(gr)), FUN = function(row) {
  if (is.na(gr[row]$pos_summit) & !is.na(gr[row]$neg_summit)) {
    "unidirectional"
  } else if (!is.na(gr[row]$pos_summit) & is.na(gr[row]$neg_summit)){
    "unidirectional"
  } else if (!is.na(gr[row]$pos_summit) & !is.na(gr[row]$neg_summit)) {
    "bidirectional"
  }
}, mc.cores = opt$numworkers))


rearranged_gr <- GRanges(seqnames = seqnames(gr), ranges = ranges, strand = strands)
elementMetadata(rearranged_gr) <- elementMetadata(gr)
rearranged_gr$neg_summit <- start(rearranged_gr)
rearranged_gr$pos_summit <- end(rearranged_gr)
rearranged_gr$true_signal_cage <- true_signal_CAGE
rearranged_gr_BC <- resize(rearranged_gr, 1, "center")
rearranged_gr_BC$CageFightR <- "bidirectional"

rm(rearranged_gr, true_signal_CAGE, strands, ranges, gr, summit_neg.list, summit_pos.list, neg.mt, pos.mt, margin)

invisible(gc())

##############################################
#      Unidirectional clusters analysis      #
##############################################
message("==========> Unidirectional clusters analysis...")

# Resize the CAGE unidirectional on the highest TPM found = "thick" column
gr <- GRanges(seqnames = seqnames(Unidirectional_CAGE_calls), ranges = Unidirectional_CAGE_calls$thick, strand = strand(Unidirectional_CAGE_calls))
gr <- check_chromosome_boundaries(gr[seqnames(gr) != "chrM"], resize_boundary = upstreamMargin + downstreamMargin, genome = bsgenome)

# Get metapeak matrix for CAGE-seq
mt <- exo_metapeak_matrix(gr, sample = cage.bw, upstream = upstreamMargin, downstream = downstreamMargin)

# Find CAGE-seq summit
pos.mt <- mt["pos"][[1]]
neg.mt <- mt["neg"][[1]]

#Identifying where the summit on positive strand and negative strand are. Remove any maximal position below a certain threshold determined by signalThresholdBeingTranscribed
summit_neg.list <- apply(X = neg.mt, MARGIN = 1, FUN = function(x) {
  if (length(unique(x)) == 1 & all(x == 0)) { #If all the coordinates are null on the opposite strand return NA
    NA_integer_
  } else { #If there is a max position else than 0
    maxposition <- which.max(x) #Where is the max position
    if (x[maxposition] >= signalThresholdBeingTranscribed) { #If this maxposition return a value greater than the threshold return it
      maxposition
    } else { # If not, return NA
      NA_integer_
    }
  }
})

summit_pos.list <- apply(X = pos.mt, MARGIN = 1, FUN = function(x) {
  if (x[upstreamMargin + downstreamMargin] >= signalThresholdBeingTranscribed) {
    0
  } else { # If not, return NA
    NA_integer_
  }
})

# Get summit position relative to the CAGE signal
gr$neg_summit <- summit_neg.list - upstreamMargin - 1
gr$pos_summit <- summit_pos.list

# Calculate summit distance
gr$summit_distance <- gr$pos_summit - gr$neg_summit

#Remove the ranges without positive and negative summit
gr <- gr[!(is.na(gr$pos_summit) & is.na(gr$neg_summit))]
gr <- gr[!(is.na(gr$pos_summit) & !is.na(gr$neg_summit))]

gr <- gr[order(gr$summit_distance, decreasing = T)]


#Reassembling the ranges based on the newly determined negative and positive summit.

ranges <-  plyranges::as_iranges(do.call(rbind, parallel::mclapply(X = seq(length(gr)), FUN = function(row) {
  if (is.na(gr[row]$neg_summit)){
    as.data.frame(IRanges(start = start(gr[row]), end = start(gr[row])))
  } else if (!is.na(gr[row]$neg_summit)) {
    if (as.character(strand(gr[row])) == "+") {
      as.data.frame(IRanges(start = start(gr[row]) + gr[row]$neg_summit, end = start(gr[row]) + gr[row]$pos_summit))
    } else if (as.character(strand(gr[row])) == "-") {
      as.data.frame(IRanges(start = start(gr[row]) + gr[row]$pos_summit, end = start(gr[row]) - gr[row]$neg_summit))
    }
  }
}, mc.cores = opt$numworkers)))

true_signal_CAGE <-  do.call(c, parallel::mclapply(X = seq(length(gr)), FUN = function(row) {
  if (is.na(gr[row]$pos_summit) & !is.na(gr[row]$neg_summit)) {
    "unidirectional"
  } else if (!is.na(gr[row]$pos_summit) & is.na(gr[row]$neg_summit)){
    "unidirectional"
  } else if (!is.na(gr[row]$pos_summit) & !is.na(gr[row]$neg_summit)) {
    "bidirectional"
  }
}, mc.cores = opt$numworkers))

rearranged_gr <- GRanges(seqnames = seqnames(gr), ranges = ranges, strand = strand(gr))
elementMetadata(rearranged_gr) <- elementMetadata(gr)
rearranged_gr$neg_summit <- start(rearranged_gr)
rearranged_gr$pos_summit <- end(rearranged_gr)
rearranged_gr$true_signal_cage <- true_signal_CAGE
rearranged_gr <- resize(rearranged_gr, 1, "center")

# Order promoter granges based on summit distance
rearranged_gr_UC <- rearranged_gr[order(rearranged_gr$summit_distance, decreasing = T)]

rearranged_gr_UC$CageFightR <- "unidirectional"

rm(rearranged_gr, true_signal_CAGE, ranges, gr, summit_neg.list, summit_pos.list, neg.mt, pos.mt)

invisible(gc())

##############################################################################
#       Merge uni and bi-directional CAGE calls to filter them properly      #
##############################################################################
message("==========> Merge data from the previous analysis...")

cage_bidirectional <- c(rearranged_gr_UC[rearranged_gr_UC$true_signal_cage == "bidirectional"], rearranged_gr_BC[rearranged_gr_BC$true_signal_cage == "bidirectional"])
gr <- GRanges(seqnames = seqnames(cage_bidirectional), ranges = IRanges(start = cage_bidirectional$neg_summit, end = cage_bidirectional$pos_summit), strand = strand(cage_bidirectional))
gr <- GenomicRanges::reduce(gr, ignore.strand=TRUE)
cage_bidirectional <- gr[order(width(gr), decreasing = TRUE)]

cage_unidirectional <- c(rearranged_gr_UC[rearranged_gr_UC$true_signal_cage == "unidirectional"], rearranged_gr_BC[rearranged_gr_BC$true_signal_cage == "unidirectional"])
cage_unidirectional <- GenomicRanges::reduce(cage_unidirectional, ignore.strand=FALSE)

#NOTE : These cage positions are both taking both promoters and enhancers

#################################################################################################
#       Filters BC and UC clusters based on their genome location (enhancers vs promoters)      #
#################################################################################################
message("==========> Annotating the CAGE positions based the genome...")

### First annotation of the bidirectional clusters with the genome annotation
cage_bidirectional <- assignTxType(cage_bidirectional, txModels=txdb, outputColumn = "txType",
                                   swap = NULL,
                                   tssUpstream = tssUpstream,
                                   tssDownstream = tssDownstream,
                                   proximalUpstream = proximalUpstream,
                                   detailedAntisense = FALSE)

#Then annotation of the unidirectional clusters with the genome annotation
cage_unidirectional <- assignTxType(cage_unidirectional, txModels=txdb, outputColumn = "txType",
                                    swap = NULL,
                                    tssUpstream = tssUpstream,
                                    tssDownstream = tssDownstream,
                                    proximalUpstream = proximalUpstream,
                                    detailedAntisense = FALSE)

message("===============> Filtering the CAGE positions based the genome annotation...")
############# Bidirectional enhancers #############
cage_bidirectional_enhancers <- subset(cage_bidirectional, txType %in% c("intergenic", "intron", "antisense_intron"))

names(cage_bidirectional_enhancers) <- as.character(cage_bidirectional_enhancers)
cage_bidirectional_enhancers$summit_distance <- abs(start(cage_bidirectional_enhancers) - end(cage_bidirectional_enhancers))

inr_gr_bidirectional_enhancers <- GRanges(seqnames = c(seqnames(cage_bidirectional_enhancers), seqnames(cage_bidirectional_enhancers)),
                                          ranges = c(IRanges(start = start(cage_bidirectional_enhancers), end = start(cage_bidirectional_enhancers)),
                                                     IRanges(start = end(cage_bidirectional_enhancers), end = end(cage_bidirectional_enhancers)) ),
                                          strand = c (rep("-", length(cage_bidirectional_enhancers)), rep("+", length(cage_bidirectional_enhancers))),
                                          txType = cage_bidirectional_enhancers$txType)

inr_gr_bidirectional_enhancers$sequence <- getSeq(bsgenome, resize(x = inr_gr_bidirectional_enhancers, width = 3, fix = "start"))
# #Order initiator motifs based on their sequence
inr_gr_bidirectional_enhancers <- inr_gr_bidirectional_enhancers[order(inr_gr_bidirectional_enhancers$sequence),]

############# Unidirectional enhancers #############
cage_unidirectional_enhancers <- subset(cage_unidirectional, txType %in% c("intergenic", "intron", "antisense_intron"))

names(cage_unidirectional_enhancers) <- as.character(cage_unidirectional_enhancers)

inr_gr_unidirectional_enhancers <- cage_unidirectional_enhancers
inr_gr_unidirectional_enhancers$sequence <- getSeq(bsgenome, resize(x = inr_gr_unidirectional_enhancers, width = 3, fix = "start"))
# #Order initiator motifs based on their sequence
inr_gr_unidirectional_enhancers <- inr_gr_unidirectional_enhancers[order(inr_gr_unidirectional_enhancers$sequence),]


############# Bidirectional promoters #############
cage_bidirectional_promoters <- subset(cage_bidirectional, txType %in% c("promoter", "antisense_promoter", "fiveUTR", "antisense_fiveUTR"))

names(cage_bidirectional_promoters) <- as.character(cage_bidirectional_promoters)
cage_bidirectional_promoters$summit_distance <- abs(start(cage_bidirectional_promoters) - end(cage_bidirectional_promoters))

inr_gr_bidirectional_promoters <- GRanges(seqnames = c(seqnames(cage_bidirectional_promoters), seqnames(cage_bidirectional_promoters)),
                                          ranges = c(IRanges(start = start(cage_bidirectional_promoters), end = start(cage_bidirectional_promoters)),
                                                     IRanges(start = end(cage_bidirectional_promoters), end = end(cage_bidirectional_promoters)) ),
                                          strand = c (rep("-", length(cage_bidirectional_promoters)), rep("+", length(cage_bidirectional_promoters))),
                                          txType = cage_bidirectional_promoters$txType)

inr_gr_bidirectional_promoters$sequence <- getSeq(bsgenome, resize(x = inr_gr_bidirectional_promoters, width = 3, fix = "start"))
# #Order initiator motifs based on their sequence
inr_gr_bidirectional_promoters <- inr_gr_bidirectional_promoters[order(inr_gr_bidirectional_promoters$sequence),]


############# Unidirectional promoters #############
cage_unidirectional_promoters <- subset(cage_unidirectional, txType %in% c("promoter", "antisense_promoter", "fiveUTR", "antisense_fiveUTR"))

names(cage_unidirectional_promoters) <- as.character(cage_unidirectional_promoters)

inr_gr_unidirectional_promoters <- cage_unidirectional_promoters
inr_gr_unidirectional_promoters$sequence <- getSeq(bsgenome, resize(x = inr_gr_unidirectional_promoters, width = 3, fix = "start"))
# #Order initiator motifs based on their sequence
inr_gr_unidirectional_promoters <- inr_gr_unidirectional_promoters[order(inr_gr_unidirectional_promoters$sequence),]


all_inr_gr <- c(inr_gr_unidirectional_promoters, inr_gr_bidirectional_promoters, inr_gr_unidirectional_enhancers, inr_gr_bidirectional_enhancers)

############# Save data #############
message("===============> Saving data...")
if (any(opt$saveAs == "bed", opt$saveAs == "all")) {
  export.bed(object = cage_bidirectional_enhancers, con = paste(gsub("pos|positive|.pos|.positive|_pos|_positive", "", basename(tools::file_path_sans_ext(opt$bigwig_positive))), "_region_bi_enh.bed", sep = ""))
  export.bed(object = inr_gr_bidirectional_enhancers, con = paste(gsub("pos|positive|.pos|.positive|_pos|_positive", "", basename(tools::file_path_sans_ext(opt$bigwig_positive))), "_inr_bi_enh.bed", sep = ""))
  export.bed(object = cage_unidirectional_enhancers, con = paste(gsub("pos|positive|.pos|.positive|_pos|_positive", "", basename(tools::file_path_sans_ext(opt$bigwig_positive))), "_region_uni_enh.bed", sep = ""))
  export.bed(object = inr_gr_unidirectional_enhancers, con = paste(gsub("pos|positive|.pos|.positive|_pos|_positive", "", basename(tools::file_path_sans_ext(opt$bigwig_positive))), "_inr_uni_enh.bed", sep = ""))
  export.bed(object = cage_bidirectional_promoters, con = paste(gsub("pos|positive|.pos|.positive|_pos|_positive", "", basename(tools::file_path_sans_ext(opt$bigwig_positive))), "_region_bi_prom.bed", sep = ""))
  export.bed(object = inr_gr_bidirectional_promoters, con = paste(gsub("pos|positive|.pos|.positive|_pos|_positive", "", basename(tools::file_path_sans_ext(opt$bigwig_positive))), "_inr_bi_prom.bed", sep = ""))
  export.bed(object = cage_unidirectional_promoters, con = paste(gsub("pos|positive|.pos|.positive|_pos|_positive", "", basename(tools::file_path_sans_ext(opt$bigwig_positive))), "_region_uni_prom.bed", sep = ""))
  export.bed(object = inr_gr_unidirectional_promoters, con = paste(gsub("pos|positive|.pos|.positive|_pos|_positive", "", basename(tools::file_path_sans_ext(opt$bigwig_positive))), "_inr_uni_prom.bed", sep = ""))
}
if (any(opt$saveAs == "rds", opt$saveAs == "all")) {
  saveRDS(object = cage_bidirectional_enhancers, file = paste(gsub("pos|positive|.pos|.positive|_pos|_positive", "", basename(tools::file_path_sans_ext(opt$bigwig_positive))), "_region_bi_enh.rds", sep = ""))
  saveRDS(object = inr_gr_bidirectional_enhancers, file = paste(gsub("pos|positive|.pos|.positive|_pos|_positive", "", basename(tools::file_path_sans_ext(opt$bigwig_positive))), "_inr_bi_enh.rds", sep = ""))
  saveRDS(object = cage_unidirectional_enhancers, file = paste(gsub("pos|positive|.pos|.positive|_pos|_positive", "", basename(tools::file_path_sans_ext(opt$bigwig_positive))), "_region_uni_enh.rds", sep = ""))
  saveRDS(object = inr_gr_unidirectional_enhancers, file = paste(gsub("pos|positive|.pos|.positive|_pos|_positive", "", basename(tools::file_path_sans_ext(opt$bigwig_positive))), "_inr_uni_enh.rds", sep = ""))
  saveRDS(object = cage_bidirectional_promoters, file = paste(gsub("pos|positive|.pos|.positive|_pos|_positive", "", basename(tools::file_path_sans_ext(opt$bigwig_positive))), "_region_bi_prom.rds", sep = ""))
  saveRDS(object = inr_gr_bidirectional_promoters, file = paste(gsub("pos|positive|.pos|.positive|_pos|_positive", "", basename(tools::file_path_sans_ext(opt$bigwig_positive))), "_inr_bi_prom.rds", sep = ""))
  saveRDS(object = cage_unidirectional_promoters, file = paste(gsub("pos|positive|.pos|.positive|_pos|_positive", "", basename(tools::file_path_sans_ext(opt$bigwig_positive))), "_region_uni_prom.rds", sep = ""))
  saveRDS(object = inr_gr_unidirectional_promoters, file = paste(gsub("pos|positive|.pos|.positive|_pos|_positive", "", basename(tools::file_path_sans_ext(opt$bigwig_positive))), "_inr_uni_prom.rds", sep = ""))
}

file.remove(temp_bw_pos)
file.remove(temp_bw_neg)
