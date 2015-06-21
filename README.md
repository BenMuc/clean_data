# clean_data
A script that cleans the UCI HAR dataset and extracts the means and standard deviations.
It first loads and then combines the 3 test (resp. training) data sets into one data frame each.
It then loads the labels and renames the columns in order to make a vlookup later
Afterwards it loads the features list and changes the mean and std columns to make them better readable. 
Then the script filters the rows that include the means and stds in the second column of the features data frame and adds the subjects and activities to them.
Then the test and training data are combined. Then the respective columns containing the previously extracted mean/std data are retained, the others are of no interest here and can be neglected.

It then does a vlookup and add the written names of the activities. The now no longer needed index numbers of the activities are deleted.
At last the mean it created over the activities and the subjects and the respective columns are deleted afterwards, as they are not needed in the cleaned data.
Finally, a .txt file is created with the results.
