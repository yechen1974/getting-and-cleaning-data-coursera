# R script for the project (course getting and cleaning data, coursera)
#You should create one R script called run_analysis.R that does the following. 
#step 1.Merges the training and the test sets to create one data set.

run_analysis <-function()
{
library(dplyr)
# first read the data to the data set and then combine it

test_set<-read.table("./test/x_test.txt")
test_label <- read.table("./test/y_test.txt")
train_set<-read.table("./train/x_train.txt")
train_label <- read.table("./train/y_train.txt")
active_label <-read.table("activity_labels.txt")
subject_test<-read.table("./test/subject_test.txt")
subject_train<-read.table("./train/subject_train.txt")
feature<-read.table("features.txt")
tidy_data<-data.frame() 
second_tidy_data<-data.frame()
second_tidy_data_row_name<-list() 
i<-0
j<-0
k<-0
n<-0

# use rbind to combine training set and test set 
# note that the activity is mapped to the merge data per row
merge_data<-rbind(train_set, test_set)
merge_activity<-rbind(train_label,test_label)
merge_subject<-rbind(subject_train,subject_test)
activity_name<-c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")

#step 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
# based on the features.txt,  get the subset of the merged data (on mean and std)
reduced_feature<-filter(feature,grepl("mean",feature[,2],ignore.case = TRUE)|grepl("std",feature[,2],ignore.case = TRUE))

# initiate with the first column for tidy data
if(nrow(reduced_feature)>0)
  tidy_data<-select(merge_data,reduced_feature[1,1])
  
# based on the index and the name, get the subset of the merged data
if(nrow(reduced_feature)>1)
{
  for(i in 2:nrow(reduced_feature))
  {
  
    tidy_data<-cbind(tidy_data,select(merge_data,reduced_feature[i,1]))
  }
}


# step 3.Uses descriptive activity names to name the activities in the data set
# based on the activity_labels.txt and subject_test/train.txt. label the row name

if(nrow(tidy_data)>0)
{
  for(i in 1:nrow(tidy_data))
    rownames(tidy_data)[i]<-paste(activity_name[merge_activity[i,1]],"_","person",as.character(merge_subject[i,1]),
                                            "_row_",as.character(i),sep = "")
  
} 

#step 4.Appropriately labels the data set with descriptive variable names. 

for(i in 1:ncol(tidy_data))
  names(tidy_data)[i]<-as.character(reduced_feature[i,2])

# step 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# for each activity (6) and each subject (30), so total 30*6=180 row (with average )

# construct a index data frame based on merge_activity and merge_subject to facilitate idenfying the row
merge_index<-cbind(merge_activity,merge_subject)
names(merge_index)<-c("activity","subject")

for(i in 1:ncol(tidy_data))
{
    # for each column (variable). based on the row name (took the appendix row number)
   for(j in 1:length(activity_name))
   {
     for(k in 1:30) # total 30 people
     {
       # obtain the subset of each combo (activity/subject)
       temp_set<-subset(merge_index,activity==j& subject==k)
       # calculate the mean
       if(nrow(temp_set)>0)
       {
         second_tidy_data[(j-1)*30+k,i]<-0
         total<-0
         for(n in 1:nrow(temp_set))
         {
           total<-total+tidy_data[as.numeric(rownames(temp_set)[n]),i]
         }
         second_tidy_data[(j-1)*30+k,i]<-total/nrow(temp_set)
       }
       if(nrow(temp_set)==0)
         second_tidy_data[(j-1)*30+k,i]<-0
       
       
       
     }
   }
  
}

# add the right rownames.  Keep the same column names as tidy_data

names(second_tidy_data)<-names(tidy_data)
# add the row name
for(j in 1:6)
{
  for(k in 1:30) # total 30 people
    rownames(second_tidy_data)[30*(j-1)+k]<- paste(activity_name[j],"_","person_",as.character(k),sep = "")
}
# last step use the write.table() to a .txt and .csv file to store the tidy data

write.table(tidy_data,"tidy_data_raw.txt")
write.csv(tidy_data,"tidy_data_raw.csv")

write.table(second_tidy_data,"second_tidy_data.txt")
write.csv(second_tidy_data,"second_tidy_data.csv")
}
