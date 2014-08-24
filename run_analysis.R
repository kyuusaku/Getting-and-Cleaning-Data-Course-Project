## Getting and Cleaning Data Course Project
## Data info:
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
## Data download adrress:
## "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
##
## My default data path is "../UCI HAR Dataset"
##
## Output tidy data.

run_analysis <- function() {
        ## loading subject ids
        ## train [1 3 5 6 7 8 11 14 15 16 17 19 21 22 23 25 26 27 28 29 30]
        ## test  [2 4 9 10 12 13 18 20 24]
        subject.train <- read.table("../UCI HAR Dataset/train/subject_train.txt")
        subject.test <- read.table("../UCI HAR Dataset/test/subject_test.txt")
        message("Loaded subject ids.")
        
        ## loading activity labels from file
        activity.labels <- read.table("../UCI HAR Dataset/activity_labels.txt", stringsAsFactors=F)
        message("Loaded activity labels.")
        
        ## loading training and testing labels
        y.train <- read.table("../UCI HAR Dataset/train/y_train.txt")
        y.test <- read.table("../UCI HAR Dataset/test/y_test.txt")
        message("Loaded training and testing labels.")
        
        ## loading features
        features <- read.table("../UCI HAR Dataset/features.txt", stringsAsFactors=F)
        message("Loaded all features.")
        
        ## loading training and testing datasets
        X.train <- read.table("../UCI HAR Dataset/train/X_train.txt")
        X.test <- read.table("../UCI HAR Dataset/test/X_test.txt")
        message("Loaded training and testing datasets.")
        
        ## merging the training and the test sets to create one data set.
        X <- rbind(X.train, X.test)
        colnames(X) <- features$V2
        message("Put training and test sets together.")
        
        ## extracting only the measurements on the mean and standard deviation for each measurement.
        X.mean.std <- X[,grepl('mean\\(\\)|std\\(\\)',colnames(X))]
        message("Picked out the mean and standard deviation columns.")
        
        ## adding actvity and subject id to the reduced data set
        y <- rbind(y.train,y.test) 
        colnames(y) <- "activity"
        subject <- rbind(subject.train,subject.test)
        colnames(subject) <- "subject.id"
        X.mean.std <- cbind(subject, y, X.mean.std)
        message("Added activity and subject id.")
        
        ## Uses descriptive activity names to name the activities in the data set
        X.mean.std$activity <- factor(X.mean.std$activity, labels=activity.labels$V2)
        message("Added activity names")
        
        ## Appropriately labels the data set with descriptive activity names.
        
        # take a look at the current names
        names(X.mean.std)
        # lets replace all '-' with a '.'
        names(X.mean.std) <- gsub("\\-","",names(X.mean.std),)
        # replace all the beginning 't' and 'f' with time and freq
        names(X.mean.std) <- gsub('^t','time.',names(X.mean.std),)
        names(X.mean.std) <- gsub('^f','freq.',names(X.mean.std),)
        # lets strip off all trailing '()'
        names(X.mean.std) <- sub("\\(\\)$","",names(X.mean.std),)
        names(X.mean.std) <- sub("\\(\\)",".",names(X.mean.std),)
        # change Acc and Mag to be slightly more descriptive
        names(X.mean.std) <- gsub("Mag","magnitude.",names(X.mean.std),)
        names(X.mean.std) <- gsub("Acc","acceleration.",names(X.mean.std),)
        # clean up remaining words by inputing spaces
        names(X.mean.std) <- gsub("Body","body.",names(X.mean.std),)
        names(X.mean.std) <- gsub("Gyro","gyro.",names(X.mean.std),)
        names(X.mean.std) <- gsub("Jerk","jerk.",names(X.mean.std),)
        names(X.mean.std) <- gsub("Gravity","gravity.",names(X.mean.std),)
        # convert the remaining caps to lowercase
        names(X.mean.std) <- tolower(names(X.mean.std))
        message("Modified colnames.")
        
        ## melting and dcasting for getting databy activities and subjects
        library(reshape2)
        library(data.table)
        resdt <- data.table(X.mean.std)
        resMelted  <- melt(resdt, id=c("subject.id", "activity"))
        resDcasted <- dcast (resMelted, subject.id + activity ~ variable, mean)
        message("Averaged each variable for each activity and each subject.")
        
        ## modify variable names to reflect that these are now averaged values
        new.names <- lapply(names(resDcasted)[3:ncol(resDcasted)],paste,".averaged", sep="")
        names(resDcasted)[3:ncol(resDcasted)] <- unlist(new.names)
        message("Modified variable names to reflect that these are now averaged values.")
        
        # finally...
        # save the small tidy dataset for evaluation
        write.table(resDcasted, file="tidy_data.txt")
        message("Saved result.")
}
