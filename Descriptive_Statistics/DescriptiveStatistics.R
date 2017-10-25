### -----------------------------------------------------------------------------------------------###

## Created on: 10-08-17
## Created by: Ying Cheng
## Last saved: 10-10-17
## Saved by: Ying Cheng
## Description: Descriptive Statistics in R

### ---------------------------------------------------------------------------------------------- ###

######################################################################################################
##################################                                 ###################################
##################################                                 ###################################
##################################  Descriptive Statistics in R    ###################################
##################################                                 ###################################
##################################                                 ###################################
######################################################################################################




##Set the working directory##
setwd("D:/Graduate/R")

##Import your data file to R and define the name of this file in R (i.e. dataset in the very beginning of the following line)##
##Remember when you import the data file, make sure to include the extension"
dataset <- read.csv("DATASET.csv", header=TRUE)

##R has a built-in that provides the basic descriptive information of your variables in the dataset##
##To get this basic information, we can use the summary(your dataset name) function##
summary(dataset)

## To Overview the frequency of a variable, use the table(variable) function##
table(dataset$age)


#To get a histogram of your variables, use the hist(variable) function##
#The variable is defined as dataset$variable#

hist(dataset$age)

##In addition to the build-in, we can also use the "psych" package to get the descriptive statistics##
##The following two lines are about how to install and call the psych package##
install.packages("psych")
library(psych)

##In the "psych" package, describe(your dataset's name) will give you an overview of the descriptive statistics of all the variables in your dataset##
#It will tell you the mean, sd, min, max, range, skewness, kurtosis, and se of all your variables##
describe(dataset)

#You can also ask for the descriptive statistics for a given variable##
describe(dataset$age)

##You can also ask for the descriptive statistics of one variable grouped by another variable##
##The function to use is describeBy(the focal variable, the grouping variable)
describeBy(dataset$age, group=dataset$sex, digits=4)

##Check for the missing value##
colSums(is.na(dataset))

#Check for normality of your variable#
#If the p value is larger than .05, it indicates that your data is not significantly different from the normal distrition##
shapiro.test(dataset$age)



