## Cleaning and reshaping of Samsung gyroscope data: run_analysis.R

### Signature
data.frame run_analytics ()

### Pre-conditions
- R Working Directory must contain a folder named "UCI HAR Dataset"
- That folder has two sub-directories named "test" and "train", and must contain the file "features.txt"
- The "test" and "train"-folders contain the files "X_[folder].txt", "y_[folder].txt", "subject_[folder].txt"

### Data Cleaning
1. Load the file "feature.txt" containing the full list of column names for the data files
2. Filter the column names from "feature.txt" for those containing only the strings "mean()" or "std()", to only get the data olumns containing data on the mean and standard deviation for each variable. For easier code readability, this is done in a local function named "make_mean_std_columns". Notice that "make_mean_std_columns" keeps the columns in the original order.
3. For the test and training data execute
3.1.  Load the measurement data and filter it on the mean and standard deviation columns
3.2.  As the data file does not contain a header, the automatically generated column names are replaced by the column names from "feature.txt"
3.3.  Load activity data, and name the column appropriatly "Activity". For now this column is Numeric, with values from 1-6
3.4.  Load data on which test subject the measurements came from. Name the column appropriatly "Subject". The column contains numeric values.
3.5.  Merge all three data frames into one common data frame, with the subject and activity columns first
4. Combine the augmented test and training-data into one common data frame (complete_data_set)

### Data Reshaping
1. Using the plyr-package, calculate the column means grouped by subject and activity on the complete_data_set
2. The result is stored in the tidy_data_set, but the column Activity still has numeric values, which in one last cleaning step are replaced by factors based on the content of the "activity.txt" from the Samsung data
3.  the tidy_data-set is returned
