
# Overview - Purpose & Goal
### The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
### The goal is to prepare tidy data that can be used for later analysis. 
 
### Source Data Used: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 
### This R script called run_analysis.R does the following:
###     1.Merges the training and the test sets to create one data set.
###     2.Extracts only the measurements on the mean and standard deviation for each measurement. 
###       3.Uses descriptive activity names to name the activities in the data set
###       4.Appropriately labels the data set with descriptive variable names. 
###       5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 




## the data
- Source Location: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
- For setup instructions - refer to readme.md
- Additional Information on the genesis of this project: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones- 

## the variables
activity_labels.txt - Contains list of activities participants performed...
  1 WALKING
  2 WALKING_UPSTAIRS
  3 WALKING_DOWNSTAIRS
  4 SITTING
  5 STANDING
  6 LAYING

features.txt (features_info.txt contains descriptions of each column feature within the training and test dataset files)
  - Contains complete list of features associated with the 561 measurements observation... 
  - for this analysis our focus was only on mean and standard deviation of which only 66 features were used.

subject_test.txt contains unique instances of a subject(participant) associated to a single descrete activity
X_test.txt - This files contains observations with their corresponding 561 measures respectively 
y_test.txt - This file (similar to the subject_test.txt) contains unique instances of a single descrete activity per observation of a subject(participant)

The following output files contain the following:
Master_DataSet_Subset: A Tidy Data Set of the desire data for Means and Standards of Deviation for the 10299 Observations and 68 Variables... of which include the Subjects(Participants) and Activity Columns. 
Master_DataSet_Subset_with_Avgs_by_Activity_by_Participant.txt - This file contains the calculated Mean values as refered to as an independent tidy data set with the average of each measurement for each activity and each subject


## transformations or work that you performed to clean up the data 

# This R script called run_analysis.R does the following:
#       1.Merges the training and the test sets to create one data set.
            1) My first action is to merge training and test datasets  for each x, y and subject dataset into three respecive files sets.  X_DataSet, Y_DataSet, Subject_DataSet
#       2.Extracts only the measurements on the mean and standard deviation for each measurement. 
            2) In this step I filter out columns in my X_DataSet to only contain those for 
            Create a data.frame subset with only columns of mean and standard measurements
            Add Header Column Labels (clean Headers up... get rid of parentheses, etc... while updating)
            Write some validation test code to verify it looks good
#       3.Uses descriptive activity names to name the activities in the data set
            3)Get the activity lables from activity_labels.txt file 
            Make labels suitable and standardized by setting to lowercase, removing underscores
            Update Y_DataSet to meaning descriptive activity names for each observation
            Set Y_DataSet single column header name to activity
            
#       4.Appropriately labels the data set with descriptive variable names. 
            4) Sub-step 4a - Add meaningful label to Subject data set  
            Sub-step 4b - Bring this bad boy together into a single master file Master_DataSet_Subset.txt
            TEST SCRIPT: One last validation check that all columns have descriptive variable names... s...
             Sub-step 4c - Save this single master file to the harddrive for future analysis
#       5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
            5) I use the Master_DataSet_Subset I created in the previous step
            I calculate the number of Participants(30) times the observations (6) this gives me 180 expected rows across 66 columns that will be need in the final report output. 
            I create a for loop that iterates over Master_DataSet_Subset for each participants set of records for each of their respective activites... as we iterate over the data set I update/build out my new data.frame that will contain 68 columns...the first column contains Participant/Subject IDs, Column 2 contains the activites prformed and the remaining 66 columns contain the rolled up colMean() calculates per each Participant -> Activity... Each Particpant will have 6 rows listing a unique activity rollup they performed.
            
            This looks something like...
            
            Participant    Activity Col1  Col2 ....
            1              Walking      34343 34343 ...
            1              Standing

`````
