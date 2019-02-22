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
matDF <- read.delim(args[1], stringsAsFactors=F)
imcDF <- read.delim(args[2], stringsAsFactors=F, check.names=F)

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
        if(is.character(myCol))
        {	
            myP <- catAnalysisMatix(myCol);
        }
        myList[[colnames(matDF)[i]]]<- myP
    }
    myDF <- data.frame(t(data.frame(myList)));
    return(myDF);
}

run_tests <- function(matDF, imc_df){
    shuffled_names <-  colnames(imc_df) %>% sample( length(.))
    matDF <- matDF[shuffled_names,]
   # print(sum(shuffled_names== colnames(imc_df))/length(shuffled_names))
    colnames(imc_df) <- shuffled_names
    myOut <- masterComparisonUnivariate(matDF, imc_df)
    myOutTS <- myOut;
    myOutTS[,"Variable"] <- rownames(myOutTS);
    myOutTS <- gather(myOutTS, key="ImmCell", value="pval", -Variable);
    num_sig_var <- myOutTS %>% mutate(qval=p.adjust(pval, method = 'BH'), 
                                  sig= ifelse(qval<0.01, "<0.01", "Not Significant")) %>%
        filter(qval < .01) %>% group_by(Variable) %>% summarise(n=n())
    res <- data_frame(Variable=myVars) %>% left_join(num_sig_var, by='Variable') %>% mutate(n=replace(n, is.na(n), 0))
    

}

test_results <-lapply(1:1000,function(x) run_tests(imc_df = imcDF, matDF = matDF))

results <-  reduce(test_results, left_join, by='Variable') %>% t %>% as_data_frame

#load('/Volumes/data/Immune-Cell-Composition-estimation-in-the-Pediatric-Brain-Tumor-Atlas/perm_test_res.Rdata')
colnames(results) <- results[1,]
perm_test_results <- results[-1,] %>% apply(2, as.numeric) %>% as_data_frame
colnames(perm_test_results) <- colnames(results)
actual_results <- myOutTS %>% filter(qval <.01) %>% group_by(Variable) %>% summarise(n())  
nms <- actual_results$Variable
actual_results <- actual_results%>% left_join(data.frame(Variable=myVars), by='Variable') %>% t %>% .[-1,] %>% as.numeric()
names(actual_results) <- nms

plot_list=list()
i <- 1
for(var in names(actual_results)){
   print( actual_results[[var]])
    plot_list[[i]] <-  ggplot()+geom_histogram(data = perm_test_results, aes(x=UQ(as.name(var)) ) )+
    geom_point(data = data_frame(x=actual_results[[var]],y=0),aes(x=x,y=y, col='red')) +
    labs(color='Actual Value') + theme_minimal()
 i <- i+1
}
ggarrange(plotlist = plot_list)

