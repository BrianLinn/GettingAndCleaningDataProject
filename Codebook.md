Codebook Description
--------------------

The codebook provides details about the data used in the analysis.
Details about the variables and any data transformations is also
included in the codebook. The actual script run\_anlaysis.R extracts
data from the "Human Activity Recognition Using Smartphones Data Set".
After extracting the data, the script merged the data and provides
descriptive names to all variables and activities observed. The scripts
final efforts create a subset of the data based on the subject and
activity performed. This final subset is included in a text output file
per the assigment goals.

### Variables in Data Set

    variables <- read.csv("./data/projectvariables.csv")
    colnames(variables) <- c("variable","variabledescription")
    variables

                                           variable
    1             frequencybodyaccelerometer_mean_X
    2             frequencybodyaccelerometer_mean_Y
    3             frequencybodyaccelerometer_mean_Z
    4              frequencybodyaccelerometer_std_X
    5              frequencybodyaccelerometer_std_Y
    6              frequencybodyaccelerometer_std_Z
    7         frequencybodyaccelerometerJerk_mean_X
    8         frequencybodyaccelerometerJerk_mean_Y
    9         frequencybodyaccelerometerJerk_mean_Z
    10         frequencybodyaccelerometerJerk_std_X
    11         frequencybodyaccelerometerJerk_std_Y
    12         frequencybodyaccelerometerJerk_std_Z
    13 frequencybodyaccelerometerJerkmagnitude_mean
    14  frequencybodyaccelerometerJerkmagnitude_std
    15     frequencybodyaccelerometermagnitude_mean
    16      frequencybodyaccelerometermagnitude_std
    17                frequencybodygyroscope_mean_X
    18                frequencybodygyroscope_mean_Y
    19                frequencybodygyroscope_mean_Z
    20                 frequencybodygyroscope_std_X
    21                 frequencybodygyroscope_std_Y
    22                 frequencybodygyroscope_std_Z
    23     frequencybodygyroscopeJerkmagnitude_mean
    24      frequencybodygyroscopeJerkmagnitude_std
    25         frequencybodygyroscopemagnitude_mean
    26          frequencybodygyroscopemagnitude_std
    27                 timebodyaccelerometer_mean_X
    28                 timebodyaccelerometer_mean_Y
    29                 timebodyaccelerometer_mean_Z
    30                  timebodyaccelerometer_std_X
    31                  timebodyaccelerometer_std_Y
    32                  timebodyaccelerometer_std_Z
    33             timebodyaccelerometerJerk_mean_X
    34             timebodyaccelerometerJerk_mean_Y
    35             timebodyaccelerometerJerk_mean_Z
    36              timebodyaccelerometerJerk_std_X
    37              timebodyaccelerometerJerk_std_Y
    38              timebodyaccelerometerJerk_std_Z
    39      timebodyaccelerometerJerkmagnitude_mean
    40       timebodyaccelerometerJerkmagnitude_std
    41          timebodyaccelerometermagnitude_mean
    42           timebodyaccelerometermagnitude_std
    43                     timebodygyroscope_mean_X
    44                     timebodygyroscope_mean_Y
    45                     timebodygyroscope_mean_Z
    46                      timebodygyroscope_std_X
    47                      timebodygyroscope_std_Y
    48                      timebodygyroscope_std_Z
    49                 timebodygyroscopeJerk_mean_X
    50                 timebodygyroscopeJerk_mean_Y
    51                 timebodygyroscopeJerk_mean_Z
    52                  timebodygyroscopeJerk_std_X
    53                  timebodygyroscopeJerk_std_Y
    54                  timebodygyroscopeJerk_std_Z
    55          timebodygyroscopeJerkmagnitude_mean
    56           timebodygyroscopeJerkmagnitude_std
    57              timebodygyroscopemagnitude_mean
    58               timebodygyroscopemagnitude_std
    59              timeGravityaccelerometer_mean_X
    60              timeGravityaccelerometer_mean_Y
    61              timeGravityaccelerometer_mean_Z
    62               timeGravityaccelerometer_std_X
    63               timeGravityaccelerometer_std_Y
    64               timeGravityaccelerometer_std_Z
    65       timeGravityaccelerometermagnitude_mean
    66        timeGravityaccelerometermagnitude_std
                                                  variabledescription
    1                Mean value of X coordinate of body acceleration.
    2                Mean value of Y coordinate of body acceleration.
    3                Mean value of Z coordinate of body acceleration.
    4  Standard deviation value of X coordinate of body acceleration.
    5  Standard deviation value of Y coordinate of body acceleration.
    6  Standard deviation value of Z coordinate of body acceleration.
    7           Mean value of X coordinate of body acceleration jerk.
    8           Mean value of Y coordinate of body acceleration jerk.
    9           Mean value of Z coordinate of body acceleration jerk.
    10  Standard deviation of X coordinate of body acceleration jerk.
    11  Standard deviation of Y coordinate of body acceleration jerk.
    12  Standard deviation of Z coordinate of body acceleration jerk.
    13             Mean value of magnitude of body acceleration jerk.
    14     Standard deviation of magnitude of body acceleration jerk.
    15                  Mean value of magnitude of body acceleration.
    16          Standard deviation of magnitude of body acceleration.
    17               Mean value of X coordinate of body acceleration.
    18               Mean value of Y coordinate of body acceleration.
    19               Mean value of Z coordinate of body acceleration.
    20       Standard deviation of X coordinate of body acceleration.
    21       Standard deviation of Y coordinate of body acceleration.
    22       Standard deviation of Z coordinate of body acceleration.
    23             Mean value of magnitude of body acceleration jerk.
    24     Standard deviation of magnitude of body acceleration jerk.
    25                  Mean value of magnitude of body acceleration.
    26          Standard deviation of magnitude of body acceleration.
    27               Mean value of X coordinate of body acceleration.
    28               Mean value of Y coordinate of body acceleration.
    29               Mean value of Z coordinate of body acceleration.
    30       Standard deviation of X coordinate of body acceleration.
    31       Standard deviation of Y coordinate of body acceleration.
    32       Standard deviation of Z coordinate of body acceleration.
    33          Mean value of X coordinate of body acceleration jerk.
    34          Mean value of Y coordinate of body acceleration jerk.
    35          Mean value of Z coordinate of body acceleration jerk.
    36  Standard deviation of X coordinate of body acceleration jerk.
    37  Standard deviation ofYX coordinate of body acceleration jerk.
    38  Standard deviation of Z coordinate of body acceleration jerk.
    39             Mean value of magnitude of body acceleration jerk.
    40     Standard deviation of magnitude of body acceleration jerk.
    41                  Mean value of magnitude of body acceleration.
    42          Standard deviation of magnitude of body acceleration.
    43               Mean value of X coordinate of body acceleration.
    44               Mean value of Y coordinate of body acceleration.
    45               Mean value of Z coordinate of body acceleration.
    46       Standard deviation of X coordinate of body acceleration.
    47       Standard deviation of Y coordinate of body acceleration.
    48       Standard deviation of Z coordinate of body acceleration.
    49          Mean value of X coordinate of body acceleration jerk.
    50          Mean value of Y coordinate of body acceleration jerk.
    51          Mean value of Z coordinate of body acceleration jerk.
    52  Standard deviation of X coordinate of body acceleration jerk.
    53  Standard deviation of Y coordinate of body acceleration jerk.
    54  Standard deviation of Z coordinate of body acceleration jerk.
    55             Mean value of magnitude of body acceleration jerk.
    56     Standard deviation of magnitude of body acceleration jerk.
    57                  Mean value of magnitude of body acceleration.
    58          Standard deviation of magnitude of body acceleration.
    59            Mean value of X coordinate of gravity acceleration.
    60            Mean value of Y coordinate of gravity acceleration.
    61            Mean value of Z coordinate of gravity acceleration.
    62    Standard deviation of X coordinate of gravity acceleration.
    63    Standard deviation of Y coordinate of gravity acceleration.
    64    Standard deviation of Z coordinate of gravity acceleration.
    65               Mean value of magnitude of gravity acceleration.
    66       Standard deviation of magnitude of gravity acceleration.

