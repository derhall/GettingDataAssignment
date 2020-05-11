run_analysis <- function(return = "summary", export = TRUE) {
    
    ## Read in the features list and
    ## create an index of the mean and std features
    
    features <-  read.table("./UCI HAR Dataset/features.txt",
                            col.names = c("row", "variable"))
    
    ### Create the numerical index
    
    index_mean <- grep("mean()", features$variable, fixed = TRUE)
    
    index_std <- grep("std()", features$variable, fixed = TRUE)
    
    findex <- sort(c(index_mean, index_std))
    
    ### Create a NA, NULL index based on the numerical index
    ### that can be passed to colClasses in read.table
    
    index <- rep("NULL", length(features$variable))
    
    index[findex] <- NA
    
    ## Read in the test dataset subsetted on the index
    
    test_data <- read.table("./UCI HAR Dataset/test/X_test.txt",
                            colClasses = index)
    
    test_labels <- read.table("./UCI HAR Dataset/test/y_test.txt")
    
    test_subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")
    
    test_ds_label <- rep("test", nrow(test_data))
    
    test <- cbind(test_subjects, 
                  test_ds_label, 
                  test_labels, 
                  test_data)
    
    colnames(test) <-c("subjectid", 
                       "dataset", 
                       "activity", 
                       features$variable[findex])
    
    ## Read in the training dataset subsetted on the index
    
    train_data <-read.table("./UCI HAR Dataset/train/X_train.txt",
                            colClasses = index)
    
    train_labels <- read.table("./UCI HAR Dataset/train/y_train.txt")
    
    train_subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    
    train_ds_label <- rep("train", nrow(train_data))
    
    train <- cbind(train_subjects, 
                   train_ds_label, 
                   train_labels, 
                   train_data)
    
    colnames(train) <- c("subjectid", 
                         "dataset", 
                         "activity", 
                         features$variable[findex])
    
    ## Merge the two datasets
    
    mergedata <- rbind(train, test)
    
    ## Inital tidying of the merged dataset
    
    mergedata$dataset <- as.factor(mergedata$dataset)
    
    activity_labels <-
        read.table("./UCI HAR Dataset/activity_labels.txt")
    activity_labels$V2 <- tolower(activity_labels$V2)
    
    for (i in 1:6) {
        ind <- mergedata$activity == i
        mergedata$activity[ind] <- activity_labels$V2[i]
    }
    
    mergedata$activity <- as.factor(mergedata$activity)
    
    
    
    
    
    
    
    
    
    ## Exports the two generated dataframes to files if export = TRUE
    
    if (export = TRUE) {
        
        if (!file.exists("./analysis_data")) {
            dir.create("./analysis_data")
        }
        
        write.table(mergedata, 
                    file = "./analysis_data/UCI_HAR_merged_data.txt")
        
        write.table(summary_mergedata, 
                    file = "./analysis_data/UCI_HAR_merged_data.txt")
    }
    
    ## Return based on output function. 
        ##"summary" returns the summary merged dataset 
        ## "data" returns the merged dataset
        ## "none" returns no value but still runs the script
    
    if (summary = "summary") {
        
        summary_mergedata
    
        } else if (summary = "data") {
        
        mergedata
    
        } else if (summary = "none")
                
        NULL
    
}
