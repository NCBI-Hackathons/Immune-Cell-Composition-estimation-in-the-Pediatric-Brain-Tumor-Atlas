############################################################
#Purpose: Code to compare any data to matrix of immuneCells
#Author: Pichai Raman
#Date: 2/21/2019
#Argument 1 is data frame of clinical or genomic data
#Argument 2 is matrix of immune cell values
#Argument 3 is the output directory
############################################################

args <- commandArgs(trailingOnly = TRUE)

if (length(args)==0) {
  args[1] = "../pedcbioportal-datahub/public";
  args[2] = "../data/formatted/";
} else if (length(args)==1) {
  args[2] = "../data/formatted/"
}

#################################################
#Load Packages and Scripts
#################################################

#Libraries
library("tidyverse");
library("ggpubr")

#Read in data
imcDF <- read.delim(args[1], stringsAsFactors=F, check.names=F)
matDF <- read.delim(args[2], stringsAsFactors=F, row.names=1)

###########################################
#Make sure column and rownames are the same
###########################################

#Find intersected samples
intSamples <- intersect(rownames(matDF), colnames(imcDF))

#Keep same order
matDF <- matDF[intSamples,]
imcDF <- imcDF[,intSamples]


###########################################
#Univariate Analysis
###########################################

#Categorical Feature
catAnalysisMatix <- function(myCat)
{
	myOut <- apply(imcDF, FUN=catAnalysisVar, MARGIN=1, myCat=myCat)
}
#Compare a categorial column to a numeric column - ANOVA
catAnalysisVar <- function(imcNum=NULL, myCat=NULL)
{
	catPValue <- kruskal.test(imcNum, as.factor(myCat));
	return(catPValue$p.value);
}

#Numerical Feature
numAnalysisMatix <- function(myNum)
{
	myOut <- apply(imcDF, FUN=numAnalysisVar, MARGIN=1, myNum=myNum)
}
#Compare a categorial column to a numeric column - ANOVA
numAnalysisVar <- function(imcNum=NULL, myNum=NULL)
{
	corPValue <- cor.test(imcNum, myNum);
	return(corPValue$p.value);
}

#Master Function to run and compile results
masterComparisonUnivariate <- function(matDF=NULL, imcDF=NULL)
{
	myList <- list();
	for(i in 1:ncol(matDF))
	{
		myCol <- matDF[,i];
		if(is.numeric(myCol))
		{	
			myP <- numAnalysisMatix(myCol);
		}
		if(!is.numeric(myCol))
		{	
			myP <- catAnalysisMatix(myCol);
		}
		myList[[colnames(matDF)[i]]]<- myP
	}
	myDF <- data.frame(t(data.frame(myList)));
	return(myDF);
}

########################################
#Run Analysis and output graphs & tables
########################################

#Run Analysis and print table
myOut <- masterComparisonUnivariate(matDF, imcDF)
system(paste("mkdir ", args[3], sep=""))
write.table(myOut, paste(args[3], "/PvalTable.txt", sep=""), sep="\t", row.names=T)

#Barplots of P-values
myOutTS <- myOut;
myOutTS[,"Variable"] <- rownames(myOutTS);
myOutTS <- gather(myOutTS, key="ImmCell", value="pval", -Variable);
myOutTS[,"sig"] <- ifelse(myOutTS[,"pval"]<0.01, "<0.01", "Not Significant")
myVars <- unique(myOutTS[,"Variable"])
for(i in 1:length(myVars))
{
	myOutTSTmp <- myOutTS[myOutTS[,"Variable"]==myVars[i],]
	p <- ggplot(myOutTSTmp, aes(ImmCell, -log10(pval)))+geom_bar(stat="identity")+theme_bw()+geom_hline(yintercept=2, linetype="dashed")
	p <- p+ggpubr::rotate_x_text()+ylab("-log10 P-value")+xlab("Immune Cell Type")
	p
	ggsave(paste(args[3], "/", myVars[i],"_BarPlot_PValues.png", sep=""), width=10, height=8)
}














