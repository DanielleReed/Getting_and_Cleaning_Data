##Reed Week 4 Coursera Getting and Cleaning Data class
#
#make a path statement where your files are
#path <- "your path"
#set the working directory to the place where your files are
#setwd(path)
#download files
#
subject_train <- read.table("subject_train.txt", quote="\"", comment.char="")
X_train <- read.table("X_train.txt", quote="\"", comment.char="")
y_train <- read.table("X_train.txt", quote="\"", comment.char="")
subject_test <- read.table("subject_test.txt", quote="\"", comment.char="")
X_test <- read.table("X_test.txt", quote="\"", comment.char="")
y_test <- read.table("X_test.txt", quote="\"", comment.char="")
features <- read.table("features.txt", quote="\"", comment.char="")
#
#load packages as needed
library(dplyr)
library(reshape2)
#
#1. Merges the training and the test sets to create one data set.
#
#"subject_train" is the subject ID file for the training subjects
#"X_train" is the main data file for the training subjects
#"y_train" is the matching activity codes, 1=WALKING
#This  labeling structure is the same for the 'test' data
#need the features file that has variable names
#
#Apply correct column names first
colnames(subject_train) <- c("ID")
colnames(subject_test) <- c("ID")
colnames(y_train) <- c("Activity")
colnames(y_test) <- c("Activity")
#this puts column headings on the data files from the features file
colnames(X_train) <- features$V2
colnames(X_test) <- features$V2

#bind into one file
train_data_set <- cbind(subject_train, y_train, X_train)
test_data_set <- cbind(subject_test, y_test, X_test)
data <- rbind(train_data_set, test_data_set)
#
#extract columns with mean and std
# three lines below  from https://github.com/walsh9/tidy-data
#
#Extracts only the measurements on the mean and standard deviation for each measurement.
cols <- c(1,2, grep("(mean|std)\\(\\)", colnames(data)))
tidyData <- data[cols]
write.table(tidyData, file="tidydata.txt", row.name=FALSE)
#

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#next we have to reformat the data so that one column has all variables (e.g., "tBodyAcc-mean()-X"
# so we can take mean by subject and activity
meltData <- melt(tidyData,id = c("ID","Activity"))
#
avgData1 <- dcast(meltData, ID + Activity ~ variable, mean)
#the average data now written to the file
write.table(avgData1, file="averages.txt", row.name=FALSE) 



