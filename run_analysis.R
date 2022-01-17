pacman::p_load(dplyr, data.table)
fname <- "week4_course_project.zip"
if (!file.exists(fname)){
  f_URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(f_URL, fname, method="curl")
}  

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(fname) 
}

##dataframes
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("num","fun"))

act_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("cnum", "activity"))
subj_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subj")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
features1 <- features[,2]

names(x_test) = features1
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "ccode")
subj_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subj")

x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
names(x_train) = features1
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "ccode")


## 1. Merge the training and the test sets to create one data set

df_test <- cbind(subj_test, y_test, x_test)
df_train <- cbind(subj_train, y_train, x_train)
df = rbind(df_test, df_train)


## 2. Extract only the measurements on the mean 
##and standard deviation for each measurement

names(df)
df_2 <- df %>% 
  select(subj, ccode, contains("mean"), contains("std"))
names(df_2)
dim(df_2)

## 3. Use descriptive activity names to name the activities in the data set
act_labels

df_2$ccode <- act_labels[df_2$ccode, 2]
df_2$ccode

## 4. Appropriately label the dataset with descriptive variable names

names(df_2)

## f means Frequency, while t - Time.
## Acc means Accelerometer, Mag stays for Magnitude, Gyro means Gyroscope, 
## whilst for BodyBody we can leave just Body without duplicate.

names(df_2)<-gsub("^t", "Time", names(df_2))
names(df_2)<-gsub("^f", "Frequency", names(df_2))
names(df_2)<-gsub("BodyBody", "Body", names(df_2))
names(df_2)<-gsub("Mag", "Magnitude", names(df_2))
names(df_2)<-gsub("Gyro", "Gyroscope", names(df_2))
names(df_2)<-gsub("Acc", "Accelerometer", names(df_2))

## rename ccode for activity
df_2 <- df_2 %>% 
  rename("activity" = "ccode")
names(df_2)

## 5. From the previous step, create a second, independent tidy data set 
## with the average of each variable for each activity and each subject.

#subj as factor 
df_2$subj <- as.factor(df_2$subj)
df_2 <- data.table(df_2)


df_4 <- group_by(df_2, activity, subj)
df_4 <- summarise_all(df_4, funs(mean))
write.table(df_4, "ind_tidy_dataset_fin.txt", row.name=FALSE)

## Make Codebook

library(codebook)
#new_codebook_rmd()

library(knitr)
rmarkdown::render()
