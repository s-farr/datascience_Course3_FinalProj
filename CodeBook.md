# datascience_Course3_FinalProj
Getting &amp; Cleaning Data final project

Author: Suzanne Farrell
April 9, 2017

#############################################

The Data

The Data used for this final assignment can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Unpacking the data, there are 4 text files, and 2 subfolders. The text files used
for this assigment are as follows:
    - activity_labels.txt
    - ./training/subject_train.txt
    - ./training/X_train.txt
    - ./training/y_train.txt
    - ./test/subject_test.txt
    - ./test/X_test.txt
    - ./test/y_train.txt

"activity_labels.txt" contains the names of the activities that were tracked

The "subject_[test/train]" contains the IDs of the subjects

The "X_[test/train]" files contain measurement data

The "y_[test/train]" text files contain the IDs of the activity labels



More About the Measurement Data ("X_[test/train]")

The measurement data file contains several measurements per trial (i.e. each trial, or row, of data will have more than 1 measurement entry). When read into RStudio, the resulting data frame will contain 1 column per row, with each row containing a string of all of the measurements. To clean up this data, I treated the multiple measurements per trial as having taken several instantaneous readings during a single trial. I therefore made the decision to take the average, and standard deviation of the multiple measurements per trial. The resulting data frame is then a matrix of size [n,2], 'n' being the total number of rows in text file, and the two columns being the mean, and standard deviation of the multiple measurements. 
