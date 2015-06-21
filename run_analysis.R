# load the packages needed for the script
library(plyr)
library(dplyr)

# load all the test files into one data frame
test <- read.table("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
test[,562] = read.table("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
test[,563] = read.table("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

# load all the training files into one data frame
train <- read.table("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
train[,562] = read.table("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
train[,563] = read.table("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

# load labels and rename the columns to prepare the vlookup
labels <- read.table("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
colnames(labels) = c("Activity2", "Activity")

# load features list and make the relevant content better readable
feat <- read.table("UCI HAR Dataset/features.txt", sep="", header=FALSE)
feat$V2 = gsub("[()]","", feat$V2)
feat$V2 = gsub("mean","Mean", feat$V2)
feat$V2 = gsub("std","Std", feat$V2)

# filter all the number of the rows which are relevant (mean & std)
rs <- grep("*Mean*|*Std*", feat$V2)
feat <- feat[rs,]
rs <- c(rs, 562,563)

# combine the training and test data into one frame and select the interesting rows
complete <- rbind(test, train)
complete <- complete[,rs]

# vlookup to match the activity index with the name of the activity
colnames(complete) <- c(feat$V2, "Subject", "Activity2")
complete <- join(complete, labels, by="Activity2")
complete$Activity2 <- NULL

# calculate the mean and std by subject and activity
clean = aggregate(complete, by=list(complete$Subject, complete$Activity), mean)

# delete columns which are no longer needed
clean$Subject <- NULL
clean$Activity <- NULL

# create a .txt file with the results
write.table(clean, "clean_data.txt", sep = "\t", row.names = FALSE)