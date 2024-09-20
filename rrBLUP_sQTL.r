args <- commandArgs()
rep1<- as.character(args[6])
rep2<- as.character(args[7])
rep3<- as.character(args[8])
library(rrBLUP)
library(cvTools)
marker <- read.table(rep1)
pheno <-read.table(rep2)
y <- as.matrix(pheno)
M <- apply(as.matrix(t(marker)),2,as.numeric)
a= A.mat(M,max.missing=0.5,impute.method="mean",return.imputed=T)
b=a$imputed
r=20
k=4
set.seed(2333)
folds <- cvFolds(nrow(y),K = k,R = r)
C=c()
## suppose that y[tst] as the testing set; y[-tst] as the training set
for(i in colnames(b))
	{
	c=as.matrix(b[,i])
	vars <- vector()
	for(ri in 1:r)
		{
	  	for(ki in 1:k)
			{
			tst <- folds$subsets[folds$which == ki,ri]
			pheno_solved <- mixed.solve(y = y[-tst],Z = c[-tst,])
		    ## predict breeding value
			GEBV <- (as.matrix(c[tst,]) %*% pheno_solved$u)
			GEBV <- GEBV[,1]
			y.est <- GEBV + c(pheno_solved$beta)
			y.obs <- y[tst]
			prdct <- cor(y.est,y.obs,use="complete.obs")
			R2 <- (1-(var(y.obs-y.est,na.rm=T)/var(y.obs,na.rm=T)))
			vars <- c(vars,R2)
  			}
		}
	mean_vars <- mean(vars)
	K=c(i,mean_vars)
	C=rbind(C,K)
	#sd_vars <- sd(vars)
	#write.table(mean_vars,file=rep3,quote=T,row.names=F,col.names=F)
	}
write.table(C,file=rep3,quote=T,row.names=F,col.names=F)
