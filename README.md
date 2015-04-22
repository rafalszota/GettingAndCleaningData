#Script  

Script follow project assignment requirements:

1. Merges the training and the test sets to create one data set.
 
2. Extracts only the measurements on the mean and standard deviation 
 for each measurement. 
 
3. Uses descriptive activity names to name the activities in the data set
 
4. Appropriately labels the data set with descriptive variable names. 
 
5. From the data set in step 4, creates a second, 
 independent tidy data set with the average of each variable 
 for each activity and each subject.


#Precondition

Script assumes Samsung data is unziped and availible in 

    $[working.directory]/Samsung/



#Steps
##Step 1

###Read all data into R

- Read meta-data - features name and activities names
- Read train dataset
- Read test dataset


###Work with metadata

- Convert metadata into appropiate headers for x dataset
- Set appropiate headers for actitity data set


###Work with train data

- Setup column names for x, y and subject
- Merge y and activity so that the activity names are descriptive
- Bind x,y and subject together


###Work with test data

- Setup column names for x, y and subject
- Merge y and activity so that the activity names are descriptive
- Bind x,y and subject together


### Result 
- Merge data-set train and test



##Step 2 
Extracts only columns for:

- *activity name*, 
- *subject*, 
- columns with *means* or *std* within the name.


##Step 3
Usage of  descriptive activity names, is implied by step 1. Merge between dataframes *y* and *activity* ensures merged data set contains descriptive names.


##Step 4

The script assigns appropriate variable names, removing white-spaces, replacing special characters by dot (.) and ensures there are no several consecutive dots. 
                               
##Step 5		
		
The script aggregates measures by activity name and subject using *mean* as aggregation function. Aggregated data is stored in new clean dataset.
			   
#Result

Script writes output data into 
    
	 $[working.directory]/result.txt
