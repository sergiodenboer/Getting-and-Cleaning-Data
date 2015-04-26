#Script to convert data to tiny data format
#loads feature information
meta.features = read.table('UCI HAR Dataset/features.txt')[,2] #where all the feature names go

#greps the vector with mean and std keywords. The return values are indices
meta.col.indexes.mean = grep(pattern = "mean()",x=meta.features)
meta.col.indexes.std = grep(pattern = "std()",x=meta.features)
meta.col.indexes = c(meta.col.indexes.mean,meta.col.indexes.std)

#Loads the activity name
meta.activity = read.table('UCI HAR Dataset/activity_labels.txt')

#Laods test dataset and corresponding filtered column names
x.test <- read.table('UCI HAR Dataset/test/X_test.txt')
colnames(x.test) <- meta.features
x.test <- x.test[,meta.col.indexes]
x.test <- cbind(x.test,read.table('UCI HAR Dataset/test/y_test.txt',col.names=c('Activity')))
x.test <- cbind(x.test,read.table('UCI HAR Dataset/test/subject_test.txt',col.names=c('Subject')))

#Laods training dataset and corresponding filtered column names
x.training <- read.table('UCI HAR Dataset/train/X_train.txt')
colnames(x.training) <- meta.features
x.training <- x.training[,meta.col.indexes]
x.training <- cbind(x.training,read.table('UCI HAR Dataset/train/y_train.txt',col.names=c('Activity')))
x.training <- cbind(x.training, read.table('UCI HAR Dataset/train/subject_train.txt',col.names=c('Subject')))

#Merges all datasets by binding rows
data.merged <- rbind(x.training,x.test)
data.merged.colnames <- colnames(data.merged)


#Creates final dataframe with means per Activity per subject
final <- data.frame()

#Splits dataset by subject and by activity. Performs column means
#Appends results to final data.frames
for (subject_split in  split(data.merged,data.merged$Subject)){
  for (activity_split in  split(subject_split,subject_split$Activity)){
    final <- rbind(final,colMeans(activity_split)) 
  }  
}

#Applies colum names and changes activity lavels
colnames(final)<- data.merged.colnames
final$Activity <- meta.activity[final$Activity,2]

#Writes text files
write.table(colnames(final), "CodeBook.md", sep="\n",row.names=FALSE,col.names=FALSE)
write.table(final, "final.txt", sep="\n",row.names=FALSE)
