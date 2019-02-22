############################################################
#Purpose: Code to format CNA Data Columns
#Author: Pichai Raman
#Date: 2/21/2019
############################################################

args <- commandArgs(trailingOnly = TRUE)


#################################################
#Load Packages and Scripts
#################################################

#Libraries
library("tidyverse");

#Read in data & Flip to same format
cnaData <- read.delim(args[1], check.names=F);
cnaData <- cnaData[!grepl("\\.", rownames(cnaData)),]
cnaData <- cnaData[!grepl("-", rownames(cnaData)),]
cnaData <- cnaData[!grepl("MTAT", rownames(cnaData)),]
cnaData <- cnaData[!grepl("MTND", rownames(cnaData)),]

cnaDataT <- data.frame(t(cnaData));

#Pick out interesting features
getCNAGenesUp <- function(x)
{
	myOut <- sum(na.omit(x)>3);
	return(myOut);
}
cnaFeaturesUP <- sapply(cnaDataT, FUN=getCNAGenesUp)
cnaFeaturesUP <- names(sort(cnaFeaturesUP, T)[1:20]);

getCNAGenesDown <- function(x)
{
	myOut <- sum(na.omit(x)<2);
	return(myOut);
}
cnaFeaturesDown <- sapply(cnaDataT, FUN=getCNAGenesDown)
cnaFeaturesDown <- names(sort(cnaFeaturesDown, T)[1:20]);

keepFeatures <- c(cnaFeaturesUP, cnaFeaturesDown);

cnaDataTOut <- cnaDataT[,keepFeatures]
colnames(cnaDataTOut) <- c(paste(cnaFeaturesUP, "_AMP", sep=""),paste(cnaFeaturesDown, "_DEL", sep="")) 
cnaDataTOut <- data.frame(cnaDataTOut[, 1:20]>3, cnaDataTOut[,21:40]<2);
rownames(cnaDataTOut) <- colnames(cnaData)
write.table(cnaDataTOut, paste(gsub("\\.txt", "", args[1]), "formatted.txt", sep=""), col.names=T, row.names=T, sep="\t");





