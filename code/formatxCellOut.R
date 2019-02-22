############################################################
#Purpose: Code to format xCell Output Columns
#Author: Pichai Raman
#Date: 2/21/2019
# Argument 1: raw xCell output
############################################################

args <- commandArgs(trailingOnly = TRUE)


#################################################
#Load Packages and Scripts
#################################################

#Libraries
library("tidyverse");

#Read in data
tmpData <- read.delim(args[1]);
colnames(tmpData) <- gsub("X", "", colnames(tmpData));
colnames(tmpData) <- gsub("\\.", "-", colnames(tmpData));
rownames(tmpData) <- tmpData[,1];
tmpData <- tmpData[-1];
write.table(tmpData, paste(gsub("\\.txt", "", args[1]), "formatted.txt", sep=""), col.names=T, row.names=T, sep="\t")
