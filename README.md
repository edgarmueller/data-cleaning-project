# Getting and Cleaning Data - Project

This README describes the analysis used within the project assignment to create a tidy data set.

## 0. Prerequisites
- The script makes use of the `dplyr` and the `data.table` package, so if any of these packages
  is missing, one needs to install them first
- The script expects to be executed from within the extracted contents of the UCI HAR Dataset folder. 
  When running the script one likely needs to adapter the working directory via `setwd`

## 1. Execution flow
The script roughly followed the steps described in the project assignment but does not follow them strictly.


### 1.1 Merging data frames
The script first unifies the training and test data creating variables `subjects`, `activities` and 
`data`. It makes use of a custom `concat` helper function which reads the respective training and test files
and `rbind`s them to create a unified data frame for each data set.

### 1.2 Setting column names
Next, the script sets the column names for the merged data frames. While this is easy for the `subjects` 
and the `activites` dataframe, it makes use of a helper function `readFeaturesNames`. This small helper 
function reads the `features.txt` and extracts the feature names.

### 1.3 Filtering features
Since we are only interested in the standard deviation and the mean values of each variable, we filter
the data set by making use of a regex `(std|mean)` and another helper function `filterByFeatures`. 
This function first `grep`s the column names of the data set for the passed regex and then filters 
the data set via the `subset` function.

### 1.4 Setting descriptive column names
While the `data` data frame already has column names set, they might appear quite cryptic.
Hence we format each column name by calling the `format` helper function and setting the column
names via `colnames` again. The `format` function goes through all column names and applies a 
locally scoped `replace` function to each column. The `replace` function uses `gsub` to replace 
predefined tokens with more descriptive names.

### 1.5 Merging and tidying data set
After having formatted the `data` data frame, we can merge all data sets into a single 
one via `cbind` and aggregate the data as required by the project assignemnt instructions.
Aggregation is handled by `dplyr` package: we first `group_by` the `Subject` and the `Activity`
columns and then `summarize_each` variables by calling `mean`.

### 1.6 Set descriptive activity labels
As we used the Activity ID for aggregating the data the `Activity` column still
features numeric values instead of labels as requested in the projet assignement.
We therefore read the `activity_labels.txt` file in the `mapActivityIdToLabel` helper function
and replace all numeric values with the respective activity label.

### 1.7 Writing the tidy data set
Finally, we can write the tidied data set into a new file, which we call `tidy-data.txt` and 
is written into the current directory.

# 2. Usage instructions
1. Clone this repository 
2. [Download](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) the UCI Har
dataset and extract it within the clone of the repository
3. Make sure the `dplyr` and `data.table` packages are installed
4. Update the `setwd` path with the `run_analysis.R` script
5. Execute the script
