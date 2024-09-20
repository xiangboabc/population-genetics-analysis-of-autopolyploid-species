library(StAMPP)

data=read.table("ALL_SNP_filter.StAMPP.population",header=T)
#data=read.table("4",header=T)
freq <- stamppConvert(data, "r")
D=stamppNeisD(freq, pop=F)
save(D,file="D.Rdata")
