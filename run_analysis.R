run_analysis <- function(return = "summary", export = TRUE) {
    if (!require(dplyr)) {
        stop("dplyr not installed")
        
    } else if (!return %in% c("summary", "data", "none")) {
        stop("return must be defined as 'summary', 'data', or 'none'")
        
    } else {
        ## Read in the features list and
        ## create an index of the mean and std features
        
        features <-  read.table("./UCI HAR Dataset/features.txt",
                                col.names = c("row", "variable"))
        
        ### Create the numerical index
        
        index_mean <-
            grep("mean()", features$variable, fixed = TRUE)
        
        index_std <- grep("std()", features$variable, fixed = TRUE)
        
        findex <- sort(c(index_mean, index_std))
        
        ### Create a NA, NULL index based on the numerical index
        ### that can be passed to colClasses in read.table
        
        index <- rep("NULL", length(features$variable))
        
        index[findex] <- NA
        
        ## Read in the test dataset subsetted on the index
        
        test_data <- read.table("./UCI HAR Dataset/test/X_test.txt",
                                colClasses = index)
        
        test_labels <-
            read.table("./UCI HAR Dataset/test/y_test.txt")
        
        test_subjects <-
            read.table("./UCI HAR Dataset/test/subject_test.txt")
        
        test_ds_label <- rep("test", nrow(test_data))
        
        test <- cbind(test_subjects,
                      test_ds_label,
                      test_labels,
                      test_data)
        
        colnames(test) <- c("subject_id",
                            "dataset",
                            "activity",
                            features$variable[findex])
        
        ## Read in the training dataset subsetted on the index
        
        train_data <-
            read.table("./UCI HAR Dataset/train/X_train.txt",
                       colClasses = index)
        
        train_labels <-
            read.table("./UCI HAR Dataset/train/y_train.txt")
        
        train_subjects <-
            read.table("./UCI HAR Dataset/train/subject_train.txt")
        
        train_ds_label <- rep("train", nrow(train_data))
        
        train <- cbind(train_subjects,
                       train_ds_label,
                       train_labels,
                       train_data)
        
        colnames(train) <- c("subject_id",
                             "dataset",
                             "activity",
                             features$variable[findex])
        
        ## Merge the two datasets
        
        merge_data <- rbind(train, test)
        
        ## Inital tidying of the merged dataset
        
        merge_data$dataset <- as.factor(merge_data$dataset)
        
        activity_labels <-
            read.table("./UCI HAR Dataset/activity_labels.txt")
        activity_labels$V2 <- tolower(activity_labels$V2)
        
        for (i in 1:6) {
            ind <- merge_data$activity == i
            merge_data$activity[ind] <- activity_labels$V2[i]
        }
        
        merge_data$activity <- as.factor(merge_data$activity)
        
        names <- names(merge_data)
        
        names[4:43] <- sub("t", "time_", names[4:43])
        names[44:69] <- sub("f", "freq_", names[44:69])
        names <- tolower(names)
        names <- sub("acc", "_accelerometer_", names)
        names <- sub("gyro", "_gyroscope_", names)
        names <- sub("mag", "_magnitude", names)
        names[64:69] <- sub("body", "", names[64:69])
        names <- sub("\\()", "", names)
        names <- gsub("-", "_", names)
        # names <- gsub("_", "", names) # Optional to remove underscores if required.
        
        names(merge_data) <- names
        
        ## Creation of the summary_merge dataset

        summary_merge_data <- merge_data %>% 
            group_by(subject_id, activity, dataset) %>% 
            summarize_all(mean)
        
        ## Exports the two generated dataframes to files if export = TRUE
        
        if (export == TRUE) {
            if (!file.exists("./analysis_files")) {
                dir.create("./analysis_files")
            }
            
            write.table(merge_data,
                        file = "./analysis_files/UCI_HAR_merge_data.txt")
            
            write.table(summary_merge_data,
                        file = "./analysis_files/UCI_HAR_meansummary_merge_data.txt")
        }
        
        ## Return based on output function.
        ##"summary" returns the summary merged dataset
        ## "data" returns the merged dataset
        ## "none" returns no value but still runs the script
        
        if (return == "summary") {
            summary_merge_data
            
        } else if (return == "data") {
            merge_data
            
        } else if (return == "none" & export == TRUE) {
            message("export complete")
        
        }
    }
}
