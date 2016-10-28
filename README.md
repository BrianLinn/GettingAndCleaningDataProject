### Environment Setup

This section of code will ensure that the environment is prepared for
the script to run successfully.

#### Clear Environment Variables.

    rm(list = ls())

#### Create Data Folder

    if(!exists("./data")){dir.create("./data")}

### Load Required Libraries

This section of code loads the libraries with the functions required to
complete the desired functions.

    library(data.table)
    library(reshape2)
    library(dplyr)

### Load Data Files

This section of code performs the steps necessary to download the data
files.

#### Set Download Location

    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#### Download Zip File

    download.file(fileUrl, destfile = "./data/tmp.zip")

#### Unzip the File

    unzip("./data/tmp.zip", exdir = "./data/phones")

### Load Data Into R

This section of code will load the Activity Labels, the Features, the
Train Data, and the Test Data. This code also renames some of the
columns to be more descriptive per the tenets of tidy data.

#### Load the Activity Labels and Provide Descriptive Column Names

    activitylabels <- read.table("./data/phones/UCI HAR Dataset/activity_labels.txt");
    colnames(activitylabels) <- c("activityid", "activitydescription");

#### Load the Features and Provide Descriptive Column Names

    features <- read.table("./data/phones/UCI HAR Dataset/features.txt");
    colnames(features) <- c("featureid", "featuredescription")

#### Load the Train Data and Provide Descriptive Column Names

    trainsubject <- read.table("./data/phones/UCI HAR Dataset/train/subject_train.txt") %>% `colnames<-`("subjectid");
    trainlabels <- read.table("./data/phones/UCI HAR Dataset/train/y_train.txt") %>% `colnames<-`("activityid");
    trainset <- read.table("./data/phones/UCI HAR Dataset/train/X_train.txt");
    colnames(trainset) <- features[,2];

#### Load the Test Data and Provide Descriptive Column Names

    testsubject <- read.table("./data/phones/UCI HAR Dataset/test/subject_test.txt") %>% `colnames<-`("subjectid");
    testlabels <- read.table("./data/phones/UCI HAR Dataset/test/y_test.txt") %>% `colnames<-`("activityid");
    testset <- read.table("./data/phones/UCI HAR Dataset/test/X_test.txt");
    colnames(testset) <- features[,2];

### Merge the Data

This section of code will merge the data sets. This will be accomplished
by combining the trainsubject, trainlabels, and trainset data files into
one file using the cbind function - this is stored in an object,
trainall. The same will be done for the test... files - this is stored
in an object, testall. The testall and trainall files are then combined
to meet the assigment's first criteria: *"Merges the training and the
test sets to create one data set."*.

#### Merge the Train Data

    trainall <- cbind(trainsubject, trainlabels, trainset)

#### Merge the Test Data

    testall <- cbind(testsubject, testlabels, testset)

#### Merge the Test and Train Data

    testtrainall <- rbind(trainall, testall)

### Extract Mean and Standard Deviation Measurements

This section of code will subset the data so that only the variables
relating to measurements of a mean or a standard deviation are included
in the subset. This code ensures the script meets the assigment's second
criteria: *Extracts only the measurements on the mean and standard
deviation for each measurement.*.  
This was accomplished by creating a vector that returned a True or False
value for each field depending on whether or not it contained the text,
'mean' or 'std'. The values which returned False were excluded from the
subset.

#### Store Column Names

    testtrainallcols <- colnames(testtrainall) 

#### Create True/False Vector on Mean, Std, Subjectid, and Activityid

Creates the object datatokeep, which will be used to filter out the
values that contain the text, 'subjectid', 'activityid', 'mean', or
'std'. Those objects which contain the required text will return a True
value.

    datatokeep <- 
      (grepl("subjectid",testtrainallcols) | 
         grepl("activityid",testtrainallcols) | 
         grepl("mean..",testtrainallcols) | 
         grepl("std..",testtrainallcols))

#### Extract Mean and Std Subset with Datatokeep as Filter

    meanstd <- testtrainall[, datatokeep == TRUE]

### Tidy the Data

This section of code assigns appropriate activity descritions to the
merged data by merging the activity labels with the merged data. This
ensures that the script accomplishes the assignment's third criteria:
*Uses descriptive activity names to name the activities in the data
set.*. The code also removes the abbreviated text from the column
headers to ensure that the column names are descriptive and unambiguous.
This ensures that the script accomplishes the assignment's fourth
criteria: *Appropriately labels the data set with descriptive variable
names.*.

#### Assign Descriptive Activity Names.

    meanstdactivity <- merge(meanstd, activitylabels, by = 'activityid', all.x = TRUE)

#### Tidy Data Labels

    names(meanstdactivity)<-gsub("^t", "time", names(meanstdactivity))
    names(meanstdactivity)<-gsub("^f", "frequency", names(meanstdactivity))
    names(meanstdactivity)<-gsub("Acc", "accelerometer", names(meanstdactivity))
    names(meanstdactivity)<-gsub("Gyro", "gyroscope", names(meanstdactivity))
    names(meanstdactivity)<-gsub("Mag", "magnitude", names(meanstdactivity))
    names(meanstdactivity)<-gsub("BodyBody", "body", names(meanstdactivity))
    names(meanstdactivity)<-gsub("Body", "body", names(meanstdactivity))

### Create New Tidy Data Set

This section of code will use the data set created by the previous
script to create a second data set which details the means of the
variables. This ensures the script accomplishes the assignment's fifth,
and final, criteria: *From the data set in step 4, creates a second,
independent tidy data set with the average of each variable for each
activity and each subject.*.  
The new data set is created aggregating the data collected previously by
the subjectid and activity description. The mean for each aggregated
pool is then added to the new data set using the mean function.

#### Create Data Set

    tidydata <- aggregate(. ~subjectid + activitydescription, meanstdactivity, mean)

#### Reorder the Data

    #This line forces the subjectid into a vector to work with the order function
    tidydata$subjectid <- as.vector(tidydata$subjectid)
    tidydata <- tidydata[order(tidydata$subjectid, tidydata$activitydescription),]

#### Write Data to File

This section of code outputs the tidy data set created to a text file.
This ensures the script can satisy the assignment submission criteria:
*1) a tidy data set as described below,*.

    write.table(tidydata, file = "./data/tidydata.txt", row.names = FALSE)

###### *Created by Brian Linn 10/28/2016*
