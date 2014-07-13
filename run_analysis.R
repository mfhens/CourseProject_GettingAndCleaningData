run_analysis <- function()
{
  require(plyr)
  
  # Read column names from feature file
  # And Extract only those containing mean and standard-values
  features <- read.table(".\\UCI HAR Dataset\\features.txt")
  mean_std_columns <- make_mean_std_columns(features)
  
  # Clean test data 
  test_data <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt")[, mean_std_columns]
  names(test_data) <- features[mean_std_columns,2]
  test_labels <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt")
  names(test_labels) <- c("Activity")
  test_subjects <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")
  names(test_subjects) <- c("Subject")
  test_data <- cbind(test_subjects, test_labels, test_data)
  
  # Clean training data
  train_data <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt")[, mean_std_columns]
  names(train_data) <- features[mean_std_columns,2]
  train_labels <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt")
  names(train_labels) <- c("Activity")
  train_subjects <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt")
  names(train_subjects) <- c("Subject")
  train_data <- cbind(train_subjects, train_labels, train_data)
  
  # Merge into one data set
  complete_data_set <- rbind(test_data, train_data)
  
  tidy_data_set <- ddply(complete_data_set, .(Subject, Activity), colMeans)
  tidy_data_set$Activity <-  factor(tidy_data_set$Activity)
  levels(tidy_data_set$Activity) <- c( "WALKING", 
                                       "WALKING_UPSTAIRS",
                                       "WALKING_DOWNSTAIRS",
                                       "SITTING",
                                       "STANDING",
                                       "LAYING")
  
  tidy_data_set
}

make_mean_std_columns <- function(features) {
  columns <- c(grep("mean()", features[,2]), grep("std()", features[,2]))
  columns <- columns[order(columns)]
  columns
}