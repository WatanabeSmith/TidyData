#Tidy Data Set Codebook

#The Data
##Original Data
The original data set and all relevant details for data collection are availible at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Briefly, 30 volunteers wearing smartphones performed six activities. 561 different measurements were collected for each 2.56 second window of the relevant activity. The data is split into a training set (70% of participants) and a test set (30%).
##Data presented here
I have combined the test and training sets into a single dataset. The readings from that data set are summarized here, with the average(mean) of every mean and standard deviation for each measurement. There were 33 mean measures and 33 standard deviation measures, resulting in the mean of 66 measurements presented here. These means are summarized by participant ("Subject") and activity ("Activity").
#The Variables
The variables maintain the exact name as the original dataset linked above, which are concise and descriptive. I do not have training as a physicist, nor was I involved in the design of this experiment, so my personal commentary on each variable would be unwarrented and misleading. Inquiries as to the nature of each measure should be directed to the original data set documentation linked above.
#Data Transformations
##Data Cleaning Process
The R-script that ran the entire processing is included in this repository ("run_analysis.R"). Briefly, this script performed the following actions:
###The Summary Data
*Load libraries for relevant packages (Hmisc, reshape2, dplyr)
*Reads the original datasets into memory. These datasets must be located, relative to the working directory at: "./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/", with the rest of the file architecture preserved from the original dataset (link provided above)
*Adds appropriate column names to the tables
*Converts the numeric listing of each activity to the descriptive text label
*Combines the test and training sets for measurement data
*Uses regular expressions to pull the locations of columns containing mean and standard deviation measurements. The measurement data is then trimmed to only those relevant measures, and descriptive column names are added from the "features" data set.
*Measurements, subject identifiers and activity labels are combined to a single dataset and written at "./SummaryData.csv"
###The Tidy Data
*The Subject and Activity columns are combined to give a single column by which to melt and recast the data
*The data frame is melted and recast with the means of all measurement variables grouped by Subject and Activity
*The Subject and Activity combined column is split into two again, added to the data set, and the combined column is dropped
*The Tidy data is sorted by Subject number and then written to disk as "TidyDataSet.txt"
#Using the Tidy Data Set
Read to memory with read.table() with "header = TRUE"
