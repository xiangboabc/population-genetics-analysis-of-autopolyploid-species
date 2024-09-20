library(adegenet)
library(parallel)
data=read.table("PCA_format")
data=t(data)
x <- new("genlight", data)
pca1 <- glPca(x, nf=3,parallel=TRUE,n.cores=80)
save(pca1,file="pca1_pa.Rdata")

load("pca1_pa.Rdata")
a=pca1$eig
write.table(a,file="PCA.eig",sep="\t",quote=F,col.names=F,row.names=F)

a=pca1$scores
write.table(a,file="PCA.scores",sep="\t",quote=F,col.names=T,row.names=T)
