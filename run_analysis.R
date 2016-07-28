##0.Get the data

#Download the file and put the data in the "data" folder
if(!file.exists("./data")){dir.create("./data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/Dataset.zip")

#Unzip the file
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")

#Unzipped files are in the folder "UCI HAR Dataset". Get the path of the folder "UCI HAR Dataset"
path_rf<-file.path("./data", "UCI HAR Dataset")
#files<-list.files(path_rf, recursive = TRUE)


##0.Read data from  the  targeted files
#Get the big picture of the structure of the data frame that will be used in this project.**
#Values of Varible `Activity` consist of  data from  "Y_train.txt" and  "Y_test.txt"   
#values of Varible `Subject` consist of  data from "subject_train.txt" and  subject_test.txt" 
# Values of Varibles `Features` consist of  data from "X_train.txt" and  "X_test.txt" 
#Names of Varibles `Features` come from "features.txt"
#levels of Varible `Activity` come from "activity_labels.txt"
# So we will use  `Activity`, `Subject` and `Features` as part of descriptive variable names for data in data frame. 

#Read data from the files into the variables

#Read the Activity files
dataActivityTrain<-read.table(file.path(path_rf, "train", "Y_train.txt"), header = FALSE)
dataActivityTest<-read.table(file.path(path_rf, "test", "Y_test.txt"), header = FALSE)

#Read the Subject files
dataSubjectTrain<-read.table(file.path(path_rf, "train", "subject_train.txt"), header = FALSE)
dataSubjectTest<-read.table(file.path(path_rf, "test", "subject_test.txt"), header = FALSE)

#Read the Features files
dataFeaturesTrain<-read.table(file.path(path_rf, "train", "X_train.txt"), header = FALSE)
dataFeaturesTest<-read.table(file.path(path_rf, "test", "X_test.txt"), header = FALSE)


##1.Merge the training and the test sets to create one data set

#Concatenate the data tables by rows
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataSubject<- rbind(dataSubjectTrain, dataSubjectTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)

#set names to variables
names(dataActivity)<- c("activity")
names(dataSubject)<- c("subject")
dataFeaturesNames<-read.table(file.path(path_rf, "features.txt"), header = FALSE)
names(dataFeatures)<- dataFeaturesNames$V2

#Merge columns to get the data from "Data" for all three data
Data<- cbind(dataFeatures, dataActivity, dataSubject)


##2.Extract only the measurements on the mean and standard deviation for each measurement

#Subset Name of Features by measurements on the mean and standard deviation
#i.e. taken Names of Features with "mean()" or "std()"

subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

#Subset the data frame "Data" by selected names of Features
selectedNames<-c(as.character(subdataFeaturesNames), "activity", "subject")
Data<- subset(Data, select = selectedNames)


##3.Use descriptive activity names to name the activities in the data set

#Read descriptive activity names from "activity_labels.txt"
activityLabels<- read.table(file.path(path_rf, "activity_labels.txt"), header = FALSE)

#Factorize variable "activity" in the data frame "Data" using descriptive activity names
Data$activity<- factor(Data$activity, labels = as.character(activityLabels$V2))


##4.Appropriately labels the data set with descriptive variable names

#prefix t is replaced by time
#prefix f is replaced by frequency
#Acc is replaced by Accelerometer
#Gyro is replaced by Gyroscope
#Mag is replaced by Magnitude
#BodyBody is replaced by Body
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))


##5.Create a second, independent tidy data set and output it
library(plyr)
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$activity, Data2$subject),]
write.table(Data2, file = "tidydata.txt", row.names = FALSE)



















