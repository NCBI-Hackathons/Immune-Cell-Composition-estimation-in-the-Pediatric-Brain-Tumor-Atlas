#################################################
#Purpose: Code to Read in pedcbio data & create matrix
#Date: 1/28/2019
#Author: Pichai Raman
#################################################

args <- commandArgs(trailingOnly = TRUE)

if (length(args)==0) {
  args[1] = "../pedcbioportal-datahub/public";
  args[2] = "../data/formatted/";
} else if (length(args)==1) {
  # default output file
  args[2] = "../data/formatted/"
}



#################################################
#Load Packages and Scripts
#################################################

#Libraries
library("tidyverse");
library("Rtsne")
library("RColorBrewer")
library("randomcoloR")
library("preprocessCore");
library("gdata");

baseDir <- args[1]
myDirs <- list.dirs(baseDir);
myDirs <- myDirs[grep("cbttc", myDirs)]
myDirs <- myDirs[!grepl("case_lists", myDirs)]

##########################################################
#Establish base RNA, CNA, Mutation, and Clinical Matrices
##########################################################

#Get RNA Gene List
tmpDir <- myDirs[1]
rnaMat <- read.delim(paste(tmpDir, "/data_rna_seq_v2_mrna.txt", sep=""), stringsAsFactors=F);
geneOrderRNA <- rnaMat[,1];

#CNA
cnaMat <- read.delim(paste(tmpDir, "/data_linear_CNA.txt", sep=""), stringsAsFactors=F);
geneOrderCNA <- cnaMat[,1];


#Create RNA Matrix
getRNAData<- function(myDir)
{
	rnaMat <- read.delim(paste(myDir, "/data_rna_seq_v2_mrna.txt", sep=""));
	rownames(rnaMat) <- rnaMat[,1];
	rnaMat <- rnaMat[geneOrderRNA,]
	rnaMat <- rnaMat[-1];
	return(rnaMat);
}
RNAList <- lapply(myDirs, FUN=getRNAData)
RNAMat <- do.call("cbind", RNAList);
colnames(RNAMat) <- gsub("X", "", colnames(RNAMat))
colnames(RNAMat) <- gsub("\\.", "-", colnames(RNAMat))
RNAMat <- RNAMat[,!duplicated(colnames(RNAMat))]

#Create CNA Matrix
getCNAData<- function(myDir)
{
	cnaMat <- read.delim(paste(myDir, "/data_linear_CNA.txt", sep=""));
	rownames(cnaMat) <- cnaMat[,1];
	cnaMat <- cnaMat[geneOrderCNA,]
	cnaMat <- cnaMat[-1];
	return(cnaMat);
}
CNAList <- lapply(myDirs, FUN=getCNAData)
CNAMat <- do.call("cbind", CNAList);
colnames(CNAMat) <- gsub("X", "", colnames(CNAMat))
colnames(CNAMat) <- gsub("\\.", "-", colnames(CNAMat))
CNAMat <- CNAMat[,!duplicated(colnames(CNAMat))]


#Create Mutation Data
getMutationData <- function(myDir)
{
	mutMat <- read.delim(paste(myDir, "/data_mutations_extended.txt", sep=""), skip=1);
	return(mutMat);
}
MUTList <- lapply(myDirs, FUN=getMutationData)
MutData <- do.call("rbind", MUTList);

#Create Clinical Data
getClinData <- function(myDir)
{
	clinMat <- read.delim(paste(myDir, "/data_clinical_patient.txt", sep=""), skip=4);
	sampMat <- read.delim(paste(myDir, "/data_clinical_sample.txt", sep=""), skip=4);
	clinMat <- merge(clinMat, sampMat, by="PATIENT_ID");
	return(clinMat);
}
CLINList <- lapply(myDirs, FUN=getClinData)
ClinData <- do.call("rbind", CLINList);


###################################
#Write out to a specific directory
###################################
outputDir <- args[2]
system(paste("mkdir", outputDir, sep=" "));
write.table(RNAMat, paste(outputDir, "RNAMat.txt", sep="/"), row.names=T,sep="\t")
write.table(CNAMat, paste(outputDir, "CNAMat.txt", sep="/"), row.names=T,sep="\t")
write.table(MutData, paste(outputDir, "MutData.txt", sep="/"), row.names=T,sep="\t")
write.table(ClinData, paste(outputDir, "ClinData.txt", sep="/"), row.names=T,sep="\t")

#Save as RData as well
keep(outputDir, RNAMat, CNAMat, MutData, ClinData, sure=TRUE)
save.image(paste(outputDir, "PBTAFull.RData", sep="/"))






























