load('data.Rdata')

# imputation
library(mi)
info <- mi.info(dataSet)
info <- update(info, "type", list("BIOPR97"="unordered-categorical"))
info <- update(info, "type", list("BIOGPR97"="unordered-categorical"))
info <- update(info, "type", list("Q1G3"="ordered-categorical"))
info <- update(info, "type", list("CHRACE"="unordered-categorical"))

multImp<-mi(dataSet, info, n.imp=40, seed=1036, max.minutes=6000)
save.image(file="afterImputation.RData")