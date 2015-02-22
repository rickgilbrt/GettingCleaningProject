# run_analysis.R
### Getting And Cleaning Data Class Project
Script for Getting And Cleaning Data class project
Submitted by Rick Gilbert - rick.gilbert.net@gmail.com
## Summary
This repo contains the script & code book for generating a tidy data set as specified in the project instructions.
The source data and descriptions of the data and how they were obtained are located at
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A description of the project that generated the data may be found at
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The script run_analysis.R contains one function, run_analysis(), that has no arguments.  When called, the function loads and merges the test and training data sets, extracts mean and standard deviation measures for each measure, and modifies the activity and variable labels to character values as given in the source information.
Finally, the script creates a data frame of the average of each variable for each activity and subject, and writes that data frame as a tab-delimited text file to tidy.txt in the same folder as the original data.

## Assumption
- Original zipped Samsung data are extracted into a folder that is a subfolder of the R working directory.
- The assignment specifies that only measurement means and standard deviations should be retained.  The word "mean" or "Mean" appears in features that are clearly not means, based on descriptions on the features_info.txt file in the original source.  This script assumes that features that include the lower case form, "mean", are means for the intent of the project.

## Running the script
- Copy the run_analysis.R script to the folder of your choice
- Save the zip file containing the source data to a folder of your choice.
- Open the zip file and copy the folder and its files to be a direct subfolder of your R working directory.
- Source run_analysis.R in R.
- Check that your working directory has *UCI HAR Dataset* as a subfolder
- Run the function run_analysis()
- Examine tidyset.txt in the *UCI HAR Dataset* folder

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
