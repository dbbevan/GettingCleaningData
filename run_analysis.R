# Overview - Purpose & Goal
# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
# The goal is to prepare tidy data that can be used for later analysis. 
# 
# Source Data Used: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# This R script called run_analysis.R does the following:
#       1.Merges the training and the test sets to create one data set.
#       2.Extracts only the measurements on the mean and standard deviation for each measurement. 
#       3.Uses descriptive activity names to name the activities in the data set
#       4.Appropriately labels the data set with descriptive variable names. 
#       5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


# 1.Merges the training and the test sets to create one data set.
        # set my working directory
        setwd("G:/Projects/R_Workspace/Coursera/GettingDataCourse/Course Project/UCI HAR Dataset")
        
        # Get/Append X data sets
        x_train_data <- read.table("train/X_train.txt")
        x_test_data <- read.table("test/X_test.txt")
        X_DataSet <- rbind(x_train_data, x_test_data)
        # X_DataSet contains 10299 Observations of 561 variables...cool beans

        # Get/Append y data sets
        y_train_data <- read.table("train/y_train.txt")
        y_test_data <- read.table("test/y_test.txt")
        Y_DataSet <- rbind(y_train_data, y_test_data)
        # Y_DataSet contains 10299 Observations of 1 variables...cool beans
        
        # Get/Append subject data sets
        subject_train_data <- read.table("train/subject_train.txt")
        subject_test_data <- read.table("test/subject_test.txt")
        Subject_DataSet <- rbind(subject_train_data, subject_test_data)
        # Subject_DataSet contains 10299 Observations of 1 variables...cool beans
        
# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
        # -----------------------------------------------------
        # Get the features from features.txt file  
        all_features <- read.table("features.txt")
        
        # -----------------------------------------------------
        # Extract the mean and standard deviation key columns index numbers from the feature file... 
        # These will allow us to subset the columns into a smaller more workable file set.
        keycolumns_features <- grep("-mean\\(\\)|-std\\(\\)", all_features[, 2])
        #  Column idexes of features having mean and standard in them
        #  1   2   3   4   5   6  41  42  43  44  45  46  81  82  83  84  85  86 
        #  121 122 123 124 125 126 161 162 163 164 165 166 201 202 214 215 227 228 240
        #  241 253 254 266 267 268 269 270 271 345 346 347 348 349 350 424 425 426 427 
        #  428 429 503 504 516 517 529 530 542 543
        
        # -----------------------------------------------------
        # Create a data.frame subset with only columns of mean and standard measurements
        X_DataSet_Subset <- X_DataSet[,keycolumns_features] # ; class(X_DataSet_Subset); head(X_DataSet_Subset)
        # X_DataSet_Subset contains 10299 Observations of 66 variables... much better than cool beans
        
        # -----------------------------------------------------
        # Add Header Column Labels (clean Headers up... get rid of parentheses, etc... while updating)
        names(X_DataSet_Subset) <- gsub("\\(|\\)", "", tolower(all_features[keycolumns_features, 2]))
        # Validation test code to verify it looks cool... by bringing back on observation ... looks good. 
        head(X_DataSet_Subset,1)
        

# 3.Uses descriptive activity names to name the activities in the data set
        # -----------------------------------------------------
        # Get the activity lables from activity_labels.txt file  
        activities_labels <- read.table("activity_labels.txt")
        
        # Make labels suitable and standardized by setting to lowercase, removing underscores...
        activities_labels[, 2] = gsub("_", "", tolower(as.character(activities_labels[, 2])))
        
        # Update Y_DataSet to meaning descriptive activity names for each observation.
        Y_DataSet[,1] = activities_labels[Y_DataSet[,1], 2]
      
        # Set Y_DataSet single column header name to activity
        names(Y_DataSet) <- "activity"
        
        # Validation test code to verify it looks cool... by bringing back on observation ... looks good. 
        head(Y_DataSet)

# 4.Appropriately labels the data set with descriptive variable names. 
   # Sub-step 4a - Add meaningful label to Subject data set        
        names(Subject_DataSet) <- "participant"
        # TEST SCRIPT: One last validation check that all columns have descriptive variable names... looks swell. Gee Golly Willigers...
        # head(Subject_DataSet,1) ; head(Y_DataSet,1) ; head(X_DataSet_Subset,1)
        
   # Sub-step 4b - Bring this bad boy together into a single master file       
        Master_DataSet_Subset <- cbind(Subject_DataSet, Y_DataSet, X_DataSet_Subset)
        # TEST SCRIPT: One last validation check that all columns have descriptive variable names... looks swell. Gee Golly Willigers...
        # head(Master_DataSet_Subset,1)
        
   # Sub-step 4c - Save this single master file to the harddrive to preserve and present my competency for all to see. ROFLOL
        write.table(Master_DataSet_Subset, "Master_DataSet_Subset.txt")

# 5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
    # Setup the variables....
        numParticipants = length(unique(Subject_DataSet)[,1]) # 30 PIDs
        uniqueParticipantIDs = unique(Subject_DataSet)[,1] # a list of Participant IDs
        numActivities = length(activities_labels[,1]) # 6 Activities
        numCols = dim(Master_DataSet_Subset)[2] # 68 Columns
        # Down and Dirty Initialization of the "output" data.frame structure leveraging existing Master_DataSet_Subset
        # which gives me the 68 columns with header names and rows ready to populate.
        output = Master_DataSet_Subset[1:(numParticipants*numActivities), ] # 
        # dim(output) check it out... [1] 180  68
           
        # Iterate over records to build out second tidy data set 
        row = 1 # initialize start row
        # setup for loop... if more time would experiment with apply options though this seems pretty straight forward
        for (p in 1:numParticipants) {  # loop through participants
                for (a in 1:numActivities) { # for loop through each activity for participant
                        output[row, 1] = uniqueParticipantIDs[p] # Assign PID to by updating existing row-column in output
                        output[row, 2] = activities_labels[a, 2] # Assign Acitivity Name to by updating existing row-column in output
                        CriteriaFilter <- Master_DataSet_Subset$participant==p & Master_DataSet_Subset$activity==activities_labels[a, 2] # Apply Filters for Activity to Participant
                        temp <- Master_DataSet_Subset[CriteriaFilter, ] # Get DataSet for single Activity for a specific Participant
                        output[row, 3:numCols] <- colMeans(temp[, 3:numCols]) # apply the colMeans function to columns 3 to 68 - then update output
                        row = row+1 # Advance to next row and loop until complete
                }
        }
        
        
        # Sub-step 4c - Save this single master file to the harddrive to preserve and present my competency for all to see. ROFLOL
         write.table(output, "Master_DataSet_Subset_with_Avgs_by_Activity_by_Participant.txt")
        
        
        # Some Test Harness Scripts

        MDS_Avg_by_Activity_Participant <- read.table("Master_DataSet_Subset_with_Avgs_by_Activity_by_Participant.txt")
        head(MDS_Avg_by_Activity_Participant,1)
        
