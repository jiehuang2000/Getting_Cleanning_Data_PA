# This file describes the variables, the data, and any transformations or work that I performed to clean up the data.

## first set the working directory and  read in data files

```r
setwd("~/Desktop/JHU/Getting_and_Cleanning_data/UCI HAR Dataset")
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")
features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")
```



## Add the subject number, activity type and the measurement together

```r
testdata <- cbind(subject_test, y_test, x_test)
traindata <- cbind(subject_train, y_train, x_train)
```





## merge test data with train data

```r
data <- rbind(testdata, traindata)
```

## give colnames to the merged dataset

```r
colname <- c("Subject", "Activity", as.character(features[, 2]))
colnames(data) <- colname
```

## extract columns with measurements mean or std, and also extract subject, activity columns

```r
mean <- grep("mean", colname)
sd <- grep("std", colname)
extract <- c(1, 2, mean, sd)
subdata <- data[, extract]
```


## Uses descriptive activity names to name the activities in the data set

```r
dim(subdata)
```

```
## [1] 10299    81
```

```r
for (i in 1:dim(subdata)[1]) {
    if (subdata$Activity[i] == 1) 
        subdata$Activity[i] = "WALKING" else if (subdata$Activity[i] == 2) 
        subdata$Activity[i] = "WALKING_UPSTAIRS" else if (subdata$Activity[i] == 3) 
        subdata$Activity[i] = "WALKING_DOWNSTAIRS" else if (subdata$Activity[i] == 4) 
        subdata$Activity[i] = "SITTING" else if (subdata$Activity[i] == 5) 
        subdata$Activity[i] = "STANDING" else if (subdata$Activity[i] == 6) 
        subdata$Activity[i] = "LAYING"
}
```


## the average of each variable for each activity 

```r
a <- data.frame(rep(0, 6))
for (i in 3:dim(subdata)[2]) {
    a <- cbind(a, tapply(subdata[, i], subdata$Activity, mean))
}
a <- a[, -1]
colnames(a) <- names(subdata)[3:81]
```

## the average of each variable for each subject

```r
s <- data.frame(rep(0, 30))
for (i in 3:dim(subdata)[2]) {
    s <- cbind(s, tapply(subdata[, i], subdata$Subject, mean))
}
s <- s[, -1]
colnames(s) <- names(subdata)[3:81]

activity_subject <- rbind(a, s)
```

## write out the final data

```r
write.table(activity_subject, file = "tidy_mean_for_each_activity_and_subject.txt")
```


