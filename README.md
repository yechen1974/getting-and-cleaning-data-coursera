# getting-and-cleaning-data-coursera
the repository for the coursera course "getting and cleaning data"
It is used for the project assignment

The repo contains both the run_analysis.R and README.md

Quick tutorial:

Based on the instruction,  we need to write a script called run_analysis.R to process the raw data
to run the R script,  just type  run_analysis() in the R terminal 

Make sure you have all the samsumg data in your directory, also all the test data needs to be in test subfolder, training data needs to be in training folder

The key steps (or the flow of the run_analysis.R)

1) merge the test data and training data

note that it is important to understand that 
  a) the feature.txt has all 561 variables (which is the individual measurement)
  b) the label text file is for the activity (6 total activities) "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"
  c) subject file in each folder (test, training) is to map to each individual persons), total 30 persons


2) extract the only mean and standard deviation (std) for total 561 variables based on the features.txt.  based on the name search, it will yield 86 rows 
  store in the tidy_data data frame

3) based on the activity (merged both y_test and y_train txt), and merged subject (subject_test and subject_training), we can put a more descriptive row names (e.g. person_x_walking ...) and assigned to tidy_data

4) based on the more descriptive measurement names in the features.txt, assign it to the column names for the tidy_data

5) step 5 is the main step to generate the final outcome.  I called it second_tidy_data.  It is based on the already cleaned tidy_data (I called it raw).
   a) to have total 180 rows (30 persons and 6 activities, 180 permutations)
   b) still 86 rows (mapped to the 86 variables for mean or std)
   c) do the average for the same combo of (activity,subject/person)

6) output to the .txt files using write.table (I also write to .csv file for better format)   

I generate total four files


second_tidy_data.txt (required output by project)
second_tidy_data.csv (csv version)
tidy_data_raw.txt (the raw tidy data in txt format)
tidy_data_raw.csv (the csv version of raw tidy data)

If you have any comments to simplify the code, please let me know.  