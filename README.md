# getting-and-cleaning-data-coursera
the repository for the coursera course "getting and cleaning data"
It is used for the project assignment


Quick tutorial:

Based on the instruction,  we need to write a script called run_analysis.R to process the raw data
to run the R script,  just type  run_analysis() in the R terminal 

Make sure you have all the samsumg data in your directory, also all the test data needs to be in test subfolder, training data needs to be in training folder

The key steps (or the flow of the run_analysis.R)

1) merge the test data and training data

note that it is important to understand that 
  a) the feature.txt has all 561 variables (which is the individual measurement)
  b) the label text file is for the activity (6 total activities) "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"
  c) subject file in each folder (test, training) is to map to each individual persons)
