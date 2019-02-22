############################################################
#Purpose: Code to format clinData Output Columns
#Author: Pichai Raman
#Date: 2/21/2019
############################################################

args <- commandArgs(trailingOnly = TRUE)

#################################################
#Load Packages and Scripts
#################################################

#Libraries
library("tidyverse");

#Read in data
clinData <- read.delim("../../pbta/data/formatted/ClinData.txt");
myDups <- data.frame(table(clinData[,"SAMPLE_ID"]));
clinData <- merge(clinData, myDups, by.x="SAMPLE_ID", by.y="Var1")


clinDataDups <- clinData[clinData[,"Freq"]>1,]
myDups <- clinDataDups %>% group_by(SAMPLE_ID) %>% summarize(paste(unique(CANCER_TYPE), collapse=","), paste(unique(TUMOR_SITE), collapse=","), paste(unique(CANCER_TYPE_DETAILED), collapse=","))
myDups <- data.frame(myDups);
colnames(myDups) <- c("SAMPLE_ID", "CANCER_TYPE_D", "TUMOR_SITE_D", "CANCER_TYPE_DETAILED_D");
clinData <- merge(clinData, myDups, by="SAMPLE_ID", all.x=T);
clinData[,"CANCER_TYPE"] <- as.character(clinData[,"CANCER_TYPE"]);
clinData[,"CANCER_TYPE_D"] <- as.character(clinData[,"CANCER_TYPE_D"]);
clinData[,"CANCER_TYPE"] <- ifelse(clinData[,"Freq"]>1, clinData[,"CANCER_TYPE_D"], clinData[,"CANCER_TYPE"])
clinData[,"TUMOR_SITE"] <- as.character(clinData[,"TUMOR_SITE"]);
clinData[,"TUMOR_SITE_D"] <- as.character(clinData[,"TUMOR_SITE_D"]);
clinData[,"TUMOR_SITE"] <- ifelse(clinData[,"Freq"]>1, clinData[,"TUMOR_SITE_D"], clinData[,"TUMOR_SITE"])
clinData[,"CANCER_TYPE_DETAILED"] <- as.character(clinData[,"CANCER_TYPE_DETAILED"]);
clinData[,"CANCER_TYPE_DETAILED_D"] <- as.character(clinData[,"CANCER_TYPE_DETAILED_D"]);
clinData[,"CANCER_TYPE_DETAILED"] <- ifelse(clinData[,"Freq"]>1, clinData[,"CANCER_TYPE_DETAILED_D"], clinData[,"CANCER_TYPE_DETAILED"])
clinData <- clinData[1:19];
clinData <- unique(clinData);
rownames(clinData) <- clinData[,"SAMPLE_ID"]
write.table(clinData, paste(gsub("\\.txt", "", args[1]), "formatted.txt", sep=""), col.names=T, row.names=T, sep="\t");
