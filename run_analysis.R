#clean workspace
rm(list = ls())

#load the libraries and set options
library(reshape2)
options(stringsAsFactors = FALSE)

#dowload the dataset file
fileName         <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileName, destfile = "Dataset.zip")

#unzip the zip file
file.description <- list.files(pattern = "zip", full.names = TRUE)
file.list        <- unzip(zipfile = file.description, overwrite = TRUE)

#list of files
file.list        <- unzip(zipfile = file.description, list = TRUE)

#select the files of interest that have txt format
files.names  <- file.list$Name[grep("(Dataset|train|test)[/][^/]+([.]txt)$",file.list$Name)]
files.names  <- files.names[-grep("(README)|(info)",files.names)]
  
#import the selected files to R in a list
files        <- lapply(files.names, read.table)
  
#name each list entry
names(files) <- gsub(paste0("([.]txt)"),"",regmatches(files.names,regexpr("[^/]+[t]$",files.names)))
rm(file.list,files.names,file.description)

# Extracts only the measurements on the mean and standard deviation for each measurement. ###########
mean.std            <- grep("(mean|std).[)]",files$features[,2])

# Merges the training and the test sets to create one data set. #####################################
tidy.data           <- rbind(files$X_train,files$X_test)
tidy.data           <- tidy.data[,mean.std]
names(tidy.data)    <- files$features[mean.std,2]
rm(mean.std)

#create the control variables
tidy.data$sample     <- c(rep("train",nrow(files$X_train)),rep("test",nrow(files$X_test)))
tidy.data$subject    <- c(files$subject_train[[1]],files$subject_test[[1]])
tidy.data$activity   <- c(files$y_train[[1]],files$y_test[[1]])

# 3 - Uses descriptive activity names to name the activities in the data set
tidy.data <- merge(x = tidy.data, y = files$activity_labels, by.x = "activity", by.y = "V1")
tidy.data$activity   <- tidy.data$V2
tidy.data$V2         <- NULL

#reshape with melt with id equal to control
controls             <- c("sample","subject","activity")
tidy.data            <- melt(tidy.data, id = controls, measure.vars = setdiff(names(tidy.data),controls))
rm(controls)

#create two columns (one for mean the other for std)
tidy.data$stats      <- NA
tidy.data$stats[grep("mean",tidy.data$variable)] <- "mean" 
tidy.data$stats[grep("std",tidy.data$variable)] <- "std"

# Appropriately labels the data set with descriptive variable names #################################
tidy.data$variable   <- gsub("[-](mean|std).[)]","", tidy.data$variable)

# create a independent tidy data set with the average of each variable, activity and subject ########
#average (of means and stds) for each subject, activity and vaiable
tidy.data.average    <- dcast(tidy.data, variable + subject + activity ~ stats, mean, value.var = "value")
write.table(tidy.data.average, file = "tidy_data_average.txt", row.name=FALSE)
