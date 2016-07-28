This project (Getting and Cleaning Data Course Project) includes the following files:
=========================================
  #-'README.md'
  #-'CodeBook.md': 
  #-'run_analysis.R'
  #-'tidyData.txt': 

##The R-function 'run_analysis.R' works as follows:

##0.Get the data:
    #Create a folder 'data' if it doesn't exist already, downloads the zipped file in the "data" folder.
    #Unzip the file
    #Unzipped files are in the folder "UCI HAR Dataset". Get the path of the folder "UCI HAR Dataset"

##0.Read data from  the  targeted files
    #Get the big picture of the structure of the data frame that will be used in this project.**
    #Values of Varible `Activity` consist of  data from  "Y_train.txt" and  "Y_test.txt"   
    #values of Varible `Subject` consist of  data from "subject_train.txt" and  subject_test.txt" 
    #Values of Varibles `Features` consist of  data from "X_train.txt" and  "X_test.txt" 
    #Names of Varibles `Features` come from "features.txt"
    #levels of Varible `Activity` come from "activity_labels.txt"
    #So we will use  `Activity`, `Subject` and `Features` as part of descriptive variable names for data in data frame.

    #Read data from the files into the variables
       #Read the Activity files
       #Read the Subject files
       #Read the Features files

##1.Merge the training and the test sets to create one data set

    #Concatenate the data tables by rows
    #set names to variables
    #Merge columns to get the data from "Data" for all three data

##2.Extract only the measurements on the mean and standard deviation for each measurement

    #Subset Name of Features by measurements on the mean and standard deviation
    #i.e. taken Names of Features with "mean()" or "std()"
    #Subset the data frame "Data" by selected names of Features

##3.Use descriptive activity names to name the activities in the data set
    #Read descriptive activity names from "activity_labels.txt"
    #Factorize variable "activity" in the data frame "Data" using descriptive activity names

##4.Appropriately labels the data set with descriptive variable names
    #prefix t is replaced by time
    #prefix f is replaced by frequency
    #Acc is replaced by Accelerometer
    #Gyro is replaced by Gyroscope
    #Mag is replaced by Magnitude
    #BodyBody is replaced by Body

##5.Create a second, independent tidy data set 'tidydata.txt' and output it
