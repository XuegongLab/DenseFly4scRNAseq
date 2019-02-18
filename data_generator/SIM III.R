library(splatter)
library(scater)
params <-newSplatParams()
params<-setParams(params,update=list(nGenes=10000,batchCells=2000, de.prob=0.08,seed=100))
sim <- splatSimulate(params,group.prob=c(0.3,0.3,0.3,0.05,0.05),method="groups",verbose = FALSE)
#count zeros function
count_zeros <- function(x){length(which(x==0))}
#simulate dropout
zero0 <-mean(apply(counts(sim), 2, count_zeros))/10000

sim.drop1 <- splatter:::splatSimDropout(sim, setParams(params,update=list(dropout.type="experiment",dropout.shape=-1,dropout.mid=0)))
zeros <-apply(counts(sim.drop1), 2, count_zeros)
mean(zeros)/10000-zero0

sim.drop2 <- splatter:::splatSimDropout(sim, setParams(params,update=list(dropout.type="experiment",dropout.shape=-1,dropout.mid=1)))
zeros <-apply(counts(sim.drop2), 2, count_zeros)
mean(zeros)/10000-zero0

sim.drop3 <- splatter:::splatSimDropout(sim, setParams(params,update=list(dropout.type="experiment",dropout.shape=-1,dropout.mid=2)))
zeros <-apply(counts(sim.drop3), 2, count_zeros)
mean(zeros)/10000-zero0

sim.drop4 <- splatter:::splatSimDropout(sim, setParams(params,update=list(dropout.type="experiment",dropout.shape=-1,dropout.mid=3)))
zeros <-apply(counts(sim.drop4), 2, count_zeros)
mean(zeros)/10000-zero0

sim.drop5 <- splatter:::splatSimDropout(sim, setParams(params,update=list(dropout.type="experiment",dropout.shape=-1,dropout.mid=6)))
zeros <-apply(counts(sim.drop5), 2, count_zeros)
mean(zeros)/10000-zero0


#write the data and label to a txt file
data0 <-t(counts(sim))
data1 <-t(counts(sim.drop1))
data2 <-t(counts(sim.drop2))
data3 <-t(counts(sim.drop3))
data4 <-t(counts(sim.drop4))
data5 <-t(counts(sim.drop5))
label<-colData(sim)[3]
write.table(cbind(data0,label),"E:/study/毕设/07exprinment_data/Dropout_0_Data.txt")
write.table(cbind(data1,label),"E:/study/毕设/07exprinment_data/Dropout_1_Data.txt")
write.table(cbind(data2,label),"E:/study/毕设/07exprinment_data/Dropout_2_Data.txt")
write.table(cbind(data3,label),"E:/study/毕设/07exprinment_data/Dropout_3_Data.txt")
write.table(cbind(data4,label),"E:/study/毕设/07exprinment_data/Dropout_4_Data.txt")
write.table(cbind(data5,label),"E:/study/毕设/07exprinment_data/Dropout_5_Data.txt")
#visualization
sim<-normalise(sim)
plotPCA(sim)
