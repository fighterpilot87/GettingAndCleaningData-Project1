list.files(path = "./UCI HAR Dataset/") #list files in target folder

install.packages('plyr')
install.packages('dplyr')
install.packages('tidyr')
library(plyr); library(dplyr)
library(tidyr)


#input data of activity names into variable for training
activity <- tbl_df(read.table(file="./UCI HAR Dataset/activity_labels.txt"))
#activity <- rename(activity, activity = V2)

#Input list of all features into variable
feat <- tbl_df(read.table(file="./UCI HAR Dataset/features.txt"))
feat$V2 <- as.character(feat$V2)

###TRAINING
#use list files to view in sub folder "train"
#list.files(path = "./UCI HAR Dataset/train/")
#input train data from files into variable
trainsub <- tbl_df(read.table(file="./UCI HAR Dataset/train/subject_train.txt"))
trainx <- tbl_df(read.table(file="./UCI HAR Dataset/train/X_train.txt"))
trainy <- tbl_df(read.table(file="./UCI HAR Dataset/train/y_train.txt"))

#Assign variable names
names(trainx) <- feat$V2


#merge activity names with Training labels
train_act <- merge(trainy, activity, all=TRUE, sort=FALSE)

#Extract only measurments on mean and standard deviation
train_xy <- tbl_df(
  cbind(trainsub, train_act$V2, 
        select(trainx[, unique(colnames(trainx))], 
               contains("ean"), contains("std")
               )
        )
)
names(train_xy)[1:2] <- c("subject", "activity")

train_xy <- train_xy %>% group_by(subject, activity) %>% tbl_df()

a <- train_xy %>% 
  gather(variable, measurement, -c(subject, activity))
b <- a %>% ddply(c('subject', 'activity', 'variable'), 
                 summarise, 
                 mean=mean(measurement))



###TEST
#list files in sub folder "test"
list.files(path = "./UCI HAR Dataset/test/")
#input train data from files into variable
testsub <- read.table(file="./UCI HAR Dataset/test/subject_test.txt")
testx <- read.table(file="./UCI HAR Dataset/test/X_test.txt")
testy <- read.table(file="./UCI HAR Dataset/test/y_test.txt")

#merge activity names with Test labels
test_y_act <- merge(testy, activity, all=TRUE)

#Column combine activity names to Training set
test_xy_act <- cbind(test_y_act$V2, testx)
test_xy_act[1:5, 1:5]
test_xy_act[7348:7352, 1:5]


library(plyr)
trainarngd <- arrange(train_xy_act, activity)
trainarngd[1:5, 1:5]
trainarngd[7348:7352, 1:5]
dim(trainarngd)
names(trainarngd)

#separate column names sep="-" (http://stackoverflow.com/questions/7972771/split-character-in-column-and-name)
train_mean <- trainarngd[, c(1:4, 42:44, 82:84, 122:124, 162:164, 202, 215, 229, 241, 254, 267:269, 295:297, 346:348, 374:376, 425:427, 453:455, 504, 514, 517, 527, 530, 543, 553, 556:562)]
dim(train_mean)
