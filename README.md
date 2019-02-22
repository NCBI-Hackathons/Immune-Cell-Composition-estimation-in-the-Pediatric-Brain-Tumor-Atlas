# Immune-Cell-Composition-estimation-in-the-Pediatric-Brain-Tumor-Atlas



## Background

The Pediatric Brain Tumor Atlas is a concerted multi-institution effort by the Children’s Brain Tumor Consortium (CBTTC) and the Pacific Pediatric Neuro-Oncology Consortium to characterize and deeply profile a newly defined cohort of >1,600 brain tumors. Samples are currently profiled with Whole Genome Sequencing, RNA-Sequencing, proteomics, imaging and other platforms with rich phenotypic and longitudinal data. We attempt to generate tumor-resident immune cell molecular profiles and link these profiles to cancer type and outcome, as it has been shown that the concentration and location of immune cells can predict patient outcome on standard and immunotherapy (Galon, J. et al 2006).  
![alt text](https://github.com/NCBI-Hackathons/Immune-Cell-Composition-estimation-in-the-Pediatric-Brain-Tumor-Atlas/images/pbta_overview.svg)

## Project Goals
The first goal of this project is to determine immune cell type composition given available public tools  or offer the opportunity to generate  home-grown tools along with reference gene expression profiles for immune cell types of interest to quantify immune cell types in each cancer. Next, we would like to determine if these immune compositions are correlated to any phenotypic data (disease, subtype, etc..) or genetic lesions/pathways. The ideal output of this analysis would be a model that could predict immune cell composition from phenotypic, lesion, and/or pathway data. The output would also help to further subtype and characterize pediatric brain tumors. Finally, we will containerize our analysis for maximum reproduciblity and portability.
![alt text](https://github.com/NCBI-Hackathons/Immune-Cell-Composition-estimation-in-the-Pediatric-Brain-Tumor-Atlas/images/workflow.svg)

A model that could accurately estimate immune cell composition from phenotypic and diagnostic information could help to characterize tumors which could be used for prognostic and therapeutic purposes. Additionally, understanding how immune cell composition is related to mutations and cancer pathways in pediatric tumors can give us a better understanding of biology of these tumors and how to treat them. 


## Relevant Tools & Data

* [x-cell](http://xcell.ucsf.edu/)
* [imSig](https://cran.r-project.org/web/packages/imsig/index.html)
* [Docker](https://www.docker.com/why-docker)


## Relevant Publications

* [Immune cell profiling in cancer: molecular approaches to cell-specific identification](https://www.nature.com/articles/s41698-017-0031-0)
* [Profiling Tumor Infiltrating Immune Cells with CIBERSORT.](https://www.ncbi.nlm.nih.gov/pubmed/29344893)
* [ImmQuant: a user-friendly tool for inferring immune cell-type composition from gene-expression data](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5167062/)
* [Quantifying tumor-infiltrating immune cells from transcriptomics data](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6006237/)
* [Single-Cell Map of Diverse Immune Phenotypes in the Breast Tumor Microenvironment.](https://www.ncbi.nlm.nih.gov/pubmed/29961579)
* [Bulk tissue cell type deconvolution with multi-subject single-cell expression reference](https://www.nature.com/articles/s41467-018-08023-x)
* [Immune Cell Gene Signatures for Profiling the Microenvironment of Solid Tumors](http://cancerimmunolres.aacrjournals.org/content/6/11/1388)

## Data Access
* https://docs.google.com/document/d/1GvNZZxYSZauWJrChoq8vQAjHmGHpzPzSrYyjxQfNMiE/edit
* https://drive.google.com/drive/u/0/folders/1KsaatILhTPNCZdDWAtioWB7bfLMmDDWg
* https://pedcbioportal.org/study?id=5c0593f0e4b0185134fb4de8#summary

**Please register with [pedcbioportal](https://pedcbioportal.org/) before downloading data**

