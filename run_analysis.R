#run_analysis.R as Final Project for Getting & Cleaning Data
# TASKS
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

setwd("~/datascience_Course3_FinalProj")
library(data.table)
library(plyr)
library(dplyr)


# Directory locations
dataLocation <- './UCI HAR Dataset/'
trainingData <-paste0(dataLocation,'train/')
testingData <- paste0(dataLocation, 'test/')

# Read TXT Files
feature_names <- read.table(paste0(dataLocation,'features.txt'),header = FALSE)
activity_names <- read.table(paste0(dataLocation,'activity_labels.txt'), header = FALSE, stringsAsFactors = TRUE,
                            col.names = c('ID','Name'))

# Load  Data
train_subjID <- read.table(paste0(trainingData,'subject_train.txt'), header = FALSE, col.names = 'subjectID')
train_activity <- read.table(paste0(trainingData,'Y_train.txt'), header = FALSE, col.names = 'activityType')
train_measurements <- read.table(paste0(trainingData,'X_train.txt'), header = FALSE,col.names = feature_names[[2]])
trainingset <- data.table(train_subjID, train_activity, train_measurements)

test_subjID <- read.table(paste0(testingData,'subject_test.txt'), header = FALSE, col.names = 'subjectID')
test_activity <- read.table(paste0(testingData,'Y_test.txt'), header = FALSE, col.names = 'activityType')
test_measurements <- read.table(paste0(testingData,'X_test.txt'), header = FALSE, col.names = feature_names[[2]])
testingset <- data.table(test_subjID, test_activity, test_measurements)


# 1. Merge Training & Testing Sets
allData <- rbind(trainingset,testingset)


# 2. Extract Mean & Std Dev Measurements
mean_feature_cols <- grep("mean",feature_names$V2)
std_feature_cols <- grep("std",feature_names$V2)
allData_means <- allData[,mean_feature_cols+2,with=FALSE]
allData_stds <- allData[,std_feature_cols+2,with=FALSE]
mean_std_Data <- cbind(allData[,1:2],allData_means,allData_stds)


# 3. Update 'Activity Type' column in allData to have activity name
activityLabels <- levels(activity_names$Name)
mean_std_Data$activityType <- as.factor(mean_std_Data$activityType)
levels(mean_std_Data$activityType) <- activityLabels



# 4. Update Variable Names
exps <- "\\.+"
colnames(mean_std_Data) <- gsub(exps," ",colnames(mean_std_Data))


# 5. Subject/Activity Summary Table
tidy_data <- summarize_each(group_by(mean_std_Data,subjectID,activityType),
                            funs="mean",
                            vars=-(1:2))


# Write out table
write.table(tidy_data, 'dataSummary.txt',sep = ",", row.names = FALSE)


