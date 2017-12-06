# https://nickmichalak.blogspot.com/2016/07/reproducing-hayess-process-models.html


### -----------------------------------------------------------------------------------------------###

## Created on: 12-5-17
## Created by: Lindsay Hahn
## Last saved: 12-5-17
## Saved by: Lindsay Hahn
## Description: Using R for Simple Mediation 

### ---------------------------------------------------------------------------------------------- ###

######################################################################################################
##################################                                 ###################################
##################################               Simple            ###################################
##################################             Mediation           ###################################
##################################                                 ###################################
######################################################################################################

### ----------------------------------------------------------------------------------------------- ###
### ----------------------------------------------------------------------------------------------- ###

##  The purpose of this R script is to translate simple mediation conducted in Hayes'  
##   PROCESS Macro for SPSS (http://afhayes.com/introduction-to-mediation-moderation-and-conditional-process-analysis.html)
##   For the most part, so long as you know some very basic aspects of your data (e.g., variable names, 
##   sample size), there should be little difficulty utlizing this code, even if you have no experience  
##   with syntax. If you made changes, remember to keep letter case consistent, close all quotations and 
##   parentheses, and define any variable/object you intend to manipulate prior to doing so. For best
##   outcomes, use RStudio to implement this code and, if you run into errors or have questions about
##   a specific action, you can always enter the function into a new line with a question mark before
##   it (e.g., ?View) and a help file will open in the lower right pane of RStudio. 

### ----------------------------------------------------------------------------------------------- ###
### ----------------------------------------------------------------------------------------------- ###

##  First, define your working directory within the quotation marks. This should be where your 
##    data are and where you would like to save your files. Find this by opening the information 
##    of the folder you are wanting to set and type that information in here. Separate each 
##    folder with a slash (/). An example of this on a Mac (Windows may be different) would be
##    setwd("/Users/Lindsay/Documents/RScripts")

setwd("")

##  Make sure the working directory is correct.

getwd()

### ----------------------------------------------------------------------------------------------- ###
### ----------------------------------------------------------------------------------------------- ###

##  If you do not have the Hmisc, lavaan, or knitr packages installed and loaded, do so with these lines.
## Even if you just installed them, you still need to load them.

## Note: Hmisc is a grab bag of functions for data analysis and management (e.g., spss.get(), but also  more cool stuff)

want_packages <- c("Hmisc", "lavaan", "knitr")
have_packages   <- want_packages %in% rownames(installed.packages())
if(any(!have_packages)) install.packages(want_packages[!have_packages])
library(Hmisc)

### ----------------------------------------------------------------------------------------------- ###
### ----------------------------------------------------------------------------------------------- ###

## Use the following code if you want to call your data from SPSS. To do this, make sure a .csv file of 
## your data is saved within the folder you set as the working directory above. Type the name of the file 
## within the quotation marks on the line below in the read.csv() function.

egdata <- spss.get(file = "XXX",
                   lowernames = TRUE,
                   to.data.frame = TRUE)

## Alternatively, use the following code if you want to call your data from a csv file
##  Load your dataset into R; to do this, make sure a .csv file of your data is saved within the
##  folder you set as the working directory above. Type the name of the file within the 
##  quotation marks on the line below in the read.csv() function.

egdata <- data.frame(read.csv(".csv"))

##  View the structure of your data and the first row to make sure it is structured as you 
##    would expect it to be. Remember, when calling a row or column of a data fram or matrix, 
##    ROWS come before the column, and COLUMNS come after it. In the case below, we want to view
##    the first row, all columns. Remember == RC cola! (rows, then columns)

str(egdata)
egdata[1,]

######################################################################################################
########################################                     #########################################
########################################    Preparing data   #########################################
########################################                     #########################################
######################################################################################################

## Below is a function for centering your variables. 
center.var <- function(x){
  centered <- as.vector(scale(x = x, center = TRUE,
                              scale = FALSE))
  return(centered)
}

## Below is code that will apply your centering function to your variables.
## You can add in as many variables as you need to here. Note that this is using lapply to (1) apply the 
## function to many variables and (2) name them oldname_c (_c for centered). 

## Replace XXX with your variable name.
egdata[,c("XXX_c", "XXX_c")] <- lapply(X = egdata[,c("XXX", "XXX")], FUN = function(x) center.var(x))

## You know the centering "worked" if the centered variable's mean = 0 but the standard deviation is the 
## same as the non-centered variable. Check this with the code below.

## Replace XXX with your variable name.

## Means of variables
sapply(egdata[,c("XXX", "XXX_c", "XXX", "XXX_c")],
       FUN = function(x){
         round(mean(x), 2)
       }, simplify = TRUE,
       USE.NAMES = TRUE)

## Standard deviation of the variables
sapply(egdata[,c("XXX", "XXX_c", "XXX", "XXX_c")],
       FUN = function(x){
         round(sd(x), 2)
       }, simplify = TRUE,
       USE.NAMES = TRUE)

######################################################################################################
########################################                     #########################################
########################################    Run moderation   #########################################
########################################                     #########################################
######################################################################################################

## Load the lavaan package 

library(lavaan)


## Estimate your parameters in chunks

## The first chunk is to regress the direct effect of your centered IV (IVXXX_c) on your DV (DVXXX)

## The second chunk is to assess path A (regress mediatior [MXXX] on your IV [IVXXX]) 
##      and path B of your mediation (regress DV [DVXXX] on mediator [MXXX])

## The third chunk is to assess the indirect effect of a*b

## The final chunk is to assess the total effect of the model 

hayes4 <- '
            DVXXX ~ c*IVXXX_c
            direct := c

            MXXX_c ~ a*IVXXX_c
            DVXXX ~ b*MXXX_c

            indirect := a*b

            total := c + (a*b)'

## Now we can fit the model (Note this this takes some time)
sem2 <- sem(model = hayes4,
            data = egdata,
            se = "bootstrap",
            bootstrap = 1000)

## And, assess fit measures
summary(sem2,
        fit.measures = TRUE,
        standardize = TRUE,
        rsquare = TRUE)

## bootstraps
parameterEstimates(sem2,
                   boot.ci.type = "bca.simple",
                   level = .95, ci = TRUE,
                   standardized = FALSE)

## Check out what the output will look like here: 
##  https://nickmichalak.blogspot.com/2016/07/reproducing-hayess-process-models.html
## This website also offers instructions and code for how to do moderated mediation (model #7 of Hayes)