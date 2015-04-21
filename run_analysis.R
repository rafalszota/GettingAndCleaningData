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



xheaders <- read.table("mob/features.txt")
xheaders <- xheaders[, 2]

activity <- read.table("mob/activity_labels.txt")
names(activity) <- c("id_activity", "activity.name")


#train
xtrain <- read.table("mob/train/X_train.txt")
names(xtrain) <- xheaders


ytrain <- read.table("mob/train/y_train.txt")
names(ytrain) <- "id_activity"
activitytrain <- merge(ytrain, activity, by="id_activity")


subjecttrain <- read.table("mob/train/subject_train.txt")
names(subjecttrain) <- "subject"

train <- cbind(activitytrain, subjecttrain, xtrain)

#test
xtest <- read.table("mob/test/X_test.txt")
names(xtest) <- xheaders


ytest <- read.table("mob/test/y_test.txt")
names(ytest) <- "id_activity"
activitytest <- merge(ytest, activity, by="id_activity")


subjecttest <- read.table("mob/test/subject_test.txt")
names(subjecttest) <- "subject"

test <- cbind(activitytest, subjecttest, xtest)

data <- rbind(test, train)

#extracts only data for means
mean.std.data <- data[, c(2, 3, grep(".*(mean|std)[\\(].*", names(data)))]

#sets appropiate variable names
correct.var.names <- make.names(names(mean.std.data))
correct.var.names <- gsub("\\.{2, }", ".", correct.var.names)
names(mean.std.data) <- correct.var.names
                                
#create new clean dataset
clean.data <- aggregate(mean.std.data[, -c(1, 2)], by=list(mean.std.data$activity.name, mean.std.data$subject), FUN=mean, na.rm=TRUE)                                
names(clean.data)[1] <- "activity.name"
names(clean.data)[2] <- "subject"


