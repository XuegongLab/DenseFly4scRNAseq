library(splatter)
library(scater)
params <-newSplatParams()
params <-setParams(params,batchCells=c(1000,1000),batch.facScale=0.15,group.prob=c(0.3,0.3,0.4))
sim <-splatSimulate(params,method="groups",verbose = FALSE)
#write the data and label to a txt file
data <-counts(sim)
data <-t(data)
batch <-colData(sim)[2]
label <-colData(sim)[3]
write.table(cbind(data,batch,label),"E:/study/±ÏÉè/07exprinment_data/Batch_Data.txt",quote = FALSE,row.names = FALSE, col.names = FALSE)
#visualization
sim <-normalise(sim)
plotPCA(sim,shape_by="Batch",colour_by="Group")
