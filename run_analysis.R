run_analysis <- function() {
        #Load needed packages
        library(Hmisc)
        library(reshape2)
        library(dplyr)
        
        #Reading all tables into memory
        xtest <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
        xtrain <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
        ytest <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
        ytrain <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
        subtest <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
        subtrain <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
        features <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")
        activity.labels <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
        
        #Naming columns prior to merging
        ytest <- rename(ytest, Activity = V1)
        ytrain <- rename(ytrain, Activity = V1)
        subtest <- rename(subtest, Subject = V1)
        subtrain <- rename(subtrain, Subject = V1)
        
        #Combine activity labels with activity tables
        ytest$Activity <- activity.labels[ytest$Activity,2]
        ytrain$Activity <- activity.labels[ytrain$Activity,2]
        
        #Combine test and training x sets
        xsets <- rbind(xtest,xtrain)
        
        #Create vector indicating mean() and std() columns
        mean.indices <- features[grepl(
                "[[:punct:]]mean[[:punct:]]{2}|std",features$V2),1]
        #Extract only mean and Std dev, then add appropriate col names
        xsets.trim <- xsets[,mean.indices]
        colnames(xsets.trim) <- features[mean.indices,2]
        
        #combine measurements with subject and activity data
        ysets <- rbind(ytest, ytrain)
        sub.sets <- rbind(subtest, subtrain)
        SummaryData <- cbind(sub.sets, ysets, xsets.trim)
        write.csv(SummaryData, "./SummaryData.csv")

        #Make a combined column with the subject and activity in a single string
        #to make the melt easier
        SummaryData$SubAct <- paste(SummaryData$Subject, SummaryData$Activity)
        #Melt data frame
        smelt <- melt(SummaryData, id=c("SubAct", "Subject", "Activity"))
        #Recast with SubAct as the observation
        scast <- dcast(smelt, SubAct ~ variable, mean)
        #Separate the SubAct string back to Subject and Activity
        splitcast <- colsplit(scast$SubAct," ", c("Subject", "Activity"))
        #Recombine the separated strings into the data frame
        split.combined <- cbind(splitcast, scast)
        #Drop excess columns, including SubAct
        drops <- c("X", "SubAct")
        TidyData <- split.combined[,!(names(split.combined) %in% drops)]
        #Sort data frame by Suject
        TidyData <- arrange(TidyData, as.numeric(as.character(Subject)))
        #Write output
        write.table(TidyData, "TidyDataSet.txt", row.names = FALSE)
}