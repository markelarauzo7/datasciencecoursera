# Code Book

This document describes the code inside `run_analysis.R`.

## Downloading and loading data

* Downloads the UCI HAR zip file and check if it exist to proceed.
* Reads activity labels into `activity_labels_df`
* Reads the column names of data (a.k.a. features) to `features_df`
* Reads training and test data assigning each value following this rule : `%filename%_%directory%_df`

## Manipulating data

* All `/test` and `/test/Inertial Signals` data is named and merged into `df_test`
* All `/train` and `/train/Inertial Signals` data is named and merged into `df_train` 
* Merges `df_test` data and `df_train` data into `final_df`
* Identifies the mean and std columns (so that only measurements are retrieved, raw inertial signals values are discarded)
* A new `data.frame` is created `tidy_df` (Id, Subject id,Activity number, Activity class name)  and measurements are added.
* Summarizes `tidy_df` calculating the average for each column for each activity/subject.


