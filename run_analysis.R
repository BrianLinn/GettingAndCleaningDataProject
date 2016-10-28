getwd()

#Clear the environment
rm(list = ls())

#Ensure there is a data folder in the working directory to store the files
if(!exists("./data")){dir.create("./data")}

#Load libraries
library(data.table)
library(reshape2)
library(dplyr)
#Set the location for the file to download
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#Download the data in a zip file to a temp file
download.file(fileUrl, destfile = "./data/tmp.zip")

#unzip the file
unzip("./data/tmp.zip", exdir = "./data/phones")

#Load the activity_labels
activitylabels <- read.table("./data/phones/UCI HAR Dataset/activity_labels.txt")
#provide descriptive names to the columns/variables in the table
colnames(activitylabels) <- c("activityid", "activitydescription")

#Load the features
features <- read.table("./data/phones/UCI HAR Dataset/features.txt")
#provide descriptive names to the columns/variables in the table
colnames(features) <- c("featureid", "featuredescription")

#Load all Train data
#Load the train subjects and rename V1 to subjectid
trainsubject <- read.table("./data/phones/UCI HAR Dataset/train/subject_train.txt") %>% `colnames<-`("subjectid")
#Load the train labels and rename V1 to labelid
trainlabels <- read.table("./data/phones/UCI HAR Dataset/train/y_train.txt") %>% `colnames<-`("activityid")  
#Load the train dataset and use the features[features] column data as the labels
trainset <- read.table("./data/phones/UCI HAR Dataset/train/X_train.txt") 
colnames(trainset) <- features[,2]

#Load all Test data
#Load the test subjects and rename V1 to subjectid
testsubject <- read.table("./data/phones/UCI HAR Dataset/test/subject_test.txt") %>% `colnames<-`("subjectid")
#Load the test labels and rename V1 to labelid
testlabels <- read.table("./data/phones/UCI HAR Dataset/test/y_test.txt") %>% `colnames<-`("activityid")
#Load the test dataset and use the features[features] column data as the labels
testset <- read.table("./data/phones/UCI HAR Dataset/test/X_test.txt")
colnames(testset) <- features[,2]

#Merge data
#Merge all train data
trainall <- cbind(trainsubject, trainlabels, trainset)
#Merge all test data
testall <- cbind(testsubject, testlabels, testset)
#Merge trainall and testall to achieve #1.Merges the training and the test sets to create one data set
testtrainall <- rbind(trainall, testall)
names(testtrainall)

#Extract the mean() and std() measures from the dataset
#Store column names for vector lookup
testtrainallcols <- colnames(testtrainall) 
#Assign a true or false value to each field - fields with subjectid, labelid, mean, or std will be marked TRUE
datatokeep <- (grepl("subjectid",testtrainallcols) | grepl("activityid",testtrainallcols) 
               | grepl("mean..",testtrainallcols) | grepl("std..",testtrainallcols))
#Extract all of the fields from the merged dataset, testrainall, where the datatokeep value is true. This
#ensures that only fields with the terms subjectid, labelid, mean, or std will be kept
meanstd <- testtrainall[, datatokeep == TRUE]

#Assign descriptive activity to each activity
meanstdactivity <- merge(meanstd, activitylabels, by = 'activityid', all.x = TRUE)
str(meanstdactivity)

#Clean up data labels
names(meanstdactivity)<-gsub("^t", "time", names(meanstdactivity))
names(meanstdactivity)<-gsub("^f", "frequency", names(meanstdactivity))
names(meanstdactivity)<-gsub("Acc", "accelerometer", names(meanstdactivity))
names(meanstdactivity)<-gsub("Gyro", "gyroscope", names(meanstdactivity))
names(meanstdactivity)<-gsub("Mag", "magnitude", names(meanstdactivity))
names(meanstdactivity)<-gsub("BodyBody", "body", names(meanstdactivity))
names(meanstdactivity)<-gsub("Body", "body", names(meanstdactivity))
#Check names
names(meanstdactivity)
#New, tidy dataset with average of each variable for each activity for each subject
tidydata <- aggregate(. ~subjectid + activitydescription, meanstdactivity, mean)
#Force the subjectid into a vector to work with order
tidydata$subjectid <- as.vector(tidydata$subjectid)
tidydata <- tidydata[order(tidydata$subjectid, tidydata$activitydescription),]
write.table(tidydata, file = "./data/tidydata.txt", row.names = FALSE)
