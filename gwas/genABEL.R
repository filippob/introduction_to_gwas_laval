## install GenABEL from source
install.packages("~/Dropbox/cursos/berlin2018/berlin2018/software/GenABEL.data_1.0.0.tar.gz", repos = NULL, type = "source")
install.packages("~/Dropbox/cursos/berlin2018/berlin2018/software/GenABEL_1.8-0.tar.gz", repos = NULL, type = "source")

library("knitr")
library("dplyr")
library("GenABEL")
library("reshape2")
setwd("~/Dropbox/cursos/berlin2018")

# tPed = "data/sheep.tped"
# tFam = "data/sheep.tfam"
# phenotype_file = "data/pheno_genabel.dat"

tPed = "data/rice.tped"
tFam = "data/rice.tfam"
phenotype_file = "data/phenotypes_rice.txt"
  
convert.snp.tped(tped=tPed,
                 tfam=tFam,
                 out="data/rice.raw",
                 strand="+")


df <- load.gwaa.data(phe=phenotype_file, 
                     gen="data/rice.raw",
                     force=TRUE
)


descriptives.marker(df)

mP <- melt(phdata(df))
mP <- mP %>%
  filter(variable != "sex")

kable(head(mP))

qc1 <- check.marker(df, p.level=0)
df1 <- df[,qc1$snpok]

K <- ibs(df1,weight = "freq")
K[upper.tri(K)] = t(K)[upper.tri(K)]

heatmap(K,col=rev(heat.colors(75)))

phdata(df1)
gtdata(df1)@chromosome

h2a <- polygenic(phenotype,data=df1,kin=K,trait.type = "gaussian")
df.mm <- mmscore(h2a,df1)
descriptives.scan(df.mm,top=100)
plot(df.mm,col = c("red", "slateblue"),pch = 19, cex = .5, main="phenotype")

## binary phenotype
setwd("~/Dropbox/cursos/laval2019/alternatives_to_GenABEL/data/")
tPed = "dogs.tped"
tFam = "dogs.tfam"
phenotype_file = "pheno_dogs.txt"

## 
# pp = read.table("pheno_dogs.txt", header = TRUE)
# pp$phenotype = pp$phenotype-1
# write.table(pp, file = "pheno_dogs.txt", col.names = TRUE, quote = FALSE, row.names = FALSE)

convert.snp.tped(tped=tPed,
                 tfam=tFam,
                 out="dogs.raw",
                 strand="+")


df <- load.gwaa.data(phe=phenotype_file, 
                     gen="dogs.raw",
                     force=TRUE
)

descriptives.marker(df)

mP <- melt(phdata(df))
mP <- mP %>%
  filter(variable != "sex")

kable(head(mP))

qc1 <- check.marker(df, p.level=0)
df1 <- df[,qc1$snpok]

K <- ibs(df1,weight = "freq")
K[upper.tri(K)] = t(K)[upper.tri(K)]

heatmap(K,col=rev(heat.colors(75)))

phdata(df1)
gtdata(df1)@chromosome

an0 = qtscore(phenotype,data = df1,trait.type = "binomial")
lambda(an0)

plot(an0)

h2a <- polygenic(phenotype,data=df1,kin=K,trait.type = "binomial",llfun = "polylik")
df.mm <- mmscore(h2a,df1)
descriptives.scan(df.mm,top=100)
plot(df.mm,col = c("red", "slateblue"),pch = 19, cex = .5, main="phenotype")

