# Code Book for Class Project in Getting and Cleaning Data Course, February 2015
Rick Gilbert

## Overview
This codebook describes the variables associated with a "tidy data set" class project based on the **Human Activity Recognition Using Smartphones Data Set** in the UCI Machine Learning repository.  For more information not described here and links to the data used in the repository,  please see the links in the **README.md** file that is part of this class project repo.

## Original Data 
(from the repo web site, http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
The experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## The Processing For This Project

### Extraction
Filenames used were associated with **chr** vectors as follows:
```
trnfile <- "UCI HAR Dataset/train/X_train.txt"        ## 7352 observations x 561 measures, no row or col labels
testfile <- "UCI HAR Dataset/test/X_test.txt"         ## 2947 observations x 561 measures, no row or col labels
testlblfile <- "UCI HAR Dataset/test/y_test.txt"      ## activity codes for the 2947 test observations
trainlblfile <- "UCI HAR Dataset/train/y_train.txt"   ## activity codes for the 7352 training observations
trainsubjfile <- "UCI HAR Dataset/train/subject_train.txt" ## subject codes for the 7352 training observations
testsubjfile <- "UCI HAR Dataset/test/subject_test.txt"    ## subject codes for the 2947 training observations
actlblfile <- "UCI HAR Dataset/activity_labels.txt"        ## descriptive names for each of the six activity codes
featuresfile <- "UCI HAR Dataset/features.txt"             ## descriptive names for each of 561 measurement features
```
Data were read into R using read.csv
#### dataframes
- **xtraindata** and  **xtestdata**  loaded from x_test.txt and x_train.txt.  
- **tmp**                used twice to load the activity label column to xteat and xtrain
```
 	V1
1	5
2	5
3	5
4	5
5	5
6	5
7	5
8	5
9	5
10	5
```
- **xtest** and **xtrain**  loriginally loaded from X_train.txt data and X_test.txt and contain the encoded subject id's (1-30).  In a subsequent step, activity id's(1-6) and the xtest and xtrain columnse are added as columns to these two dataframes. 
```
  subject activity        V1          V2          V3
1        2        5 0.2571778 -0.02328523 -0.01465376
2        2        5 0.2860267 -0.01316336 -0.11908252
3        2        5 0.2754848 -0.02605042 -0.11815167
4        2        5 0.2702982 -0.03261387 -0.11752018
5        2        5 0.2748330 -0.02784779 -0.12952716
6        2        5 0.2792199 -0.01862040 -0.11390197
7        2        5 0.2797459 -0.01827103 -0.10399988
8        2        5 0.2746005 -0.02503513 -0.11683085
9        2        5 0.2725287 -0.02095401 -0.11447249
10       2        5 0.2757457 -0.01037199 -0.09977589
```
- **xfeatures**    loaded from the features file to label the measures columns in xtestdata and xtraindata
```
 	V1	V2	V3
1	1	tBodyAccmeanX	mean
2	2	tBodyAccmeanY	mean
3	3	tBodyAccmeanZ	mean
4	4	tBodyAccstdX	std
5	5	tBodyAccstdY	std
6	6	tBodyAccstdZ	std
7	7	tBodyAccmadX	Other
8	8	tBodyAccmadY	Other
9	9	tBodyAccmadZ	Other
```

- **xdata** is the composite of the **xtestdata** and **xtraindata** created using rbind, **tidyset** is the summarization output
- **xfeatures** and **keepFeat** have the same structure
```
 	row.names	V1	V2	V3
1	1	1	tBodyAccmeanX	mean
2	2	2	tBodyAccmeanY	mean
3	3	3	tBodyAccmeanZ	mean
4	4	4	tBodyAccstdX	std
5	5	5	tBodyAccstdY	std
6	6	6	tBodyAccstdZ	std
7	41	41	tGravityAccmeanX	mean
8	42	42	tGravityAccmeanY	mean
```
- **xdata** and **tidyset** have the same structure.  xdata contains the extracted values from the data source.  Tidyset contains the average for each measure/feature, grouped by subject and activity using the aggregate function.
```
 	subject	activity	tBodyAccmeanX	tBodyAccmeanY	tBodyAccmeanZ
1	1	LAYING	0.2215982	-0.04051395	-0.1132036
2	2	LAYING	0.2813734	-0.01815874	-0.1072456
3	3	LAYING	0.2755169	-0.01895568	-0.1013005
4	4	LAYING	0.2635592	-0.01500318	-0.1106882
5	5	LAYING	0.2783343	-0.01830421	-0.1079376
6	6	LAYING	0.2486565	-0.01025292	-0.1331196
7	7	LAYING	0.2501767	-0.02044115	-0.1013610
8	8	LAYING	0.2612543	-0.02122817	-0.1022454
9	9	LAYING	0.2591955	-0.02052682	-0.1075497
10	10	LAYING	0.2802306	-0.02429448	-0.1171686
```

The measures (tBodyAccmeanX, etc.) in the original data set are all normalized unitless values.

## Code Description
The code is linear, without loops.  It is heavily commented.  No attempt has been made to optimize the code for speed.  The process in the code is as follows:
- Set up some file name variables.
- Read in the training measures data and the test measures data.
- Apply the subject and activity vectors to each of the measures data frames to label the rows.
- Add variable labels for the subject and activity columns
- Join the rows of the test and training data frames into a single data frame, **xdata**.
- Read the features.txt file into a data frame, **xfeatures** (these identify the measures in the data)
- Coerce the features descriptive variable to character (from level) 
- Since the features contain characters illegal for variable names, clean up the text, removing "-", "(",")", and "," from each value.
- Add a variable to the **xfeatures** data frame to identify each row as "mean", "std" or "other."
- Build a subset, **keepFeat** of the features dataframe containing only the rows identified as "mean" or "other"
- Rename the measures columns of the **xdata** data frame.
- Rebuild **xdata**, retaining subject, activity, and the meausures with labels matching measures in **keepFeat**.
- Replace the activity numeric values in **xdata** with their text labels as given in activity_labels.txt.
- Use aggregate to summarize the means of all the measures in a "wide form" tidy data set
- Write the tidy set out to a tab delimited text file in the same folder as the source data. 

## TIDYSET Extract 
```
b <- read.csv("UCI HAR Dataset/tidyset.txt", sep="\t")
b[1:20,1:5]
```

```
   subject activity tBodyAccmeanX tBodyAccmeanY tBodyAccmeanZ
1        1   LAYING     0.2215982   -0.04051395   -0.11320355
2        2   LAYING     0.2813734   -0.01815874   -0.10724561
3        3   LAYING     0.2755169   -0.01895568   -0.10130048
4        4   LAYING     0.2635592   -0.01500318   -0.11068815
5        5   LAYING     0.2783343   -0.01830421   -0.10793760
6        6   LAYING     0.2486565   -0.01025292   -0.13311957
7        7   LAYING     0.2501767   -0.02044115   -0.10136104
8        8   LAYING     0.2612543   -0.02122817   -0.10224537
9        9   LAYING     0.2591955   -0.02052682   -0.10754972
10      10   LAYING     0.2802306   -0.02429448   -0.11716864
11      11   LAYING     0.2805930   -0.01765981   -0.10878658
12      12   LAYING     0.2601134   -0.01752039   -0.10816013
13      13   LAYING     0.2767164   -0.02044045   -0.10433186
14      14   LAYING     0.2332754   -0.01134247   -0.08683333
15      15   LAYING     0.2894757   -0.01662965   -0.11853024
16      16   LAYING     0.2742272   -0.01661035   -0.10731049
17      17   LAYING     0.2697801   -0.01684620   -0.10700628
18      18   LAYING     0.2746916   -0.01739377   -0.10769893
19      19   LAYING     0.2726537   -0.01714269   -0.10898146
20      20   LAYING     0.2395079   -0.01444063   -0.10427432
```
### License:
========
Use of the dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