Data Used In Analysis
---------------------

The "Human Activity Recognition Using Smartphones Data Set" included
information collected from devices embedded in subject phones. The
measurements were done observing the subjects performing various
activities.

### Feature and Activity Labels

The run\_analysis.R script imports the activity and feature labels
first: /UCI HAR Dataset/activity\_labels.txt /UCI HAR
Dataset/features.txt

The information in these files is used to appropriately name the
variables and activities.

### Train and Test Data

The run\_analysis.R script then loads the Train and Test Data: /UCI HAR
Dataset/train/subject\_train.txt /UCI HAR Dataset/train/y\_train.txt
/UCI HAR Dataset/train/X\_train.txt /UCI HAR
Dataset/test/subject\_test.txt /UCI HAR Dataset/test/y\_test.txt /UCI
HAR Dataset/test/X\_test.txt

The information contained in those files is described in the README file
attached to the data: Y\_ files include the class labels for each
observation x\_ files include the data set including all observations
subject\_ files identify the subject performing the observed activity

Transformations
---------------

All of the data objects identified above were transformed into R
objects. The R data objects were then further transformed through
merging and subsetting the data. The variable names were updated to
provide the appropriate level of detail.

1.  /UCI HAR Dataset/activity\_labels.txt transformed into activities
2.  /UCI HAR Dataset/features.txt transformed into features
3.  /UCI HAR Dataset/train/subject\_train.txt transformed into
    trainsubject
4.  /UCI HAR Dataset/train/y\_train.txt transformed into trainlabels
5.  /UCI HAR Dataset/train/X\_train.txt transformed into trainset
6.  /UCI HAR Dataset/test/subject\_test.txt transformed into testsubject
7.  /UCI HAR Dataset/test/y\_test.txt transformed into testlabels
8.  /UCI HAR Dataset/test/X\_test.txt transformed into testset
9.  trainsubject, trainlabels, and trainset are transformed into
    trainall
10. The column names for trainsubject and testsubject were updated to
    subjectid
11. The column names for trainlabels and testlabels were updated to
    activityid
12. The column names for trainset and testset are updated by merging
    with features
13. testsubject, testlabels, and testset are transformed into testall
14. trainall and testall are transformed into testtrainall
15. testrainall colnames are transformed into datatokeep
16. testtrainall is transformed into meanstd using datatokeep as a
    filter
17. meanstd is transformed into meanstdactivity by merging with
    activities
18. The names of the variables in meanstdactivity were tidied by
    transforming anything that began with a 't' to time, anything that
    began with an 'f' to frequency, any occurrence of 'Acc' to
    accellerometer, any occurrence of 'Gyro' to gyroscope, any occurence
    of 'Mag' to magnitude, any occurrence of 'BodyBody' to body, and any
    occurrence of 'Body' to body.
19. meanstrdactivity was transformed into tidydata
20. tidydata was transformed by way of reordering by subjectid and
    activitydescription
