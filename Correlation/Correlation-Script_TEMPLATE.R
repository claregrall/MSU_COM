

### -----------------------------------------------------------------------------------------------###

## Created on: 10-7-17
## Created by: Dan Totzkay
## Last saved: 10-7-17
## Saved by: Dan Totzkay
## Description: Correlation in R

### ---------------------------------------------------------------------------------------------- ###
### ---------------------------------------------------------------------------------------------- ###

## Set your working directory -- this should be where your data file is saved
setwd("")
getwd()

## Load/install required packages
install.packages("stats")
install.packages("stringr")

library(stats)
library(stringr)

### ---------------------------------------------------------------------------------------------- ###

## Load your data file. Use the exact name + .csv
mydata <- ".csv"

## Segment the variables you would like to use for the correlation. The setup should be mydata$ followed 
##   immediately by the name of the variable in your data set with NO SPACE between the $ and the name.
corrvars <- data.frame()
View(corrvars)

## Pearson correlation matrix with listwise deletion
corr_matrix <- cor(corrvars, use = "complete.obs") 

## Other correlation options --- 
   ## use = "pairwise.complete.obs" 
   ## na.rm = TRUE --- this will remove NA values

## You can see your correlation matrix in R, or just save it below and view in Excel
View(corr_matrix)

## Name your correlation matrix CSV file. When you open, make sure to highlight everything and change the data from
##   "General" to "Numeric" to bring it down to two decimal points.
write.csv(corr_matrix, file = ".csv")


### ---------------------------------------------------------------------------------------------- ###
## Here is the condensed version, with no notes.
setwd("")
mydata <- ".csv"
corrvars <- data.frame()
corr_matrix <- cor(corrvars, use = "complete.obs") 
write.csv(corr_matrix, file = ".csv")

### ---------------------------------------------------------------------------------------------- ###
### ---------------------------------------------------------------------------------------------- ###

