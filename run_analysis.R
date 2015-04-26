#Script to convert data to tiny data format
rm(list=ls())
#loads feature information
meta.features = read.table('UCI HAR Dataset/features.txt')[,2] #where all the feature names go

#greps the vector with mean and std keywords. The return values are indices
meta.col.indexes.mean = grep(pattern = "mean()",x=meta.features)
meta.col.indexes.std = grep(pattern = "std()",x=meta.features)
meta.col.indexes = c(meta.col.indexes.mean,meta.col.indexes.std)

#Loads the activity name
meta.activity = read.table('UCI HAR Dataset/activity_labels.txt')



#Loads test set information into a test matrix
x.test <- read.table('UCI HAR Dataset/test/X_test.txt')
colnames(x.test) <- meta.features
x.test <- x.test[,meta.col.indexes]
x.test <- cbind(x.test,read.table('UCI HAR Dataset/test/y_test.txt',col.names=c('Activity')))
x.test <- cbind(x.test,read.table('UCI HAR Dataset/test/subject_test.txt',col.names=c('Subject')))


x.training <- read.table('UCI HAR Dataset/train/X_train.txt')
colnames(x.training) <- meta.features
x.training <- x.training[,meta.col.indexes]
x.training <- cbind(x.training,read.table('UCI HAR Dataset/train/y_train.txt',col.names=c('Activity')))
x.training <- cbind(x.training, read.table('UCI HAR Dataset/train/subject_train.txt',col.names=c('Subject')))

data.merged <- rbind(x.training,x.test)
data.merged.colnames <- colnames(data.merged)

#Updates colnamaes




#Creates final dataframe with means per Activity per subject
final <- data.frame()


for (subject_split in  split(data.merged,data.merged$Subject)){
  for (activity_split in  split(subject_split,subject_split$Activity)){
    final <- rbind(final,colMeans(activity_split)) 
  }  
}


colnames(final)<- data.merged.colnames
final$Activity <- meta.activity[final$Activity,2]

#Generate tidy dataset of means
#data.merged2.colnames <- unique(lapply(strsplit(meta.features[meta.col.indexes.mean], "-mean()"),function(x) x[1]))
#data.merged2 <- as.data.frame(matrix(nrow = dim(data.merged)[1]))

#The mew will be calculated each one of the colnames and fore each entry


#for (name in data.merged2.colnames){
#  matches <- grep(pattern = sprintf("%s.mean()",name),x=data.merged.colnames)
#  aux <-if (length(matches) >1){
#    rowMeans(data.merged[,matches])
#  }else{
#    data.merged[,matches]
#  }

#  data.merged2[,sprintf("%s-mean()",name)] <- aux
#}

#data.merged2[,'Activity'] <- data.merged[,'Activity']
print(colnames(final))
write.table(colnames(final), "CodeBook.md", sep="\n",row.names=FALSE,col.names=FALSE)
write.table(final, "final.txt", sep="\n",row.names=FALSE)
