library("dplyr")
library("ggplot2")
library("data.table")

setwd("pre-processing/")

## ALLELE FREQUENCY

rice.frq <- fread("rice.frq")

rice.frq %>%
  summarise(avg_frq=mean(MAF), std_dev=sd(MAF), max_frq=max(MAF), min_frq=min(MAF))

p <- ggplot(rice.frq, aes(MAF))
p <- p + geom_histogram(binwidth = 0.01)
p

dogs.frqx <- fread("dogs.frqx")
