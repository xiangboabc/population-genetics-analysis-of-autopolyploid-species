library(StAMPP)
data=read.table("ALL_SNP_filter.StAMPP.population",header=T)
#data=read.table("4",header=T)
freq <- stamppConvert(data, "r")
Fst=stamppFst(freq, nboots=100 , percent=95 , nclusters=50)
save(Fst,file="Fst.Rdata")