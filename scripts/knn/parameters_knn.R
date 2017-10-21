############################################################################################
############## KNN Script: to load parameters and libraries of KNN #########################
############################################################################################

# install all packages on enviroment
# install.packages("caret")
# install.packages("pROC")
# install.packages("beepr")
# install.packages("fields")
# install.packages("ggplot2")
# install.packages("RColorBrewer")

# consts
label_class <- NULL
df_density_a <- NULL 
df_density_n <- NULL
df_density_all <- NULL
average<-NULL

window <- 3
k_value <- 2
threshold <- 0.88