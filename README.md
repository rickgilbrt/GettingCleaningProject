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
