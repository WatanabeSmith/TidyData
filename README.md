# TidyData
Please read CodeBook.md for details on processing.

Original data from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#To run this script
The data linked above must be downloaded to your working directory and unzipped there, such that the folder "getdata-projectfile-UCI HAR Dataset" is in your working directory. Do not move any other files or folders within the original dataset.

#Brief Summary
This project created for the Getting and Cleaning Data course project. All relevant details are availible in "CodeBook.md". Briefly, the original data set was processed to combine test and training sets into a single dataset "SummaryData.csv", where only mean and standard deviation measurements are shown. This data was further summarized in "TidyDataSet.txt" where the average(mean) of said mean and standard devaition measures are grouped by subject and activity.

Processed data in contained here as "SummaryData.csv" and "TidyDataSet.txt"

"run_analysis.R" is the R script that performed all data processing