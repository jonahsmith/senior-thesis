load(afterImputation.RData)
library(mi)
completedData<-mi.completed(multImp)
save(completedData, file="fullSet.RData")