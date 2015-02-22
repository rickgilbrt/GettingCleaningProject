##
##
##
##
##

## Some file locators:
run_analysis <- function() {
trnfile <- "UCI HAR Dataset/train/X_train.txt"
testfile <- "UCI HAR Dataset/test/X_test.txt"

testlblfile <- "UCI HAR Dataset/test/y_test.txt"
trainlblfile <- "UCI HAR Dataset/train/y_train.txt"

trainsubjfile <- "UCI HAR Dataset/train/subject_train.txt"
testsubjfile <- "UCI HAR Dataset/test/subject_test.txt"

actlblfile <- "UCI HAR Dataset/activity_labels.txt"
featuresfile <- "UCI HAR Dataset/features.txt"
featuresinfofile <- "UCI HAR Dataset/features_info.txt"

## read in subject_test.txt
xtest <- read.csv(testsubjfile,sep =" ", header = FALSE)
## read in test_activity.txt
tmp <- read.csv(testlblfile,sep =" ", header = FALSE)
## add the activities to the xtest data frame
xtest$activity <- tmp[,1]
## add label for subject variable in xtest
names(xtest) <- c("subject","activity")
## read in the numeric test data file
xtestdata <- read.table(testfile,header=FALSE, strip.white=TRUE)
## add test data to subj/activities data frame
xtest <- data.frame(xtest,xtestdata)

## read in subject_train.txt
xtrain <- read.csv(trainsubjfile,sep =" ", header = FALSE)
## read in train_activity.txt
tmp <- read.csv(trainlblfile,sep =" ", header = FALSE)
## add the activities to the xtrain data frame
xtrain$activity <- tmp[,1]
## add label for subject variable in xtrain
names(xtrain) <- c("subject","activity")
## read in the numeric training data file
xtraindata <- read.table(trnfile,header=FALSE, strip.white=TRUE)
## add test data to subj/activities data frame
xtrain <- data.frame(xtrain,xtraindata)
## free up some memory
xtestdata <- NULL
xtraindata <- NULL

## Next we should merge the two files (append one to the other)
xdata <- rbind(xtest,xtrain)

## Let's go get the features labels so we can find the mean and std deviation fields
xfeatures <- read.csv(featuresfile,header=FALSE, sep =" ")

## convert factors to character for ease of use
xfeatures$V2 <- as.character(xfeatures$V2)

## The features labels contain characters not recognized in variable names
xfeatures$V2 <- gsub("-","",xfeatures$V2)
xfeatures$V2 <- gsub("\\(","",xfeatures$V2)
xfeatures$V2 <- gsub("\\)","",xfeatures$V2)
xfeatures$V2 <- gsub("\\,","",xfeatures$V2)

## meanFreq may or may not be a mean in the context of this exercise.  We will
## include it, but exclude the "angle" measures that include "Mean" by setting
## ignore.case=FALSE in our search
## Let's create a new variable for the features for (mean, std, other)
xfeatures$V3 <- ifelse(grepl("mean", xfeatures$V2, ignore.case = FALSE), "mean", 
        ifelse(grepl("std", xfeatures$V2, ignore.case = FALSE), "std", "Other"))

## now create a df containing just the features we want to retain
keepFeat <- xfeatures[xfeatures$V3 %in% c("mean","std"),1:3]


## It's time to subset xdata to retain only the mean & std cols. But we'll do
## by variable names
## First apply the modified feature names to the columns in xdata
names(xdata) <- c("subject","activity",xfeatures$V2)

## Now subset the xdata set using keepFeat$V2 to keep only the mean and std cols
xdata <- data.frame(xdata[,1:2],xdata[,names(xdata) %in% keepFeat$V2])

## now replace the activity numeric values with activity names
activitynames <- read.csv(actlblfile,sep =" ", header = FALSE)

xdata$activity <- activitynames$V2[xdata$activity]

## OK - now for the big finale - use the aggregate function to build the summary means:
tidyset <- aggregate(xdata[,3:81], by = xdata[,1:2],FUN= "mean")

## The following line can be used to write the step 4 dataset to a file for review
## write.table(xdata, "xdata.txt", sep="\t", row.names=FALSE, col.names=TRUE)

## Now write the output to a text file in the current workign directory for later use:
write.table(tidyset, "tidyset.txt", sep="\t", row.names=FALSE, col.names=TRUE)

}