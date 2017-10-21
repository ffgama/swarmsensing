############################################################################################
############## LOF Script: to load parameters and libraries of LOF #########################
############################################################################################

# install all packages on enviroment
# install.packages("caret")
# install.packages("pROC")
# install.packages("beepr")
# install.packages("Rlof")

# consts
label_class <- NULL
df_density <- NULL 

window <- 24
k_interval <- c(12:20)
threshold <- 1.65