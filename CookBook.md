**Getting and Cleaning Data - Course Project**

**Overview**

The purpose of this cookbook document is to provide details about the data collection, transformation, cleaning and working steps on a dat#a set

**Source Data**

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

**DataSet Information**

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.   The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

**Attribute Information:**

For each record in the dataset it is provided: 

1. Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 

2. Triaxial Angular velocity from the gyroscope. 
3. A 561-feature vector with time and frequency domain variables. 
4. Its activity label.  5. An identifier of the subject who carried out the experiment. 

**The dataset includes the following files:
**	
1. features_info.txt: Information about the variables used on the feature vector.
2. features.txt: List of all features.
3. activity_labels.txt: Links the class labels with their activity name.
4. train/X_train.txt: Training set.
5. train/y_train.txt: Training labels.
6. test/X_test.txt: Test set.

**Description of run_analysis.R Script:
**

Steps in the Script as below:-

1. Merge the training and the test sets to create one data set.
Read the following files into dat frames.:
	•	features.txt
	•	activity_labels.txt
	•	subject_train.txt
	•	x_train.txt
	•	y_train.txt
	•	subject_test.txt
	•	x_test.txt
	•	y_test.txt
Assign column names and merge.
2. Extract only the measurements on the mean and standard deviation for each measurement.
Search for mean and standard deviation in column names. Extracted subset of these.
3. Use descriptive activity names to name the activities in the data set
Merge data subset with the activityType table to include the descriptive activity names This step has been done in previous step using activity id and the id from the dataset 
4. Appropriately label the data set with descriptive activity names.
Collected all column names. Using gsub, clean up the column names and assigned proper names.
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
Using the aggregate function calculate the mean for each subject id and activity id and then write this tidy data set to a file. The same is uploaded to the github repository

