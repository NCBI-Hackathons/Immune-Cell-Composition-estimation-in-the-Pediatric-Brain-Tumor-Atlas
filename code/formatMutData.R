############################################################
#Purpose: Code to format Mutation Data Columns
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
mutDataRaw <- read.delim(args[1], check.names=F);

#################################################
#Filter the mutation data & to Cancer Genes
#################################################
mutData <- mutDataRaw;
mutData <- mutData[mutData[,"Existing_variation"]!="",]
mutData <- mutData[grepl("COSM", mutData[,"Existing_variation"]),]
myCancerGenes <- read.delim("./CancerGeneList.tsv")
myCancerGenes <- as.character(myCancerGenes[,1]);
mutData <- mutData[mutData[,1]%in%myCancerGenes,]
freqTable <- table(mutData[,1])
keepGenes <- sort(freqTable, T)[1:50]
mutData <- mutData[mutData[,1]%in%names(keepGenes),]

#################################################
#Format matrix
#################################################
mutData <- mutData[,c("Hugo_Symbol", "Tumor_Sample_Barcode")];
mutData <- unique(mutData);
mutData[,"Type"] <- "Mutated"
out <- mutData %>% spread(Hugo_Symbol, Type, fill="Normal");
rownames(out) <- out[,1]
out <- out[-1];
write.table(out, paste(gsub("\\.txt", "", args[1]), "formatted.txt", sep=""), col.names=T, row.names=T, sep="\t");





