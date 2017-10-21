###################################################################
############## LOF Script: Density Scores #########################
###################################################################

rm(list=ls())

setwd(paste(getwd(),"/_projeto_dissertacao/code/scripts/lof", sep=""))

source("parameters_lof.R")

load("load_data/dataset_bee.RData")

# libraries
# parallel lof scoring outlier
library(caret)
library(pROC)
library(Rlof)
library(DMwR)
library(beepr)

# check dataset
summary(dataset_bee)
str(dataset_bee)

lof_anomaly_detection <- function(windowSize, k_interval, threshold)
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
    
    # to get scores 
    scores<<-lof(dtset_subcj[,c("act")], k=k_interval)
    
    scores_data <- matrix(scores, nrow = nrow(dtset_subcj), ncol = nrow(scores))
    colnames(scores_data) <- c(1:ncol(scores_data))
    rownames(scores_data) <- c(rownames(dtset_subcj))
    
    # replace by zero if there Inf or NaN.
    scores_data[which(scores_data==Inf)] <- 0
    scores_data[is.nan(scores_data)] <- 0
    print(scores_data)
    
    # threshold definition 
    threshold<<-threshold
    
    
    if (any(scores_data[1,] >= threshold))
    {
      label_class <- c(label_class, "anormal")
      # select the maximum score
      df_density <- rbind(max(scores_data[1,which(scores_data[1,] >= threshold)]), df_density)
      
    }else{
      
      label_class <- c(label_class, "normal")
      # select the maximum score
      df_density <- rbind(max(scores_data[1,which(scores_data[1,] < threshold)]), df_density)
    }
    
    print(label_class)
    print(df_density)
    
    df_density <<- df_density
    label_class <<- label_class
    
  }
  
  return(label_class)
  
}

lof_anomaly_detection(windowSize = window, k_interval=k_interval, threshold=threshold)

# alarm finish the code
beep()

# organizing the labels
label_class<-rev(label_class)
txt <- as.data.frame(label_class)
txt <- paste(txt[,1])

# to set labels in a doc text
# write(txt, file="labels-lof/24h/intervalo-24h_k12-k20.txt")

# check density labels
summary(df_density)
ind_anormal<-which(df_density >= threshold)
ind_anormal
# anomaly detected by algorithm (total)
length(ind_anormal)

save(list=ls(), file="load_data/lof.RData")
