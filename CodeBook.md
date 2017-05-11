# datascience_Course3_FinalProj
Getting &amp; Cleaning Data final project

Author: Suzanne Farrell
May 9, 2017

#############################################

The Data

#############################################


The Data used for this final assignment can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Unzipping, there are 4 text files, and 2 subfolders. The text files used
for this assigment are as follows:

- activity_labels.txt
- features.txt
- ./training/subject_train.txt
- ./training/X_train.txt
- ./training/y_train.txt
- ./test/subject_test.txt
- ./test/X_test.txt
- ./test/y_train.txt


#############################################

About the Data

#############################################

I  activity_labels.txt
size = [6,2]
This contains the names and unique IDs of the activities that were tracked by the wearable device. There are 6 different activities.

II  features.txt
size = [562,2]
This contains the names of the data that were recorded by the wearable device. 

III subject_[train/test].txt
size_train = [7392,1]
size_test = [2947,1]
A vector of subject IDs

IV  X_[train/test].txt
size_train = [7392,562]
size_test = [2947,562]
This contains all the measurement data for each feature per subject

V  y_[train/test].txt
size_train = [7392,1]
size_test = [2947,1]
This corresponds to the activity ID per subject


#############################################

run_anaysis.R

#############################################
The run_analysis.R script will output a tidy dataset that summarizes the data collected per subject per activity.
First, the training and testing data are read in and merged together. Next, the variables that are subscripted with "mean" and "std" are extracted. In this extracted dataset, the acivity IDs are converted to the activity name. Finally, it summarizes each variable in the extracted dataset by its mean per activity per subject.
