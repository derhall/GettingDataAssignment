# GettingDataAssignment

Coursera Getting and Cleaning Data Course Assignment

## Description:

Course project carried out for Getting and Cleaning Data offered by John Hopkins University through Coursera. 

Data originally obtained from: 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

## Repo content:

- "README.md": This file. 

- "CODEBOOK.md": A description of data collection methodology and variable metadata for the "UCI HAR Dataset" and the "run_analysis.R" output files. 

- "/UCI HAR Dataset": Original dataset (see above). 

	- "/test"
	- "/train"
	- "/activity_labels"
	- "/features"
	- "/feature_info"
	- "/README.txt"

- "/run_analysis.R": R script for a function that performs the following actions on the "UCI HAR Dataset" (as specificied in project assignment instructions):
	
1. Merges the train and test datasets. 
2. Extracts only the features containing mean() and std() results for each measurement. 
3. Uses descriptive activity names to name the activities in the data set. 
4. Appropriately labels the merged dataset with descriptive variable names. 
5. From the dataset in step 4, creates a second, independent tidy dataset with the average of each variable for each activity and each subject. 
	
	See Analysis Notes below for more details and usage. 

- "/analysis_files": Contains export files from the "run_analysis.R" function.

	- "/UCI_HAR_merge_data.txt": Output file from steps 1-4 of "run_analysis.R". 

	- "/UCI_HAR_meansummary_merge_data.txt": Output file from step 5 of "run_analysis.R". 

## *run_analysis* Usage:

- "run_analysis.R" can be sourced as a function to R using the command "source("run_analysis.R")". The function can be used to return either the merged (UCI_HAR_merge_data) or mean summarized (UCI_HAR_meansummary_merge_data) directly in R and/or to export the two tables to .txt files in the "/analysis_files" directory.  

- The function has the following parameters:
	- *return* (default = "summary"): defines the tidy data table to return from the function. "summary" returns the mean summarized dataset. "data" returns the merged dataset. "none" returns no dataset (NULL). 
	- *export* (default = TRUE): logical parameter indicating whether to export the analysis datasets as .txt files. 

- "run_analysis.R" requires the dplyr package to be loaded. 

- "run_analysis.R" and the "/UCI HAR Dataset" folder must be in the working directory for the script to run properly.

- The export files in "/analysis_files" were generating by running *run_analysis(return = "none")* from the console on R version 4.0.0 with the dplyr package version 0.8.5. They can be read into R with *read.table()* using default functions 

	e.g. *summary_data <- read.table("/analysis_files/UCI_HAR_meansummary_merge_data.txt")*

- Per instructions, only mean() and std() features were extracted from the original datasets. meanFreq() and gravityMean() functions were not considered to be part of the instructed subset.

