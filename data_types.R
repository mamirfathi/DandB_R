############
#data types
############

titanic <- read.csv(file="titanic.csv", header=T, as.is=T) 


      ##Factors

#converts the character vector into a factor
class(titanic$sex) #character
titanic$sex <- as.factor(titanic$sex) 


      ##Ordered Factors

#converts the int vector into an ordered factor
class(titanic$pclass) #integer
titanic$pclass <- as.ordered(titanic$pclass)


#Dates
library(lubridate)

dates <- c('2012.01.06', '2012.05.01',
           '2012/10/23', '2012/02/22', 
           '2011-12-09', '2011.12.12', 
           '2011-12-13')

class(dates) #character 

?ymd
dates<-ymd(dates)
class(dates) #POSIXct format

year(dates) #extracts year
month(dates) #extracts month
wday(dates) #extracts day of the week
