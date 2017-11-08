#########################################################################################################
#########################################################################################################
##############################                                              #############################
##############################        Generic Web Site Scrape               #############################
##############################                                              #############################
#########################################################################################################
#########################################################################################################


###### This code will not work with social media sites such as YouTube, Facebook, or Twitter. For these 
###### sites you will need additional code that an api.


###### You will need selectorgadget, a plug in for Chrome, or a indepth understanding of html code and how to 
###### view it on your web browser of choice. You can find the plugin here:  http://selectorgadget.com/


# Step 1: Install the following packages, which will be used in the social media data collection
# The packages only need to be installed once. They will still be installed next time you use the codes.


install.packages("httr")
if (!"devtools" %in% installed.packages()) install.packages("devtools")
installAllDependencies <- function () {
  require(tools)
  tempVar <- package_dependencies("SocialMediaLab")
  dependsVec <- c()
  for (i in 1:length(tempVar$SocialMediaLab)) {
    dependsVec <- c(dependsVec,package_dependencies(tempVar$SocialMediaLab[i]))
  }
  results <- unlist(dependsVec)
  results <- unique(results)
  for (i in 1:length(results)) {
    install.packages(results[i])
  }
}
installAllDependencies()
if (!"SocialMediaLab" %in% installed.packages()) {
  devtools::install_github("voson-lab/SocialMediaLab/SocialMediaLab")
}
if (!"magrittr" %in% installed.packages()) install.packages("magrittr")
if (!"igraph" %in% installed.packages()) install.packages("igraph")
if (!"twitteR" %in% installed.packages()) install.packages("twitteR")



# Step 2: Load required packages before you run the below codes.
# you need to load the packages every time you run the below codes. 


require(devtools)
require(SocialMediaLab)
require(magrittr)
require(igraph)
require(twitteR)
require(httr)
require(xml2)
require(rvest)

# Step 3: Set your work directory

setwd("/Users/XXX") # you can replace XXX with the file directory

# Step 4: Specifying the url for desired website to be scrapped
# Just copy and past the url from your web browser. This is the exact page you will be scraping 



url <- 'https://www.xxx'     ### Replace xxx with the rest of the url you are going to. 

# Step 5: instruct R to reading the HTML code from the website

webpage <- read_html(url)


# Scrapping text from the webpage, using css slectors.
### use selectorgadget on your webpage. Activate selectorgadget, and click on the item you want to scrape
### You will see the name of that item on the botom of the screen.



yyy_data_html <- html_nodes(webpage,'.xxx') ### replace yyy with the name of variable. replace .xxx with the name you got from selectorgadget


#Converting your scrapped item data to text

yyy_data <- html_text(yyy_data_html)  ## replacy yyy with the name of variable

#Take a look at the data

head(yyy_data)   ## replacy yyy with the name of variable


### at this point you may see junk text in your data. html code that is scrapped with your data. For example, say your 
### data has a "/" before the actual text you want. To remove the junk data do the following

yyy_data<-gsub("/","",yyy_data)  ## This script removes all instances of "/" 

### now check the data again, to insure that all the junk text is removed from your data.

head(yyy_data)   ## replacy yyy with the name of variable


#### But what if you're scapping numbers and not text. Follow all of the above scrypt. once the data has been converted
#### to text, and all junk text has been removed, do the following.


yyy_data<-gsub(",","",yyy_data) ### this removes all comas from the data. Run this even if you don't see any comas. If there
### are any comas that aren't removed the data will not correctly convert to numbericals 


yyy_data<-as.numeric(yyy_data)  ### This converts the text to numbers

# and... look at your data again. Make sure it's all good.

head(filesize_data)

#####################################################################################################################
#####################################################################################################################
#####                                                                                                           #####
#####   Repeat the above script for each item you want to scrape from the web page. nameing each varaible       #####
#####   differently, obviously. Once you've scraped all the data you want, it's time to put it all into a       #####
#####   single data frame and save it as a .csv file.                                                           #####
#####                                                                                                           #####
#####################################################################################################################
#####################################################################################################################



### First step, combind all your lists/variables into a single data frame


xxx_df<-data.frame(variable1 = variable1_data, variable2 = variable2_data,
                    variable3 = variable3_data, variable4 = variable4_data,
                    variable5 = variable5_data)  ## replace xxx with your data frame name. 


write.csv(xxx_df, file="xxx_data.csv")  # replace xxx with your data frame name. 





######################################################################################################################
######################################################################################################################
#####                                                                                                            #####
##### And you're done. The .csv file of the data should be saved in your work directory                          #####
#####                                                                                                            #####
######################################################################################################################
######################################################################################################################





