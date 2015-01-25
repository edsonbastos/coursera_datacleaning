# Descritption of the routine
1 - Clean the workspace, loadi required libraries and set options

2 - Download the zip file and unzip it

3 - List (file.list) the files that were obtained in step 2

4 - Select the files that contain in the Dataset folder and the X, y, subjects files for the training and testing samples

5 - Import the files in step 4 to R workspace in the for of a list

6 - Atributes the names for each file in the list mentioned in step 5

7 - Create a data frame (tidy.data) with mean or standard deviations for all the variables

8 - Merges the training and testing data

9 - Include the control variables such as the type of sample, subject and activity

10 - Uses descriptive activity names to name the activities in the data set

11 - Reshape with melt the data set controling by sample, subject and activity

12 - Creat a column that identify in the reshaped data frame which rows refers to means and standard deviations

13 - Reshape the data.frame (tidy.data.average) with dcast so that mean and standard deviations are columns and the entries of the table represents the averages of that variables controling by subject and activity

14 - Appropriately labels the data set with descriptive variable namescreate a independent tidy data set with the average of each variable, activity and subject

15 - Save the data in step 14 in a text file format

# Cookbook
The data set that was submmited is the data.frame named tidy.data.average
The columns in the tidy.data.average data frame are:

- variable: type of variables measured

- subject: individuals that were subjected to the experience

- activity: type of activity

- mean: averages of the mean

-- std: averages of the standard deviation
