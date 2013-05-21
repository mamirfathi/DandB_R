#################
#Aggregating data
#################
titanic <- read.csv(file='titanic.csv', as.is=T, header=T)

##table
?table
table(titanic$sex)

table(titanic$sex, titanic$survived)

prop.table(table(titanic$sex, titanic$survived))

table(titanic$sex, titanic$survived)/nrow(titanic)


fem <- subset(titanic, titanic$sex == 'female')

table(fem$pclass, fem$survived)

##tapply
tapply(fem$fare, fem$survived, mean)

       
tapply(titanic$age,titanic$sex,mean) 

tapply(titanic$age,titanic$pclass,mean,na.rm=T) #tells R to exclude missing values


##aggregate
aggregate(age~pclass+sex,FUN=mean,data=titanic) 

##ddply
library(plyr)
?ddply
ddply(titanic, .(sex,pclass),summarize,
      mean = mean(age),
      sd = sd(age),
      max = max(age),
      iqr = IQR(age))

ddply(titanic, .(sex,pclass),summarize,
      mean = mean(age, na.rm = TRUE),
      sd = sd(age, na.rm = TRUE),
      max = max(age, na.rm=TRUE),
      iqr = IQR(age,na.rm=TRUE))