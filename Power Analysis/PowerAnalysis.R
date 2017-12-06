#########################################################
#########################################################
############        Power Analysis      #################
#########################################################
#########################################################

install.packages("pwr")
library(pwr)

#### for each power analysis, you enter the score for 3 of the 4 items
#### and for the item you want you enter "NULL" i.e. "n=NULL"
#### for each test there's a comment on Cohen's effect size suggestion
#### in the format of small/medeum/large effects
#### The common power to use is power=0.8

################   T-Test    ############################

#### for a one sample, 2 sample, or paired t-test, use the following
#### n= sample size, d=effect size, type indicates if you want a two-sample
#### one-sample, or paired t-test
#### Cohen suggests d=0.2/0.5/0.8

pwr.t.test(n=XXX, d=xxx, sig.level=xxx, power=xxx, type=c("two.sample", "one.sample", "paired"))


####  but for a two sample with unequal n t-test, use this:

pwr.t2n.test(n1=XXX, n2=XXX, d=XXX, sig.level=XXX, power=XXX)



#### ANOVA, where k= number of groups, and n= the common sample size in each group
#### Cohen suggests f=0.1/0.25/0.4


pwr.anova.test(k=XXX, n=xxx, f=xxx, sig.level=xxx, power=xxx)




#### Correlations
#### Cohen suggests r=0.1/0.2/0.5

pwr.r.test(n=xxx, r=xxx, sig.level=xxx, power=xxx)



#### Linear Models (multiple regression)
#### u and v = numerator and denominator df. f2=effect size
#### Cohen suggests f2=0.02/0.15/0.35


pwr.f2.test(u=xxx, v=xxx, f2=xxx, sig.level=xxx, power=xxx)




#### When comparing two proportions
#### where h = effect size
#### Cohen suggests h=0.2/0.5/0.8


pwr.2p.test(h=xxx, n=xxx, sig.level=xxx, power=xxx)



#### Proportions, with unequal n's



pwr.2p2n.test(h=xxx, n1=xxx, n2=xxx, sig.level=xxx, power=xxx)



#### to test a single proportion use


pwr.p.test(h=xxx, n=xxx, sig.level=xxx, power=xxx)




#### Chi-square tests
#### where w= effect size, N=total sample size
#### Cohen suggests w=0.1/0.3/0.5

pwr.chisq.test(w=xxx, N=xxx, df=xxx, sig.level=xxx, power=xxx)







