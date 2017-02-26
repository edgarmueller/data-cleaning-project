# Code Book
This code book describes all variables in the `tidy-data.txt` file and primarly 
serves as an additional reference to the existing code book of the UCI HAR Dataset, which 
can be downloaded from 
[here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

In particular, one should have a look at the `README.txt` and the `features_info.txt` files where
general information about the data set as well as 
additional variable-specific information like measurement units can be found.

The tidied data set described in this codebook features a total of 81 variables: 
`Subject`, `Activity` as well as 79 variables which describe any activity.

## Subject
The Subject is just a unique numeric identifier that identifies each subject within the data set.

## Activity
In contrast to the original data set, the numeric values identifying each activity have been 
replaced with the respective labels from the `activity_labels.txt` file. This file assigns
each activity ID a label.

## Activity description variables 
Variables in this data set only feature standard deviation and mean measurement of the 
UCI HAR data set. 
For readability reasons, variable names have been sligthly changed and follow the given scheme:

`<Domain>.<DeviceVariable>.<Measurement>[.<Axis>]`

### Domain
There are two categories of variables: time-based ones and frequency-based ones.
All time-based variables are prefixed with `Time` while variables in the frequency domain are prefixed with `Freq`.

### DeviceVariable
The `DeviceVariable` fragment describes a device measurement, that is, either an Accelerometer or a Gyropscope.
These different measurements can be categorized into:
- BodyAccelerometer
- BodyAccelerometerJerk
- BodyAccelerometerMagnitude
- BodyAccelerometerJerkMagnitude
- GravityAccelerometer
- GravityAccelerometerMagnitude
- BodyGyroscope
- BodyGyroscopeJerk
- BodyGyroscopeMagnitude
- BodyGyroscopeJerkMagnitude

### Measurement
As already described, in this data set we are only interested in the standard deviation and the mean of each variable.
Hence, this fragment part has only two possible values, `StdDev` and `Mean`.

### Axis
For variables where measurements have been tracked for each axis separately, the variables have been suffixed 
with the respective axis `X`, `Y` or `Z`.

