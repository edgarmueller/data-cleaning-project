library(dplyr)
library(data.table)

setwd("~/git/data-cleaning-project/UCI HAR Dataset")

concat = function(trainFile, testFile) {
  trainData = fread(file.path("train", trainFile))
  testData  = fread(file.path("test",  testFile))
  rbind(trainData, testData)
}

mapActivityIdToLabel = function(activityIds) {
  activityLabels = fread("activity_labels.txt")
  colnames(activityLabels) = c("activityId", "activityLabel")
  x = vapply(activityIds, function(id)  subset(activityLabels, activityId == id, select = c("activityLabel")), list(1) )
  unlist(x)
}

readFeatureNames = function() {
  features = fread("features.txt")
  features$V2
}

filterByFeatures = function(data, featureRegex) {
  colsOfInterest = grep(featureRegex, colnames(data), value = TRUE)
  subset(data, select = colsOfInterest)
}

format = function(colNames) {
  replaceTokens = list(
    c("\\()",     ""),
    c("-std",     ".StdDev"), 
    c("-mean",    ".Mean"),
    c("BodyBody", "Body"),          
    c("Gyro",     "Gyroscope"),
    c("Acc",      "Accelerometer"),
    c("Mag",      "Magnitude"),
    c("^f",       "Freq."),
    c("^t",       "Time."),
    c("-X",       ".X"),
    c("-Y",       ".Y"),
    c("-Z",       ".Z")
  )
  
  replace = function(colname) {
    for (r in replaceTokens) { colname = gsub(r[1], r[2], colname) }
    colname
  }
  
  sapply(colNames, function(colname) replace(colname))
}

# Merge files from train and test data sets (1)
subjects             = concat("subject_train.txt", "subject_test.txt")
activities           = concat("y_train.txt", "y_test.txt")
data                 = concat("X_train.txt", "X_test.txt")

# Setting column names
colnames(subjects)   = c("Subject")
colnames(activities) = c("Activity")
colnames(data)       = readFeatureNames()

# Filter only std and mean columns (2)
data = filterByFeatures(data, "std|mean")

# Set descriptive column names for data (4)
colnames(data) = format(colnames(data))

# Merge data sets and tidy data
allData = cbind(cbind(subjects, activities), data)
tidyData = allData %>%
  group_by(Subject, Activity) %>%
  summarize_each(c("mean"))

# Map activity IDs to respective labels (3)
tidyData$Activity = mapActivityIdToLabel(tidyData$Activity)

write.table(tidyData, "tidy-data.txt", row.names = FALSE, quote = FALSE)