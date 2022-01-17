---
title: "Codebook"
output:
  html_document:
    toc: true
    toc_depth: 4
    toc_float: true
    code_folding: 'hide'
    self_contained: true
  pdf_document:
    toc: yes
    toc_depth: 4
    latex_engine: xelatex
---

Script named as run_analysis.R. It includes:
- data preparation 
- five steps of the course project.

Variables:
fname is the file name of data set.
f_URL - URL address to download data set.
features - file "features.txt".

act_labels - file "activity_labels.txt".
subj_test - file "subject_test.txt".

x_test - file "UCI HAR Dataset/test/X_test.txt".

features1 - columns in the features data set can be named from features ("tBodyAcc-mean()-X" etc.).

y_test - file "UCI HAR Dataset/test/y_test.txt".
subj_train - file "UCI HAR Dataset/train/subject_train.txt".

x_train - file "UCI HAR Dataset/train/X_train.txt".

y_train - file "UCI HAR Dataset/train/y_train.txt".


## 1. Merge the training and the test sets to create one data set

df_test - merged subj_test, y_test, x_test.
df_train - merged subj_train, y_train, x_train.
df - merged df_test and df_train.


## 2. Extract only the measurements on the mean 
##and standard deviation for each measurement


df_2 - data set with the measurements on the mean and standard deviation 
for each measurement.

## 3. Use descriptive activity names to name the activities in the data set

df_2$ccode column contains descriptive activity names.

## 4. Appropriately label the dataset with descriptive variable names

df_2 is appropriately labeled with descriptive variable names:

f means Frequency, while t - Time.
Acc means Accelerometer, Mag stays for Magnitude, Gyro means Gyroscope, 
whilst for BodyBody we can leave just Body without duplicate.

names(df_2)<-gsub("^t", "Time", names(df_2))
names(df_2)<-gsub("^f", "Frequency", names(df_2))
names(df_2)<-gsub("BodyBody", "Body", names(df_2))
names(df_2)<-gsub("Mag", "Magnitude", names(df_2))
names(df_2)<-gsub("Gyro", "Gyroscope", names(df_2))
names(df_2)<-gsub("Acc", "Accelerometer", names(df_2))

## rename ccode for activity
So we rename those names correspondingly.

## 5. From the previous step, create a second, independent tidy data set 
## with the average of each variable for each activity and each subject.

df_4 second, independent tidy data set which is a group by of df_2 by activity
and subject. Then it is summarised, containing the average of each variable 
for each activity and each subject.

"ind_tidy_dataset_fin.txt" - final output.