setwd("~/Desktop/JHU/Getting_and_Cleanning data/UCI HAR Dataset")
#read in data files
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")
features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")

#Add the subject number, activity type and the measurement together
testdata <- cbind(subject_test, y_test, x_test)
traindata <- cbind(subject_train, y_train, x_train)

#merge test data with train data
data <- rbind(testdata, traindata)

# give colnames to the merged dataset
colname <- c("Subject", "Activity", as.character(features[,2]))
colnames(data) <- colname

#extract columns with measurements mean or std, and also extract subject, activity columns
mean <- grep("mean", colname)
sd <- grep("std", colname)
extract <- c(1, 2, mean, sd)
subdata <- data[,extract]

#Uses descriptive activity names to name the activities in the data set
dim(subdata)
for (i in 1: dim(subdata)[1]){
        if (subdata$Activity[i] == 1) subdata$Activity[i] = "WALKING"
        else if (subdata$Activity[i] == 2) subdata$Activity[i] = "WALKING_UPSTAIRS"
        else if (subdata$Activity[i] == 3) subdata$Activity[i] = "WALKING_DOWNSTAIRS"
        else if (subdata$Activity[i] == 4) subdata$Activity[i] = "SITTING"
        else if (subdata$Activity[i] == 5) subdata$Activity[i] = "STANDING"
        else if (subdata$Activity[i] == 6) subdata$Activity[i] = "LAYING"
}

#the average of each variable for each activity 
a <- data.frame(rep(0,6))
for (i in 3:dim(subdata)[2]){
        a <- cbind(a, tapply(subdata[,i], subdata$Activity, mean))
}
a <- a[,-1]
colnames(a) <- names(subdata)[3:81]

#the average of each variable for each subject
s <- data.frame(rep(0,30))
for (i in 3:dim(subdata)[2]){
        s <- cbind(s, tapply(subdata[,i], subdata$Subject, mean))
}
s <- s[,-1]
colnames(s) <- names(subdata)[3:81]

activity_subject <- rbind(a,s)

#write out the final data
write.table(activity_subject, file = "tidy_mean_for_each_activity_and_subject.txt")


# m <- cbind(m, tapply(subdata[,3], subdata$Activity, mean))
# m <- cbind(m, tapply(subdata[,4], subdata$Activity, mean))
# m
# tapply(subdata[,4], subdata$Activity, mean)
# 
# 
# #split data by activity
# splitdata <- split(subdata, subdata$Activity)
# for (i in 1:length(splitdata)){
#         splitdata[i] <- splitdata[[i]][,3:81]
# }
# 




# tapply(subdata[,3], subdata$Activity, mean)
# 
# 
# for (in in 3: dim(subdata)[2]){
#         
# }




# 
# colnames(x_test) <- features[,2]
# x_test$subject <- subject_test
# x_test$activity <- y_test
# 
# colnames(x_train) <- features[,2]
# x_train$subject <- subject_train
# x_train$activity <- y_train
# 
# 
# 
# data <- rbind(x_test, x_train)
