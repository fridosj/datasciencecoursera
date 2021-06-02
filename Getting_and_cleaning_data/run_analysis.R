#OBJECTIVES
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



#Load packaged and get the path
library(data.table);library(reshape2);library(dplyr)
path <- getwd()
#Load the activity+features and get the needed measurements
activity <- fread(file.path(path,"UCI HAR Dataset/activity_labels.txt"),col.names = c("activitylabels","activitynames"))
features <- fread(file.path(path,"UCI HAR Dataset/features.txt")
                        , col.names = c("featurelabels","featurenames"))
featureswanted <- grep("(mean|std)\\(\\)",features[,featurenames])
measurements <- features[featureswanted,featurenames]
measurements <- gsub("[()]","",measurements)
#Load the training datasets and combine them
trainobs <- fread(file.path(path, "UCI HAR Dataset/train/X_train.txt"))[,featureswanted,with=FALSE]
setnames(trainobs, colnames(trainobs), measurements)
trainactivities <- fread(file.path(path, "UCI HAR Dataset/train/Y_train.txt")
                         , col.names = c("Activity"))
trainsubjects <- fread(file.path(path, "UCI HAR Dataset/train/subject_train.txt")
                       , col.names = c("Subjectid"))
train <- cbind(trainsubjects,trainactivities,trainobs)


#Load the test datasets and combine them
testobs <- fread(file.path(path, "UCI HAR Dataset/train/X_train.txt"))[,featureswanted,with=FALSE]
setnames(testobs, colnames(testobs), measurements)
testactivities <- fread(file.path(path, "UCI HAR Dataset/train/Y_train.txt")
                         , col.names = c("Activity"))
testsubjects <- fread(file.path(path, "UCI HAR Dataset/train/subject_train.txt")
                       , col.names = c("Subjectid"))
test <- cbind(testsubjects,testactivities,testobs)

#create the merged dataset of training and test datasets
wholedt <- rbind(train,test)

#Convert classlabels into activitynames
wholedt[["Activity"]] <- factor(wholedt[,Activity]
                                ,levels = activity[["activitylabels"]]
                                ,labels = activity[["activitynames"]])
wholedt[["Subjectid"]] <- as.factor(wholedt[,Subjectid])

#Reshaping the dataset
wholedt <- melt(wholedt,id=c("Subjectid","Activity"))
wholedt <- dcast(wholedt,Subjectid+Activity~variable,fun.aggregate = mean)

#Writing to a text file
fwrite(x = wholedt, file = "tidyData.txt", quote = FALSE)
