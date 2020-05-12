run_analysis <- function(output = "object") {
    
    output <- output
    
    if(!require(dplyr)) {
        
        stop("dplyr not installed")
    
    }
    
    if(!output %in% c("object", "export")){ 
       
        stop("Value not valid. Options: 'object' or 'export'")
        
    }
    
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

        meansummary_merge_data <- merge_data %>% 
            group_by(subject_id, activity, dataset) %>% 
            summarize_all(mean)
        
        ## Exports the generated dataset to an R object or .txt file, 
        ## dependent on output parameter 
        
        if(output == "object") {
            
            assign("meansummary_merge_data", meansummary_merge_data, envir = .GlobalEnv)
            
        } else if (output == "export") {
            
            write.table(meansummary_merge_data,
                        file = "UCI_HAR_meansummary_merge_data.txt",
                        row.names = FALSE)
        }
    }


