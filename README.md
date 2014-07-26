GettingCleaningData
===================

Getting &amp; Cleaning Data Course Project


### Running the script
  - Clone this repository
  - Get the project zip containing the Data and Reference files: [getdata_projectfiles_UCI HAR Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 
  - Copy and Extract to a location on your computer where you desire
  - Change current directory to the `UCI HAR Dataset` folder.
  - Set r working directory. 
  - Run `Rscript <path to>/run_analysis.R`
  - The two tidy datasets will be created in the current directory as:
      - Master_DataSet_Subset.txt
      - Master_DataSet_Subset_with_Avgs_by_Activity_by_Participant.txt
  - Code book for the tidy dataset is available [here](CodeBook.md)

### Additional Notes

- The resulting outputted data sets have columns listed as Participant vs. Subject. Participant and Subject are the same.  
- The training and test data are available in folders named `test` and `train` respectively.
- Data Set files are as follows:
    - Measurements are present in `X_<dataset>.txt` file
        - Columns subject to focus are as follows:
          - Columns containing means data will look like `...mean()`
          - Columns  standard deviations will look like `...std()` 
    - Subject information is present in `subject_<dataset>.txt` file - The are 30 subjects in this experiment
    - Activity codes are present in `y_<dataset>.txt` file - There are 6 activities
    - All activity codes and their labels are in a file named `activity_labels.txt`.
    - Names of all measurements taken are present in file `features.txt` 



