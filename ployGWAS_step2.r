args <- commandArgs()
rep1<- as.character(args[6])
#rep2<- as.character(args[7])

#source("/sharedata/home/xbzhang/software/GWASpoly-master/R/read.GWASpoly.R")
#source("/sharedata/home/xbzhang/software/GWASpoly-master/R/set.K.R")
#source("/sharedata/home/xbzhang/software/GWASpoly-master/R/GWASpoly.R")
#source("/sharedata/home/xbzhang/software/GWASpoly-master/R/write.GWASpoly.R")
library(GWASpoly)
#Name=read.table(rep1,header=T,stringsAsFactors=F)
#Name=colnames(Name)
#Name=Name[-1]

#data <- read.GWASpoly(ploidy=6, pheno.file=rep1, geno.file=rep2,format="ACGT", delim="\t",n.traits=length(Name))
#data.loco <- set.K(data,n.core = 10,LOCO =TRUE)
#save(data.loco,file="data.loco.Rdata")
#N <- 221 #Population size
N <-303
load("data.loco.Rdata")
params <- set.params(geno.freq = 1 - 5/N,n.PC=5,MAF=0.05)
data.loco.scan <- GWASpoly(data=data.loco,models=c("additive","diplo-general"),traits=as.character(rep1),params=params,n.core=1)

write.GWASpoly(data.loco.scan, rep1, paste(rep1,"effects",sep="_"), what = "effects", delim = "\t")
write.GWASpoly(data.loco.scan, rep1, paste(rep1,"scores",sep="_"), what = "scores", delim = "\t")

save(data.loco.scan,file=paste(rep1,".Rdata",sep=""))
#for(i in Name)
#	{
#	write.GWASpoly(data.loco.scan, i, paste(i,"effects",sep="_"), what = "effects", delim = "\t")
#	write.GWASpoly(data.loco.scan, i, paste(i,"scores",sep="_"), what = "scores", delim = "\t")
#	}
