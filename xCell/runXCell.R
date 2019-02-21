#################################################
#Purpose: Shallow wrapper to call xCell with selected parameters
#Date: 2/21/2019
#Author: Spencer Kelley
#################################################

#Libraries
library("optparse")
library("xCell")


#################################################
#Parse CLI Arguments
#################################################
option_list = list(
  make_option(c("-i", "--input"), type="character", default=NULL, 
              help="dataset file name", metavar="in.txt"),
  make_option(c("-o", "--out"), type="character", default=NULL, 
              help="output file name", metavar="out.txt"),
  make_option(c("-t", "--threads"), type="integer", default=4, 
              help="number of threads to use", metavar="4")
); 

opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser);

if (is.null(opt$input) || is.null(opt$out)){
  print_help(opt_parser)
  stop("Input and output must be supplied", call.=FALSE)
}


##########################################################
#Read input
##########################################################
exprMatrix = read.table(opt$input,header=TRUE,row.names=1, as.is=TRUE)
##########################################################
#Run analysis to generate output
##########################################################
xCellAnalysis(exprMatrix, file.name = opt$output, parallel.sz = opt$threads, parallel.type = FORK, rnaseq = TRUE)
