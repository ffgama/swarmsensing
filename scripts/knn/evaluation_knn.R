################################################################
############## KNN: Evaluation Metrics #########################
################################################################

rm(list=ls())

# setwd(paste(getwd(),"/_projeto_dissertacao/code/scripts/knn", sep=""))

load("load_data/dataset_bee.RData")
load("load_data/knn.RData")
load("load_data/test_parameters_knn.RData")

dataset_user<-read.csv("data/label_usuario.csv", header=FALSE, stringsAsFactors = FALSE)
colnames(dataset_user)<-c("classe")

# organizing suggested points algorithms and user
user<-factor(dataset_user$classe[1:length(label_class)], levels = c("anormal","normal"))
user[!complete.cases(user)]<-c("normal")
algorithm<-factor(label_class, levels = c("anormal","normal"))

# rename the factor levels
levels(user)[levels(user)=="anormal"] <- "anomaly"
levels(algorithm)[levels(algorithm)=="anormal"] <- "anomaly"

truth_table<-table(user, algorithm)

###### ######
###### ###### Results : evaluation metrics
###### ######
results<-confusionMatrix(truth_table,  mode = "prec_recall")
results

# cat("threshold", threshold)

# obter roc
roc_result<-roc(as.numeric(user), as.numeric(algorithm))
roc_result

# gravar os resultados
metrics <- data.frame(cbind(t(results$overall),t(results$byClass), roc=as.numeric(roc_result$auc)))
#write.csv(metrics,file="results_3h.csv")

save(list=ls(), file="load_data/evaluation_knn.RData")