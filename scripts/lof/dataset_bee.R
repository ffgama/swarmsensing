####################################################
############## LOAD DATASET ########################
####################################################

rm(list=ls())

# setwd(paste(getwd(),"/_projeto_dissertacao/code/scripts/lof", sep=""))

dataset_bee <- read.csv("data/abelha-com-anomalia.csv", header=TRUE, sep=",", stringsAsFactors = FALSE)
head(dataset_bee)

save(list=ls(), file = "load_data/dataset_bee.RData")

num_hour <- dataset_bee$hora
index <- 1:length(num_hour)

interval <- seq(1, length(num_hour))

# show temporal serie
plot(x = interval , y = dataset_bee$act[interval], type = "l")
