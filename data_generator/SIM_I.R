library(splatter)
library(scater)
params <-newSplatParams()
params<-setParams(params,update=list(nGenes=10000,batchCells=2000,de.prob=0.08))
sim <- splatSimulate(params,group.prob=c(0.3,0.3,0.3,0.05,0.05),method="groups",verbose = FALSE)
#write the data and label to a txt file
data<-counts(sim)
data <-t(data)
label<-colData(sim)[3]
write.table(cbind(data,label),"SelfMapping.txt")
#visualization
sim<-normalise(sim)
plotPCA(sim)
