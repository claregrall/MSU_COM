# Summary: This script runs a CFA and SEM in Lavaan on a data set that tests how
# audiences come to like morally ambiguous characters, namely protagonists that behave
# immorally, through content cues that vary within a narrative.

# Load packages
library(lavaan)
library(semPlot)
library(psych)
library(igraph)

# Set working directory
setwd("/Users/cgrall/Desktop/AO_Data/AO2_Data_Full.csv")

# Create object for dataset
mydata <- data.frame(read.csv("AO2_Data_Full.csv"))
View(mydata)
#describe(mydata)

#________________________________________________________________________________

# Create CFA Model
# Can be copied and pasted from CFA script output

cfa_model1 <- '
    consensus =~ PConsensus1
    distinctiveness =~ PDistinct1 + PDistinct2 + PDistinct3
    consistency =~ PConsist1 + PConsist3
    intatt =~ IntAtt1 + IntAtt2 + IntAtt4
    stimatt =~ StimAtt1 + StimAtt2 + StimAtt3 + CircAtt3
    charlike =~ CharLike1 + CharLike2 + CharLike3 + CharLike4
'

# evaluate the model
fit1 <- cfa(cfa_model1, data=mydata) 
summary(fit1, fit.measures = T, standardized = T, rsquare = T)
standardizedSolution(PAPV_fit, type = "std.all", se = TRUE, 
                     zstat = TRUE, pvalue = TRUE, remove.eq = TRUE, 
                     remove.ineq = TRUE, remove.def = FALSE,
                     GLIST = NULL, est = NULL)

fitMeasures(fit1, c("npar", "chisq", "df", "pvalue", "cfi", "rmsea", "srmr", "pclose", "nfi"))

#________________________________________________________________________________

# Create indices from CFA and write them into the data file

# CONSENSUS
# (cannot create a separate index because an array has to consist of at least
# two elements. Therefore, "idx_consens" is replaced with PConsensus1)

#consens <- mydata[,c(32)]
#mydata$idx_consens <- rowMeans(consens)
#summary(mydata$idx_consens)

# DISTINCTIVENESS
distinct <- mydata[, c(33,37,38)]
mydata$idx_distinct <- rowMeans(distinct)
summary(mydata$idx_distinct)


# CONSISTENCY
consist <- mydata[,c(34,40)]
mydata$idx_consist <- rowMeans(consist)
summary(mydata$idx_consist)

# INTERNAL ATTRIBUTION
intatt <- mydata[,c(43,44,46)]
mydata$idx_intatt <- rowMeans(intatt)
summary(mydata$idx_intatt)

# EXTERNAL ATTRIBUTION
extatt <- mydata[,c(47,48,49,52)]
mydata$idx_extatt <- rowMeans(extatt)
summary(mydata$idx_extatt)

# CHARACTER LIKING
charlike <- mydata[,c(53,54,55,56)]
mydata$idx_charlike <- rowMeans(charlike)
summary(mydata$idx_charlike)

#________________________________________________________________________________

# SEM model with indices
# Matches the Captain America Model
# Correlated the residuals of the mediators

sem_ao <-'
      PConsensus1 ~ ConsenR 
      idx_distinct ~ DistinctR
      idx_consist ~ ConsistR 
      idx_intatt ~ PConsensus1 + idx_distinct + idx_consist
      idx_extatt ~ PConsensus1 + idx_distinct 
      idx_charlike ~ idx_intatt + idx_extatt
      idx_charlike ~ PConsensus1
      PConsensus1 ~~ idx_distinct
      PConsensus1 ~~ idx_consist 
      idx_distinct ~~ idx_consist
      idx_extatt ~~ idx_intatt
'

# Evaluate the Model: Full Summary
fit_sem <- sem(sem_ao, data=mydata)
summary(fit_sem, fit.measures = T, standardized = T)

# Visualization
semPaths(fit_sem, what = "path", whatLabels = "std",layout = "tree", style = "lisrel")

# Fit Statistics: Shortcut
fitMeasures(fit_sem, c("npar", "chisq", "df", "pvalue", "cfi", "rmsea", "srmr", "pclose", "nfi"))

# Modification Indices
MI <- modindices(fit_sem)
MI[with(MI, order(-mi)), ]