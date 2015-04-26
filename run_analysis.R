# clean up working space & command window
rm(list=ls())
cat("\014")

library(dplyr)

# collect variable names
act_lab <- read.table("activity_labels.txt")
feature <- read.table("features.txt")

## Read training data
dat_train<-read.table("train/X_train.txt", header=FALSE)
colnames(dat_train)<-feature$V2
lab_train<-read.table("train/y_train.txt", header=FALSE)
subj_train<-read.table("train/subject_train.txt", header=FALSE)
train_set<-rep("train",dim(dat_train)[1])


## Read test data
dat_test<-read.table("test/X_test.txt", header=FALSE)
colnames(dat_test)<-feature$V2
lab_test<-read.table("test/y_test.txt", header=FALSE)
subj_test<-read.table("test/subject_test.txt", header=FALSE)
test_set<-rep("test",dim(dat_test)[1])

# 1. Merges the training and the test sets to create one data set.
all_data <-rbind(dat_train,dat_test)
all_subj<-rbind(subj_train,subj_test)
all_label<-rbind(lab_train,lab_test)
set_name<-c(train_set,test_set)

# merge into one big data frame with all variables
mergedData<-cbind(all_subj,all_label,set_name,all_data)
colnames(mergedData)[1:2]<-c("subj_id","activity_id")
mergedData$activity_id<-as.factor(mergedData$activity_id)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
mean_idx<-grep("mean",names(all_data))
std_idx<-grep("std",names(all_data))
selectedData<-all_data[,c(mean_idx,std_idx)]

# 3. Uses descriptive activity names to name the activities in the data set
all_label <- factor(all_label$V1, levels=c(1,2,3,4,5,6),labels=c('WALKING','WALKING_UPSTAIRS','WALKING_DOWNSTAIRS','SITTING','STANDING','LAYING'))
selectedData$Activity<-all_label

# 4. Appropriately labels the data set with descriptive variable names
names(selectedData)<- gsub(pattern="-", replacement="_",names(selectedData))
names(selectedData)<- sub(pattern="()", replacement="",names(selectedData),fixed=TRUE)
selectedData$Subject_id<-as.factor(all_subj$V1)

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
new_data<-selectedData%>%group_by(Subject_id,Activity)%>%summarise_each(funs(mean))
write.table(new_data, "mean_subject_activity.txt", row.name=FALSE)