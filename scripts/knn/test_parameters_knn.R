##################################################################
############## KNN: Load Test Parameters #########################
##################################################################

rm(list=ls())

#setwd(paste(getwd(),"/_projeto_dissertacao/code/scripts/knn", sep=""))

parameters_3h<-read.csv("labels-knn/3h/parametros_3h.txt", header = TRUE, sep=",")
colnames(parameters_3h)<-c("janela_3h", "threshold")
parameters_3h

parameters_6h<-read.csv("labels-knn/6h/parametros_6h.txt", header = TRUE, sep=",")
colnames(parameters_6h)<-c("janela_6h", "threshold")
parameters_6h

parameters_12h<-read.csv("labels-knn/12h/parametros_12h.txt", header = TRUE, sep=",")
colnames(parameters_12h)<-c("janela_12h", "threshold")
parameters_12h

parameters_24h<-read.csv("labels-knn/24h/parametros_24h.txt", header = TRUE, sep=",")
colnames(parameters_24h)<-c("janela_24h", "threshold")
parameters_24h

save(list=ls(), file="load_data/test_parameters_knn.RData")