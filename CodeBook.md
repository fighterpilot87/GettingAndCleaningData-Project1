# Getting and Cleaning Data - Course Project 1

##CodeBook.md - Code Book for run_analysis.R variables

####activity - data from "activity_labels.txt" 
####           activity names used to identify activities in data sets 
####           to be merged with corresponding V1 values in 
####           "trainy" (y_train.txt) and "testy" (y_test.txt) data sets.
####           activities: WALKING, WALKING+UPSTAIRS, WALKING_DOWNSTAIRS, 
####           SITTING, STANDING, LAYING)

####feat - data from "features.txt"
####       a 561 vector of names used to identify data set measurements
####       to be merged with "trainx" (x_train.txt) and 
####       "testx" (x_test.txt)  data sets.

####test_act - merged data with "activity" and "testy" used to identify 
####           activity variables in test data set "testx"

####test_xy - Combined dataframe of variables:
####          type of data set (i.e. test)
####          subject number (who carried out the experiment)
####          activity type (standing, laying)
####          data from "testx"

####testsub - data from "subject_test.txt" 
####          Vector of test subjects listed in corresponding value to
####          "testy" (y_test.txt)

####testx - data from "x_test.txt"
####        data frame of test measurement variables from 
####        each subject and each activity

####testy - data from "y_test.txt"
####        vector of values corresponding to test activities in "activity"

####train_act - merged data with "activity" and "trainy" used to identify 
####            activity variables in test data set "trainx"

####train_test - data frame of merged test and training data

####train_test_grp - Tidy data of train_test grouped by data type, subject,
####                 and activity

####train_test_grp_mean - Tidy data set with average of each variable 
####                      for each activity and each subject

####train_xy - Combined dataframe of variables
####           type of data set (i.e. training)
####           subject number (who carried out the experiment)
####           activity type (standing, laying)
####           data from "trainx"

####trainsub - data from "subject_test.txt" 
####           Vector of test subjects listed in corresponding value to
####           "trainy" (y_train.txt)

####trainx - data from "x_train.txt"
####         data frame of training measurement variables from 
####         each subject and each activity

####trainy - data from "y_train.txt"
####         vector of values corresponding to train activities in "activity"

