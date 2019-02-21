library(xCell)
exprMatrix = read.table('/data/RNAMat.txt',header=TRUE,row.names=1, as.is=TRUE)
xCellAnalysis(exprMatrix, file.name = xCellOut.txt, parallel.sz = 16, parallel.type = FORK, rnaseq = TRUE)
