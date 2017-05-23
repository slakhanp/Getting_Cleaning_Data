setwd("/Users/sumeetlakhanpal/Documents/Learning/DataScience/data/Ass_4/UCI HAR Dataset")

# 1. Merges the training and the test sets to create one data set.
# Reading all the files in dataframe and assigning names

labels<-read.table("activity_labels.txt", header = FALSE)
colnames(labels) <- c("id","activitytype") 
y_train<-read.table("./train/y_train.txt", header = FALSE)
y_test<-read.table("./test/y_test.txt", header = FALSE)
colnames(y_train)  <- c("id")                                            
colnames(y_test) <- c("id") 
# Merge training and activity
traininglabel <- merge(y_train, labels, by.x="id", by.y="id", all=T)

x_train<-read.table("./train/X_train.txt", header = FALSE)
sub_train<-read.table("./train/subject_train.txt", header = FALSE)
# Merge test and activity
testlabel <- merge(y_test, labels, by.x="id", by.y="id", all=T)

sub_test<-read.table("./test/subject_test.txt", header = FALSE)
x_test<-read.table("./test/X_test.txt", header = FALSE)
features<-read.table("features.txt", header = FALSE)

# giving column names
colnames(x_train)          <-  features[,2] 
colnames(x_test)              <-  features[,2]
colnames(sub_train)       =  "subjectid"
colnames(sub_test) = "subjectid"
#bind columns to prepare Test Dataset
x_train    <- cbind(traininglabel, x_train, sub_train)
x_test        <- cbind(testlabel, x_test, sub_test)

# check for any NA values
sum(is.na(x_train))
sum(is.na(x_test))
# create single data set for training and test

all_data <- rbind(x_train, x_test)
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# Columns with mean and standard deviation.

colnames<-colnames(all_data)  

mean_std = ( grepl("id", colnames) |grepl("activity..", colnames) | grepl("subject..", colnames) | grepl("-mean..", colnames) | 
                         grepl("mean..-", colnames) | grepl("meanFreq..", colnames) | grepl("-std..", colnames) | grepl("std..-", colnames))


# Subset only those columns with mean and std deviation measurements
mean_Std_col <- all_data[mean_std]

# 3 Use descriptive activity names to name the activities in the data set
# Already done in previous steps.


# 4. Appropriately label the data set with descriptive variable names
# getting column names
newcol <- colnames(mean_Std_col)

# Adding descriptive names

for (i in 1: length(newcol)) {
  
  newcol[i] = gsub("^(i)d", "ActivityId", newcol[i]);
  newcol[i] = gsub("\\()", "", newcol[i]);
  newcol[i] = gsub("-mean", "Mean", newcol[i]);
  newcol[i] = gsub("-std", "StdDevtn", newcol[i]);
  newcol[i] = gsub("[gG]yro", "Gyro", newcol[i]);
  newcol[i] = gsub("[gG]ravity", "Gravity", newcol[i]);
  newcol[i] = gsub("[bB]ody [bB]ody | [Bb]ody ", "Body", newcol[i]);
  newcol[i] = gsub("[aA]cc[mM]ag", "AccMagnitude", newcol[i]);
  newcol[i] = gsub("[jJ]erk[mM]ag", "JerkMagnitude", newcol[i]);
  newcol[i] = gsub("[gG]yro[mM]ag", "GyroMagnitude", newcol[i]);
  newcol[i] = gsub("^(t)", "Time", newcol[i]);
  newcol[i] = gsub("^(f)", "Frequency", newcol[i]);
  newcol[i] = gsub("^(a)", "A", newcol[i]);
  newcol[i] = gsub("^(s)", "S", newcol[i]);
}

# assigning back names
colnames(mean_Std_col) <- newcol


# 5 Creates a second, independent tidy data set with the average of each variable for 
# each activity and each subject.

# remove activity type column.

noActivity <- mean_Std_col[,names(mean_Std_col) != "Activitytype"]

# final tidy dataset 
tidy    =  aggregate( noActivity[,names(noActivity) != c('ActivityId','Subjectid')],
                          by=list(ActivityId=noActivity$ActivityId, SubjectId = noActivity$Subjectid), mean);

# Assign column names
colnames(labels) <- c("ActivityId","ActivityType")

tidy_d   <- merge(tidy, labels, by="ActivityId", all=T)

#write this to a file
write.table(tidy_d[, names(tidy_d) != 'Subjectid'], "./tidyDataset.csv", sep=",", row.names=FALSE)


