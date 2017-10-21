###################################################################
############## KNN Script: Density Scores #########################
###################################################################

rm(list=ls())

setwd(paste(getwd(),"/_projeto_dissertacao/code/scripts/knn", sep=""))

source("parameters_knn.R")

load("load_data/dataset_bee.RData")

# libraries
library(caret)
library(pROC)
library(fields)
library(beepr)

# check dataset
summary(dataset_bee)
str(dataset_bee)

knn_anomaly_detection <- function(windowSize, k_value, threshold)
{
    
  for (row in nrow(dataset_bee):windowSize){
  
    window <- windowSize - 1
    
    # temporal interval
    # 3h - 6h - 12h - 24h
    begin <- row
    end <- begin - window
    
    dtset_subcj <- dataset_bee[begin:end,]
    
    # not remove (unlimited connections - open and close)
    closeAllConnections()
    
    # create a KNN 
    get_scores_knn<-function(input_dataset,k){
      
      # to set number of instances
      n<-nrow(input_dataset)
      # create distance matrix 
      distance_matrix<-as.matrix(rdist(input_dataset))
      
      dist_k<-NULL
      
      for(r in 1:n){
        # run row by row of distance matrix, sort and select farthest
        dist_k[r]<-(sort(distance_matrix[r,]))[k+1]
      }
      return(dist_k)
    }
    
    # to get scores 
    scores<<-get_scores_knn(as.data.frame(dtset_subcj[,c("act")]), k=k_value)
    
    # organizing in matrix data
    scores_data <- matrix(scores, nrow = nrow(as.data.frame(dtset_subcj$act)), 
                            ncol = ncol(as.data.frame(dtset_subcj$act)))
    colnames(scores_data) <- c(1:ncol(scores_data))
    rownames(scores_data) <- c(rownames(dtset_subcj))
    
    cat("\n==========")
    print(mean(scores_data))
    # to get average of distances (scores)
    average[row]<<-c(mean(scores_data), average)
    
    # threshold definition 
    threshold<<-threshold
    
    
    if (any(average[row] >= threshold))
    {
      label_class <- c(label_class, "anormal")

      # filling anomaly density
      df_density_a <- rbind(average[row], df_density_a)
      
      # filling normal and anomaly density
      df_density_all <- rbind(average[row], df_density_all)
      
    }else{
      label_class <- c(label_class, "normal")
      
      # filling normal density
      df_density_n <- rbind(average[row], df_density_n)
      
      # filling normal and anomaly density
      df_density_all <- rbind(average[row], df_density_all)
    }
    
    df_density_a <<- df_density_a
    df_density_n <<- df_density_n
    df_density_all <<- df_density_all
    label_class <<- label_class
    
  }
  
  return(label_class)
  
}
window <- 3
knn_anomaly_detection(windowSize = window, k_value=k_value, threshold=threshold)

# alarm finish the code
beep()

# organizing the labels
label_class<-rev(label_class)
txt <- as.data.frame(label_class)
txt <- paste(txt[,1])

# to set labels in a doc text
# write(txt, file="labels-knn/3h/intervalo-3h_k2.txt")

# check density labels
summary(df_density_all)
ind_anormal<-which(df_density_all >= threshold)
ind_anormal
# anomaly detected by algorithm (total)
length(ind_anormal)

# check trend of density data : help to define a threhold value
# hist(average)
# plot(average, type = "l")

save(list=ls(), file="load_data/knn.RData")