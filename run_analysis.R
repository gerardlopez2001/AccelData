# run_analysis.R


# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with 
#         the average of each variable for each activity and each subject.


# 0.0 setup

library(dplyr)

# 0.1  Read in all CSV files
activity_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")

subject_test <- read.table(".\\test\\subject_test.txt")
y_test <- read.table(".\\test\\Y_test.txt")
x_test <- read.table(".\\test\\X_test.txt")

subject_train <- read.table(".\\train\\subject_train.txt")
y_train <- read.table(".\\train\\Y_train.txt")
x_train <- read.table(".\\train\\X_train.txt")

#0.2 Set column names
colnames(activity_labels) <- c("actCode", "activity")

#0.3 use features.txt as variable names for X_train and X_test data

#convert to vector
temp <- as.vector(features[,2])

#remove non-letter characters
temp <- gsub("\\(", "", temp)
temp <- gsub(")", "", temp)
temp <- gsub("\\,", "", temp)
temp <- gsub("\\-", "", temp)

#add variable names to x_train and x_test
colnames(x_train) <- temp
colnames(x_test) <- temp
rm(temp)

# 0.4  column names for subject_train & subject_test
colnames(subject_test) <- c("subjectId")
colnames(subject_train) <- c("subjectId")

# 0.5 column names for y_train & y_test
colnames(y_test) <- c("actCode")
colnames(y_train) <- c("actCode")

###########################################################################################
# 1. Merges the training and the test sets to create one data set.

#assemble train and test data frames separately using columns from subject, y and x frames
train <-cbind(subject_train, y_train, x_train)
test <- cbind(subject_test, y_test, x_test)

# assemble all data from train and test with rows from train and test frames
alldata <- rbind(train, test)


###########################################################################################
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
meanstddata <- alldata[, c("subjectId", "actCode"  
                           ,(grep("(mean[XxYyZz])|(std[XxYyZz])", names(alldata), value=TRUE)))]

###########################################################################################
# 3. Uses descriptive activity names to name the activities in the data set
meanstddataact <- merge(meanstddata, activity_labels, x.by = "actCode", y.by = "actCode")
meanstddataact <- select(meanstddataact, -actCode)


###########################################################################################
# 4. Appropriately labels the data set with descriptive variable names.

# already accomplished with #3 and #0


###########################################################################################
# 5. From the data set in step 4, creates a second, independent tidy data set with 
#         the average of each variable for each activity and each subject.

mydf <- tbl_df(meanstddataact)
tidy <- mydf %>%
        group_by(subjectId, activity) %>%
        summarise_each(funs(mean))

###########################################################################################
# Please upload your data set as a txt file created with write.table() using row.name=FALSE 
# (do not cut and paste a dataset directly into the text box, as this may cause errors saving
# your submission).

write.table(tidy, file = "tidydata.txt", row.name=FALSE)  

###########################################################################################
###########################################################################################  
