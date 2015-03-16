list.files(path = "./UCI HAR Dataset/") #list files in target folder

install.packages('plyr')
install.packages('dplyr')
install.packages('tidyr')
library(plyr); library(dplyr)
library(tidyr)
library(stats)


#input data of activity names into variable for training
activity <- tbl_df(read.table(file="./UCI HAR Dataset/activity_labels.txt"))
#activity <- rename(activity, activity = V2)

#Input list of all features into variable
feat <- tbl_df(read.table(file="./UCI HAR Dataset/features.txt"))
feat$V2 <- as.character(feat$V2)

###EXTRACT Training and Test Data
#use list files to view in sub folder "train"
#list.files(path = "./UCI HAR Dataset/train/")
#input train data from files into variable
trainsub   <- tbl_df(read.table(file="./UCI HAR Dataset/train/subject_train.txt"))
trainx     <- tbl_df(read.table(file="./UCI HAR Dataset/train/X_train.txt"))
trainy     <- tbl_df(read.table(file="./UCI HAR Dataset/train/y_train.txt"))
testsub    <- tbl_df(read.table(file="./UCI HAR Dataset/test/subject_test.txt"))
testx      <- tbl_df(read.table(file="./UCI HAR Dataset/test/X_test.txt"))
testy      <- tbl_df(read.table(file="./UCI HAR Dataset/test/y_test.txt"))

#Assign variable names to measurements
names(trainx) <- feat$V2
names(testx)  <- feat$V2


#merge activity names with labels
train_act <- merge(trainy, activity, all=TRUE, sort=FALSE)
test_act  <- merge(testy,  activity, all=TRUE, sort=FALSE)

#Extract only measurments on mean and standard deviation
#Bind with activity names
train_xy <- tbl_df(
  cbind(type='train', trainsub, train_act$V2, 
        select(trainx[, unique(colnames(trainx))], 
               contains("ean"), contains("std")
               )
        )
)
test_xy <- tbl_df(
  cbind(type='test', testsub, test_act$V2, 
        select(testx[, unique(colnames(testx))], 
               contains("ean"), contains("std")
        )
  )
)

names(train_xy)[2:3] <- c("subject", "activity")
names(test_xy)[2:3] <- c("subject", "activity")


#Combine training and test data
train_test <- merge(train_xy, test_xy, all=TRUE, sort=FALSE)

#Assign group names
train_test <- train_test %>% tbl_df() %>% group_by(type, subject, activity)

a <- train_test %>% 
  gather(variable, measurement, -c(type, subject, activity))
a <- a %>% tbl_df() %>% group_by(subject, activity, variable)

b <- aggregate(measurement~subject+activity, a, mean) %>% arrange(subject)

