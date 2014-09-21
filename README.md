#Acceleration Data Tidy Dataset
=========

##Intro

The purpose of this project is to process data collected from a study that used Samsung Galaxy S II smart phones to measure subjects' movements during set activities. 

Study took 30 subjects and measured movements while performing simple activities.  Data from 70% of the data was separated into a training set and 30% was separated into a test set.

The original data was collected by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto from the Smartlab - Non Linear Complex Systems Laboratory in DITEN - UniversitÃ  degli Studi di Genova, Genoa, Italy. 

The original data can be found at this website: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Requirements

   -  R version 3.1.1 installed
   
   -  R package dply version 0.2	 

## Inputs

   -  run_analysis.R
   
   -  getdata-projectfiles-UCI HAR Dataset.zip file unzipped to working directory
   
	   -  activity_labels.txt in working directory from above zip file
	   
	   -  features.txt in working directory from above zip file
	   
	   -  /train/subject_train.txt in working directory from above zip file
	   
	   -  /train/X_train.txt in working directory from above zip file
	   
	   -  /train/y_train.txt in working directory from above zip file
	   
	   -  /test/subject_test.txt in working directory from above zip file
	   
	   -  /test/X_test.txt in working directory from above zip file
	   
	   -  /test/y_test.txt in working directory from above zip file
   

## Outputs

   -  tidydata.txt data file written to working directory
   
      - *summary*
	  
	     - This data file is a transformed version of the original data.  It joins together all of the data from the original data files and gives them human readable variable names. It then takes all measurements and groups them by subject and by activity performed.  It, finally, provides averages for all measurements that involve means or standard deviations. 

      - *file format*
	  
	     - The data is in a text file.  The first line includes headers with column names.  Data is separated by space as a separator.  Each row is an observation. Character text is enclosed with quotation marks. 
   
      - *rows*
	  
	     - each row of dataset refers to the measurements of one subject during 1 of 6 set activies
		 
	     - there are 30 subjects in the dataset
		 
	     - there are 6 different activities performed
		 
	     - there are 180 rows indicating combinations of each subject for each activity

	 - *columns*
	 
	    - there are 50 columns in the dataset
	    -  please refer to AccelData_Codebook.md for further description of variables.
		
## Data structure

- The data structure of the data from the input data files is as follows:

   - the subject_train and subject_text data files are identical in structure and include the unique identifying code for the subject that performed during each measurement.  The test data file contains 2947 rows and the train data file contains 7352 rows.

   - the y_test and y_train data files are identical in structure and include a code for the activity that the subject performed during each measurement.  There is only one column containing this code, and no variable name.  The test data file contains 2947 rows and the train data file contains 7352 rows.

   - the X_test and X_train data sets are identical in structure and include all measurements from smart phone.  There are 561 columns, but no variable names included with these data files. The test data file contains 2947 rows and the train data file contains 7352 rows.

   - the features.txt contains the variable names for the x_test and x_train data files.  There are 561 rows, each referring to the 561 measurements from the x_test and x_train files. There is only one column and no variable name.

   - the activity_labels data file contains a list of all 6 types of activities performed and their corresponding codes.  There are two columns (activity code number and text description) and six rows in the data file (one for each of the 6 types).  Neither column has a variable name.

- **Note**

   - Without unique identifiers in the subject, y and x data files, the row position of each measurement was used to link data files together.  This means that the 1st row of the subject_train was linked to the 1st row of y_train and x_train.  The second row of subject_train was linked to the second row of y_train and x_train.  And so on. Same for the test files.  This comes from the original study documentation.

## Process

The following process was used to transform the original raw data to its final output as tidydata.txt:

1. all data was read into data frames

1. simple human readable variable names were chosen for all data frames except features, x_test and x_train

1. for the features data frame, non-letter characters such as "(" , ")", "," and "-" were stripped from the data to provide clearer data.

1. for x_test and x_train, the variable names were derived from the now simplified features data frame.

1. the subject_train, y_train and x_train data frames were bound by column to form new train data frame
 
1. the subject_test, y_test and x_test data frames were bound by column to form new test data frame

1. the train and test data frames were row bound together to form a new data frame

1. columns were cut from the new data frame so that only the subjectId, the activity code, and columns that ended in meanX, meanY, meanZ, stdX, stdY and stdZ (as determined by grep("(mean[XxYyZz])|(std[XxYyZz])" remained.

1.  the text from the activity_labels data frame were merged into the data to provide the text description of the activity being performed.  The activity code column was subsequently dropped form the data frame.

1.  using the dply package the data was grouped by subject id and activity so that each row was a unique combination of the two.  It was then summarized and a mean calculated for all columns (except subjectId and activity)

1. the final data frame was written to a text file in the working directory.


## Credits

*Author*: Gerard Lopez
*Date*: 2014-09-22


