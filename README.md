# GettingDataAssignment

Coursera Getting and Cleaning Data Course Assignment

====================================================

Description:

Course project carried out for Getting and Cleaning Data offered by John Hopkins University through Coursera. 

Data originally obtained from: 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

==================

Repo content:

- "README.md": This file. 

- "CodeBook.md": A description of data collection methodology and variable metadata for the "UCI HAR Dataset" and "run_analysis.R" output files. 

- "/UCI HAR Dataset": Original dataset (see above). 

	- "/test"
	- "/train"
	- "/activity_labels"
	- "/features"
	- "/feature_info"
	- "/README.txt"

- "/run_analysis.R": R script that performs the following functions on the "UCI HAR Dataset" (as specificied in course assignment instructions):
	
	1. Merges the train and test datasets.
    	2. Extracts only the features containing mean() and std() results for each measurement.
    	**3. Uses descriptive activity names to name the activities in the data set
    	**4. Appropriately labels the data set with descriptive variable names.
    	**5. From the data set in step 4, creates a second, independent tidy dataset with the average of each variable for each activity and each subject.

- "/Output": Contains the output files from the "run_analysis.R" script. 

	- "/UCI_HAR_merged_data.csv": Output file from steps 1-4 of the "run_analysis.R" script. 

	- "/UCI_HAR_merged_data_tidy.csv": Output file from step 5 of the "run_analysis.R" script. 

==================

Analysis Notes:

- The "run_analysis.R" script was run on R version 4.0.0 (2020-04-24) with the following packages: 

	- dplyr
	- 
- "run_analysis.R" and the "UCI HAR Dataset" must be in the working directory for the script to run properly. 

- Per instructions, only mean() and std() features were extracted from the original datasets. meanFreq() and gravityMean() functions were not considered to be part of the instructed subset. 

================


