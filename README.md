# Getting-and-Cleaning-Data
## This repo contains: 
1) an R script (run_analysis.R) for generating a tidy dataset of Human Activity Recognition Using Smartphones Dataset. Description of the source dataset can be found in 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

2) a code book (CodeBook.md) describing the variables, the data, and the transformations of the raw data into the tidy data executed in the R script.

3) the print-out (mean_subject_activity.txt) file of the tidy dataset

## Details:
To run the R script, the working directory must contain folders of training dataset and test dataset from the experiment. 
The R script does the followings:
a) combines data from both folder, 
b) assignss variable names, 
c) selects variables involving measurement of means and standard deviations,
d) creates a new dataset that summerizes the data by computing means for each activity and for each subject,
e) prints out the tidy data into a .txt file.
