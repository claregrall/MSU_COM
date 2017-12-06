
### -----------------------------------------------------------------------------------------------###

## Created on: 10-08-17
## Created by: Lindsay Hahn
## Last saved: 10-08-17
## Saved by: Lindsay Hahn
## Description: Using R for Regression

### ---------------------------------------------------------------------------------------------- ###

######################################################################################################
##################################                                 ###################################
##################################                                 ###################################
##################################        Regression in R          ###################################
##################################                                 ###################################
##################################                                 ###################################
######################################################################################################

### ----------------------------------------------------------------------------------------------- ###
### ----------------------------------------------------------------------------------------------- ###

##  First, define your working directory within the quotation marks. This should be where your 
##    data are and where you would like to save your files. Find this by opening the information 
##    of the folder you are wanting to set and type that information in here. Separate each 
##    folder with a slash (/). An example of this on a Mac (Windows may be different) would be
##    setwd("/Users/Lindsay/Documents/RScripts")

## For Macs
setwd("/Users/")

## For PCs
setwd("C:\Users\")

##  Make sure the working directory is correct.

getwd()

### ----------------------------------------------------------------------------------------------- ###
### ----------------------------------------------------------------------------------------------- ###

##  If you do not have the stats package installed, do so with these lines.

install.packages("stats")

## Now, load stats. Even if you just installed them, you still need to load them.

library(stats)

### ----------------------------------------------------------------------------------------------- ###
### ----------------------------------------------------------------------------------------------- ###

##  Load your dataset into R; to do this, make sure a .csv file of your data is saved within the
##    folder you set as the working directory above. Type the name of the file within the 
##    quotation marks on the line below in the read.csv() function.

mydata <- data.frame(read.csv(".csv"))

##  View the structure of your data and the first row to make sure it is structured as you 
##    would expect it to be. Remember, when calling a row or column of a data fram or matrix, 
##    ROWS come before the column, and COLUMNS come after it. In the case below, we want to view
##    the first row, all columns. Remember == RC cola! (rows, then columns)

str(mydata)
mydata[1,]

######################################################################################################
########################################                     #########################################
########################################    Run Regression   #########################################
########################################                     #########################################
######################################################################################################

##  Assign the DV(s) and IV(s) you want to use in your regression. Type the name of your variables 
##    below where it says DV, IV1, IV2, etc. Note that you can use as many IVs as you want here.
##    If you need to add more IVs, simply add them after IV2 below. 

##  Now we're ready to run our regression using the lm function. Here, we apply the lm function to 
##    our variables of interest and nd save the linear regression model as ‘regression1’.

regression1 <- lm(DV ~ IV1, IV2, data = mydata)

##  Now view a summary of the regression you ran. This contains all the information you should need
##    to write up in your results. Note that the residual standard error gives you an indication of 
##    the “typical” distance between your actual dv values  and fitted dv values.

summary(regression1)

##  Use the attributes function to view all of the information the lm funcion computed.

attributes(regression1)

##  For instance, if we want to view the model's coefficients: intercept and slope:

regression1$coefficients

##  Of if we want to view more decimal places for the same attribute:

summary(regression1)$coefficients 

## We can also view the confidence intervals (which are by default 95%).

confint(regression1)

### ----------------------------------------------------------------------------------------------- ###
### ----------------------------------------------------------------------------------------------- ###

##  Now plot your results. Be sure to change the "DV" and "IV" labels below according
##    to what you want to plot. This will allow you to plot your DV as a linear function of your IV.
##    The abline function is used to here to plot the fitted regression line from the regression you just
##    ran. (Note: abline is a function that can be used generally to put a line anywhere in your plot)

with(mydata, plot(IV1, DV))
abline(regression1)

######################################################################################################
########################################                     #########################################
########################################       Checking      #########################################
########################################       Normality     #########################################
########################################                     #########################################
######################################################################################################

##  First let’s compute the standardized residuals with rstandard(). The standardised residual is the 
##    residual divided by its standard deviation.

regression1.stdres = rstandard(regression1)

##  Now, let’s assess the normal probability with qqnorm(), and add a line indicating normality using 
##    qqline(). qqnorm() allows us to plot the sample quantiles by the theoretical quantiles; regardless
##    of the mean or standard deviation, this plot will tell you whether the data come from a normal 
##    distribution. Q-Q refers to ‘Quantile’ vs. ‘Quantile'
##    Be sure to change your IV and DV labels below for your plot!

qqnorm(regression1.stdres, ylab="Standardised Residuals", 
       xlab="Normal Scores", main="DV by IV") 
qqline(regression1.stdres) 

### ----------------------------------------------------------------------------------------------- ###
### ----------------------------------------------------------------------------------------------- ###

##  Let’s also plot the density of our DV This will tell us, for this continuous distribution, how 
##    likely it is that we will observe a value close to x. The larger the area under the curve, 
##    the greater the probability of observing a value in that particular interval.
##    Be sure to change your DV label below!

with(mydata, plot(density(DV)))


## Now try a scale-location plot. This plot uses the square root of the standardized residuals. There 
##    should be no discernable pattern to the plot (because randomness is an incdication of linearity).
##    Using plot(regression1), you can see check for outliers. This is the gold-standrd of diagnostics.

plot(regression1$fitted.values, regression1.stdres, 
     ylab = "Standardized residuals", xlab = "Fitted values")

##  You can also plot the actual residuals by the fitted values. The points should be a sort of 
##    “random cloud” around 0. If you have time series data, you can also check whether errors appear 
##    to be correlated with time.

plot(regression1$fitted.values, regression1$residuals, 
     ylab = "Residuals", xlab = "Fitted values")

##  You can look at the histogram of the residuals. Does it have the shape of a normal distribution?

hist(regression1$residuals)

##  Can add logistic regression from File5

