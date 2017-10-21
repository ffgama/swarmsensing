############################################################
############## LOF: Confusion Plot #########################
############################################################

rm(list=ls())

#setwd(paste(getwd(),"/_projeto_dissertacao/code/scripts/lof", sep=""))

load("load_data/dataset_bee.RData")
load("load_data/lof.RData")
load("load_data/evaluation_lof.RData")

# install.packages("ggplot2")
# install.packages("RColorBrewer")

# visualizations
library(ggplot2)
library(RColorBrewer)

# create data frame to set results 
results_df<-data.frame(results$table)
# create a column "proportion" to the visualization
results_df$Prop <- results_df$Freq/sum(results_df$Freq)

# controls colors pallete
jBuPuFun <- colorRampPalette(brewer.pal(n = 8, "Greens"))
paletteSize <- 256
jBuPuPalette <- jBuPuFun(paletteSize)

freq <- as.numeric(results_df$Freq)

# adjust of the table cells
freq <- c(freq[2],freq[4],freq[1],freq[3])
results_df$Prop <- c(results_df$Prop[2],results_df$Prop[4],results_df$Prop[1],results_df$Prop[3])
results_df$algorithm <- c(results_df$algorithm[1],results_df$algorithm[3],results_df$algorithm[2], results_df$algorithm[4])
results_df$user <- c(results_df$user[1], results_df$user[3], results_df$user[2], results_df$user[4])

# create the visualization
confusionPlot <- ggplot(
   results_df, aes(x = user, y = algorithm, fill = Prop)) +
   theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
   geom_tile() +
   labs(x = "Predicted class", y = "True class") +
   geom_text(aes(label = sprintf("%1.0f", freq)), vjust = 1) +
   scale_fill_gradient2(
     low = jBuPuPalette[50],
     mid = jBuPuPalette[(180)],
     high = jBuPuPalette[(180)],
     midpoint = (max(results_df$Prop) + min(results_df$Prop)) / 2,
     name = "") +
   theme_light()

# to show the visualization
confusionPlot

# save the plot
jpeg('visualization/confusionPlot_lof_24h.jpg')
plot(confusionPlot)
dev.off()