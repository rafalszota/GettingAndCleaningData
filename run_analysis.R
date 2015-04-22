# 1. Merges the training and the test sets to create one data set.
# 
# 2. Extracts only the measurements on the mean and standard deviation 
# for each measurement. 
# 
# 3. Uses descriptive activity names to name the activities in the data set
# 
# 4. Appropriately labels the data set with descriptive variable names. 
# 
# 5. From the data set in step 4, creates a second, 
# independent tidy data set with the average of each variable 
# for each activity and each subject.


#Read all data into R

## Read meta-data - features name and activities names
xheaders <- read.table("Samsung/features.txt")
activity <- read.table("Samsung/activity_labels.txt")

## Read train dataset
xtrain <- read.table("Samsung/train/X_train.txt")
ytrain <- read.table("Samsung/train/y_train.txt")
subjecttrain <- read.table("Samsung/train/subject_train.txt")

## Read test dataset
xtest <- read.table("Samsung/test/X_test.txt")
ytest <- read.table("Samsung/test/y_test.txt")
subjecttest <- read.table("Samsung/test/subject_test.txt")

#Work with metadata

##Convert metadata into appropiate headers for x dataset
xheaders <- xheaders[, 2]

##Set appropiate headers for actitity data set
names(activity) <- c("id_activity", "activity.name")


#Work with train data

##Setup column names for x, y and subject
names(xtrain) <- xheaders
names(ytrain) <- "id_activity"
names(subjecttrain) <- "subject"


## Merge y and activity so that the activity names are descriptive
activitytrain <- merge(ytrain, activity, by="id_activity")


## Bind x,y and subject together
train <- cbind(activitytrain, subjecttrain, xtrain)


# Repeat above steps for test data

##Setup column names for x, y and subject
names(xtest) <- xheaders
names(ytest) <- "id_activity"
names(subjecttest) <- "subject"


## Merge y and activity so that the activity names are descriptive
activitytest <- merge(ytest, activity, by="id_activity")


## Bind x,y and subject together
test <- cbind(activitytest, subjecttest, xtest)


#Result step one merged data-set train and test
data <- rbind(test, train)



#Step two - extracts only columns for activity name, subject, and
#means or std within the name
mean.std.data <- data[, c(2, 3, grep(".*(mean|std)[\\(].*", names(data)))]


#Step three is implied by step one


#Step four - appropriate variable names
correct.var.names <- make.names(names(mean.std.data))
correct.var.names <- gsub("\\.{2, }", ".", correct.var.names)
names(mean.std.data) <- correct.var.names
                               
							   
#Step five - create new clean dataset written into file
clean.data <- aggregate(mean.std.data[, -c(1, 2)], by=list(mean.std.data$activity.name, mean.std.data$subject), FUN=mean, na.rm=TRUE)                                
names(clean.data)[1] <- "activity.name"
names(clean.data)[2] <- "subject"

write.table("result.txt", row.name=FALSE) 

