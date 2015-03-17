# Getting and Cleaning Data - Course Project 1

##ReadMe for run_analysis.R

####01- clear workspace

####02- install all necessary packages 
####03- load libraries

####04- input data of activity names into variable "activity"

####05- Input list of all features collected from sensors into variable "feat"

####06- convert column V2 of feat to characters (allows ability to find mean and std measurements)

####07- extract training data and input into train variables

####08- extract test data and input into test variables

####09- (OBJECTIVE 4) Labels variable names to measurements in training and test data (columns names)
####    with dezcriptive data from "features.txt"

####10- (OBJECTIVE 3) use descriptive activity names to name activities 
####    in training and test data set variables

####11- Column binds with:
####       Type of data set (i.e. training or test)
####       Subject number
####       Activity type
####    (OBJECTIVE 2) Then extract only measurments on mean and standard deviation

####12- Labels subject and activity variables

####13- (OBJECTIVE 1) Merge training and test data

####14- Assign groups by type, subject and activity

####15- Use tidyr to create a tidy data by type of data (training or test), subject, and activity

####16- Groups the tidy data by subject, activity, and variable

####17- Creates independed tidy data set with average of each variable for each activity 
####    and each subject