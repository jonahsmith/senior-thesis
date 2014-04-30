load('fullSet.RData')
library(mi)
library(vegan)
library(psych)


dataset1<-completedData[[1]]
dataset2<-completedData[[2]]
nonCogIndices <- which(names(dataset1) == "Q9A6A"):which(names(dataset1) == "Q9A6II")

difs <- c()
vars <- c()
refLoadings<-factanal(dataset1[,nonCogIndices], 1, scores="regression")$loadings
withScores <- list()
for (i in 1:length(completedData)){
	dataset <- completedData[[i]]	
	withScores[[i]] <- dataset
	
	origLoadings<-factanal(dataset[,nonCogIndices], 1)$loadings
	transLoadings<-fitted(procrustes(as.matrix(refLoadings), as.matrix(origLoadings), choices=1))
	nonCog<-factor.scores(dataset[nonCogIndices],transLoadings)$scores
	withScores[[i]]$nonCog <- nonCog
}

save(withScores, file="withScores.RData")