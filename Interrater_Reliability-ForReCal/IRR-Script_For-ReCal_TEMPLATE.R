
### -----------------------------------------------------------------------------------------------###

## Created on: 8-17-17
## Created by: Dan Totzkay
## Last saved: 9-5-17
## Saved by: Dan Totzkay
## Description: Using R to prepare spreadsheets for inter-coder reliability using ReCal application 
##               (see http://dfreelon.org/utils/recalfront/recal3/)

### ---------------------------------------------------------------------------------------------- ###

######################################################################################################
##################################                                 ###################################
##################################    Pre-Processing Reliability   ###################################
##################################       Sample Spreadsheets       ###################################
##################################                                 ###################################
##################################    For ReCal3 by Deen Freelon   ###################################
##################################                                 ###################################
######################################################################################################

### ----------------------------------------------------------------------------------------------- ###
### ----------------------------------------------------------------------------------------------- ###

##  The purpose of this R script is to easily pre-process excel spreadsheets (.csv) that contain data
##   coded by 2 or more raters in content analysis or observational studies. ReCal3, a program created
##   by Dr. Deen Freelon (see http://dfreelon.org/utils/recalfront/recal3/) calculates a number of 
##   indices used to assess inter-rater reliability (i.e., Krippendorff's Alpha, Cohen's Kappa, Percent
##   agreement), but requires the data to be entered in a specific format. This format is as follows:
##   one CSV file per variable; no headers or other labels; and, each row represents one rater, each.
##   These are easily accomplished for small rating projects with few coders, but increases in 
##   complexity and effort as these two factors increase. As such, this script is intended to prepare
##   reliability datasets, regardless of variable or rater number, for submission to ReCal 3. Note that 
##   this is only for nominal data - ordinal or interval may need other pre-processing step. 

##  All data should be numeric. Use 0 for absent, 1 for present, and 99 for NA. Ensure there are no
##   other symbols present in the data set (like periods, commas, and so on).

##  Sections  of this script that must be edited by the user are noted in comments, as are sections that 
##   can be left the way they are. For the most part, so long as you know some very basic aspects of  
##   your data (e.g., variable names, number of coders), there should be little difficulty utlizing this 
##   code, even if you have no experience with syntax. If you made changes, remember to keep letter 
##   case consistent, close all quotations and parentheses, and define any variable/object you intend 
##   to manipulate prior to doing so. For best outcomes, use RStudio to implement this code and, if you 
##   run into errors or have questions about a specific action, you can always enter the function into 
##   a new line with a question mark before it (e.g., ?View) and a help file will open in the lower 
##   right pane of RStudio. 

#######################################################################################################
###############################################        ################################################ 
###############################################  NOTE  ################################################
###############################################        ################################################ 
#######################################################################################################

##  This code assumes you have saved your data as "Coder_Variable." It is up to you to remember the 
##   order of your coders within your file, as this script and its output does not account for this.

### ----------------------------------------------------------------------------------------------- ###
### ----------------------------------------------------------------------------------------------- ###

##  First, define your working directory within the quotation marks. This should be where your 
##    data are and where you would like to save your files. Find this by opening the information 
##    of the folder you are wanting to set and type that information in here. Separate each 
##    folder with a slash (/). An example of this on a Mac (Windows may be different) would be
##    setwd("/Users/Dan/Desktop/Reliability")

setwd("/Users/Dan/School, Work/MSU/Graduate/Research/Methods/R Scripts/Interrater Reliability")

##  Make sure the working directory is correct.

getwd()

##  Next, install and load the needed packages.

install.packages("stringr")
library(stringr)

######################################################################################################
########################################                     #########################################
########################################   Data & Variables  #########################################
########################################                     #########################################
######################################################################################################

##  Here, you will bring your data file into R and assign the general codes implemented in this 
##   syntax the names of the variables you are coding for. This is most important for saving your files
##   and for your own organization.

### ----------------------------------------------------------------------------------------------- ###

## Create object for the dataset

## Enter the name of your data file within the quotations (do not include the extension)

dataname <- ""

#Now, use this line of code (do not change) to create an object for your dataset

myddata <- str_c(dataname, ".csv", sep = "") %>% read.csv() %>% data.frame()

### ----------------------------------------------------------------------------------------------- ###

## Create an object for each variable name (general, assign names for current project), which will 
##  then be collapsed into a vector containing each variable name. You will need to add or subtract
##  variables based on your needs. Make sure you simply hit "Enter" after typing the name for 
##  the last variable (now, variable8, to the right of the arrow) and continue in this same format. 

variables <- c(
  variable1 <- 
  variable2 <- 
  variable3 <- 
  variable4 <- 
  variable5 <- 
  variable6 <- 
  variable7 <- 
  variable8 <- 
)


######################################################################################################
########################################                     #########################################
########################################   Formatting Files  #########################################
########################################                     #########################################
######################################################################################################

##  Now, sort your data file into the format needed for ReCal. This will include a global reliability
##   test in which agreement between coders for the entire dataset will be calculated, followed by 
##   local reliability tests for each individual variable.

##  If you would like, you can simply highlight the following section (until just above the "Sample
##   Result Section") and run that code. You do not need to change any of this code.

### ----------------------------------------------------------------------------------------------- ###

## Group each variable into one spreadsheet. It will be saved as a .txt file that is named after the 
##  the variable itself. These will need to be converted to .csv files (you can do this by simply
##  adding ".csv" to the file name).

##  First, we'll create a new folder for your files to be saved into.

dir.create("Output")
setwd("Output")

for(i in variables){
  filename <- str_c(i, ".csv", sep ="")
  select(mydata, ends_with(i)) %>%
    write.table(file = filename, sep = ",", na = "99", row.names = FALSE, col.names = FALSE)
}

### ----------------------------------------------------------------------------------------------- ###

## Create global reliability file -- move each variable into a single column for each rater, write csv

## Get listing of .csv files

filelist <- list.files(getwd(), pattern="*.csv")

## Combine each data file that was previously exported into the new matrix. This means first creating
##  an object for the overall reliability, which will just be the first file in your folder, and then
##  attaching each subsequent file to the bottom of it.

## Create the file

OverallReliability <- read.table(file = filelist[1], header = FALSE, sep = ",")

## Combine files

for(i in 2:length(filelist)){
  nextfile <- read.table(filelist[i], header = FALSE, sep = ",")
  OverallReliability <- rbind(OverallReliability, nextfile)
}

## Now, save this file to your working directory (the "Output" folder)

write.table(OverallReliability, file = "OverallReliability.csv", sep = ",", row.names = FALSE, 
            col.names = FALSE)

### ----------------------------------------------------------------------------------------------- ###

##  Your files should now be in the appropriate formaat for ReCal. You should spot-check them quickly
##   to ensure this is correct. Once you do this, go to http://dfreelon.org/utils/recalfront/recal3/ 
##   and find the "Choose File" button that is located in the orange box (just prior to the 
##   "Documentation"). Select your file and then click the "Calculate Reliability" button located just
##   to the right of the "Choose File" button.
