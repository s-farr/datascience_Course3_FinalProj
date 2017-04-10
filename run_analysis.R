#run_analysis.R as Final Project for Getting & Cleaning Data
# TASKS #
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

library(plyr)
library(dplyr)
library(data.table)

# Directory locations
dataLocation <- './UCI HAR Dataset/'
trainingData <-paste0(dataLocation,'train/')
testingData <- paste0(dataLocation, 'test/')


# Load Training Data
subjID <- read.csv(paste0(trainingData,'subject_train.txt'), header = FALSE, col.names = 'subjectid')

activity <- read.csv(paste0(trainingData,'Y_train.txt'), header = FALSE, col.names = 'activityType')

measurements <- read.csv(paste0(trainingData,'X_train.txt'), header = FALSE, col.names = 'measurements')
meanMeas <- numeric()
sdMeas <- numeric()
for (r in 1:nrow(measurements)) {
  sepMeas <- gsub(" ",",",measurements[[1]][r])
  spltMeas <- strsplit(sepMeas, ',')
  trueMeas <- spltMeas[[1]] != ''
  asnumMeas <- as.numeric(spltMeas[[1]][trueMeas])
  
  meanMeas[r] <- mean(asnumMeas)
  sdMeas[r] <- sd(asnumMeas)
  
}
trainingset <- data.table(subjID, activity, meanMeas, sdMeas)


# Load Test Data
subjID <- read.csv(paste0(testingData,'subject_test.txt'), header = FALSE, col.names = 'subjectid')

activity <- read.csv(paste0(testingData,'Y_test.txt'), header = FALSE, col.names = 'activityType')

measurements <- read.csv(paste0(testingData,'X_test.txt'), header = FALSE, col.names = 'measurements')
meanMeas <- numeric()
sdMeas <- numeric()
for (r in 1:nrow(measurements)) {
  sepMeas <- gsub(" ",",",measurements[[1]][r])
  spltMeas <- strsplit(sepMeas, ',')
  trueMeas <- spltMeas[[1]] != ''
  asnumMeas <- as.numeric(spltMeas[[1]][trueMeas])
  
  meanMeas[r] <- mean(asnumMeas)
  sdMeas[r] <- sd(asnumMeas)
  
}
testingset <- data.table(subjID, activity, meanMeas, sdMeas)


# Merge Training & Testing Sets
allData <- rbind(trainingset,testingset)


# Update 'Activity Type' column in allData to have activity name
activityNames <- read.table(paste0(dataLocation,'activity_labels.txt'), header = FALSE, stringsAsFactors = TRUE,
                            col.names = c('ID','Name'))
activityLabels <- levels(activityNames$Name)
allData$activityType <- as.factor(allData$activityType)
levels(allData$activityType) <- activityLabels

# Update Variable Names
colnames(allData) <- c("SubjectID","Activity","Mean","St.Dev.")


# Subject/Activity Summary Table
dataSummary <- data.frame(matrix(vector(), 30, 13),stringsAsFactors=F)
x <- paste0(activityLabels, "_mean")
y <- paste0(activityLabels, "_std")
z <- sort(c(x,y))
colnames(dataSummary) <- c('Subject',z)


for (i in seq(1:30)) {
  idx = 2
  dataSummary[i,] <- i
  for (j in seq(1,6)){
    tmp <- filter(allData, SubjectID == i & Activity == activityLabels[j])
    dataSummary[i,idx] <- mean(tmp$Mean)
    dataSummary[i,idx+1] <- mean(tmp$St.Dev.)
    idx = idx+2
  }
}


# Write out table
write.table(dataSummary, 'dataSummary.csv',sep = ",", row.names = FALSE)


