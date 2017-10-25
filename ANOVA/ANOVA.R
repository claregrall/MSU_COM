##### This is how to do a basic One-Way Analysis of Variance.
##### The variables are Movie (IV, nominal) and Enjoyment (DV, ratio).


##getwd() allows you to see what directory you're working from
## and shows this below in the console.If you want a different
## directory, hit setwd(), and insert directory in parentheses

getwd()

## Now to grab a dataset. Make sure it's a csv for read.csv to work.
## Also, make sure data are stacked, so that each variable's scores
## are in one row.

## This commmand brings up the directory where you can find your csv.
## Header=TRUE tells R to use the first row as variable names.

data1 <- read.csv(file.choose(), header=TRUE)

## Make sure the variables are named what you want them (i.e, 
## what's in the header of your csv.)

names(data1)

## Once variable names are correct, you can do ANOVA. Put the numeric
## variable (DV) first, then the nominal factor (IV)

aov(Enjoyment~Movie)

## Now name the ANOVA so you can reference it.

ANOVA1 <- aov(Enjoyment~Movie)

## You can look at summaries

summary(ANOVA1)

## Boxplots

boxplot(Enjoyment~Movie)
