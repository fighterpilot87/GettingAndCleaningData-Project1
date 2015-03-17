#01
rm(list=ls()) 

#02
install.packages('plyr')
install.packages('dplyr')
install.packages('tidyr')

#03
library(plyr); library(dplyr)
library(tidyr)
library(stats)

#04
activity <- tbl_df(read.table(file="./UCI HAR Dataset/activity_labels.txt"))

#05
feat <- tbl_df(read.table(file="./UCI HAR Dataset/features.txt"))

#06
feat$V2 <- as.character(feat$V2)

#07
trainsub   <- tbl_df(read.table(file="./UCI HAR Dataset/train/subject_train.txt"))
trainx     <- tbl_df(read.table(file="./UCI HAR Dataset/train/X_train.txt"))
trainy     <- tbl_df(read.table(file="./UCI HAR Dataset/train/y_train.txt"))

#08
testsub    <- tbl_df(read.table(file="./UCI HAR Dataset/test/subject_test.txt"))
testx      <- tbl_df(read.table(file="./UCI HAR Dataset/test/X_test.txt"))
testy      <- tbl_df(read.table(file="./UCI HAR Dataset/test/y_test.txt"))

#09 
names(trainx) <- feat$V2
names(testx)  <- feat$V2

#10 
train_act <- merge(trainy, activity, all=TRUE, sort=FALSE)
test_act  <- merge(testy,  activity, all=TRUE, sort=FALSE)

#11
train_xy <- tbl_df(
  cbind(data_type='training', trainsub, train_act$V2, 
        select(trainx[, unique(colnames(trainx))], 
               contains("ean"), contains("std")
        )
  )
)
test_xy <- tbl_df(
  cbind(data_type='test', testsub, test_act$V2, 
        select(testx[, unique(colnames(testx))], 
               contains("ean"), contains("std")
        )
  )
)

#12
names(train_xy)[2:3] <- c("subject", "activity")
names(test_xy)[2:3] <- c("subject", "activity")


#13
train_test <- merge(train_xy, test_xy, all=TRUE, sort=FALSE)

#14
train_test <- train_test %>% tbl_df() %>% group_by(data_type, subject, activity)

#15
train_test_grp <- train_test %>% 
  gather(variable, measurement, -c(data_type, subject, activity))

#16
train_test_grp <- train_test_grp %>% 
  tbl_df() %>% group_by(subject, activity, variable)

#17
train_test_grp_mean <- aggregate(measurement~subject+activity, train_test_grp, mean) %>% arrange(subject)

#18
write.table(train_test_grp_mean, file="GaCDCP_tidydata.txt", row.name=FALSE)
