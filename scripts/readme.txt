Author: Fernando Gama da Mata
Version: 1.0 

======== ======== KNN ========	========  
(1). Configure the constant values in the script (parameters_knn.R):

a) window <- window size
b) k_value <- number of neighbors
c) threshold <- define the border between normal and anomaly classes.

Note [1]: The script (test_parameters_knn.R) is optional. It just suggest (optimal) threshold values for 75 anomalies (detected/suggested by user) aproximately acordding with our tests.

Note [2]: window sizes tested : (3h | 6h | 12h | 24h)

Note [3]: k_value: (min=1 and max = window size- 1) 

(2). Run (knn.R) script to get scores (distance-based)
(3). Run (evaluation_knn.R) script to get the evaluation metrics
(4). Run (confusionMatrix_plot_knn.R) to build the  visualization to evaluation metrics

======== ======== LOF ========	======== 
 1). Configure the constant values in the script (parameters_lof.R):

a) window <- window size
b) k_interval <- define the range of number of neighbors
c) threshold <- define the border between normal and anomaly classes.

Note [1]: The script (test_parameters_lof.R) is optional. It just suggest (optimal) threshold values for 75 anomalies (detected/suggested by user) aproximately acordding with our tests.

Note [2]: window sizes tested : (3h | 6h | 12h | 24h)

Note [3]: k_interval: a vector (minPts or k[min]=1 and maxPts or k[max] = window size- 1) 

(2). Run (lof.R) script to get scores (density-based)
(3). Run (evaluation_lof.R) script to get the evaluation metrics
(4). Run (confusionMatrix_plot_lof.R) to build the  visualization to evaluation metrics
