library(data.table)
## Pardon the hard-coded directory
## setwd("/Users/mfunke/Downloads/UCI HAR Dataset/")
xtrain=read.table("train/X_train.txt")
activity=read.table("train/y_train.txt")
subject=read.table("train/subject_train.txt")
xtest=read.table("test/X_test.txt")
subject2=read.table("test/subject_test.txt")
activity2=read.table("test/y_test.txt")
labels=read.table("activity_labels.txt")
        
features=read.table("features.txt")
colnames(xtrain)=features[,2]
colnames(xtest)=features[,2]

## Look for lines containing a MEAN or STD after dash and before opening bracket
## This is my interpretation of the brief
r=grep("\\w*-(mean|std)\\(", features[,2], value=FALSE)

## Keep only the columns we identified by the grep above
xtrain2=cbind(subject, activity, xtrain[,r])
xtest2=cbind(subject2, activity2, xtest[,r])

## Paste the two together
combined=rbind(xtrain2, xtest2)

## Restore the column names for subject and activity
colnames(combined)[1]="subject"
colnames(combined)[2]="activity"

## Delete any dashes and brackets from the variable names for better readibility
colnames(combined)=gsub("[-\\(\\)]", "", colnames(combined))

## Label the activity with a friendly name
combined$activity=factor(combined$activity, labels=labels$V2)

## Now convert the data.frame to a data.table
combinedDT=data.table(combined)

## sort the table by subject and activity
setkey(combinedDT, subject, activity)
key=key(combinedDT)

## from http://cran.r-project.org/web/packages/data.table/data.table.pdf:
## Note how the lapply mechanism is used to calculate the mean for each column
## More info the README
write.table(combinedDT[,lapply(.SD,mean), by=key], file="results.txt", row.names=FALSE)






