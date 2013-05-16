#########################
#manipulating data frames
#########################

titanic <- read.csv(file='titanic.csv', as.is=T,header=T)

                                                    
#subscripting + c():
titanic_lite <- titanic[,-c(3,8,10)]

#names() + %in%
titanic_lite2 <- titanic[,names(titanic) %in% c("survived","pclass","sex","age","sibsp","parch","fare","embarked")]

#sqldf package
library(sqldf)
?sqldf
titanic_lite3 <- sqldf("select survived, pclass, sex, age, sibsp, parch, fare, embarked from titanic")


# $ operator
titanic$survived #entire vector of the survived column
titanic$survived[1:10] #first 10 rows of the survived column


#subsetting
          #with logicals
titanic_sub <- titanic[titanic$sex == 'male',] #tells R that you want all rows that have a male passenger and all columns
titanic_sub$sex #all males

          #with subset()
?subset
titanic_sub <- subset(titanic, titanic$sex=='male')


#creating new variables
?hist
hist(titanic$fare) # histogram
titanic$fare_log <- log(titanic$fare)

hist(titanic$fare_log)


#recoding variables
          #with logicals
titanic$sex[titanic$sex=='male'] <- 'm'
titanic$sex[titanic$sex=='female'] <-'f'

          #with recode
library(car)
titanic$sex <- recode(titanic$sex, "'m'='male';else='female'")


#renaming variables
names(titanic)

names(titanic) <- c("surv", "class", "name","sex", "age", "sib",
                    "par", "ticket","fare", "cabin", "embarked")
names(titanic)


#combining R objects
?rbind
          #row bind:
titanic_male <- titanic[titanic$sex=='male',]
titanic_female <- titanic[titanic$sex != 'male',]

titanic_combined <- rbind(titanic_male,titanic_female)

          #column bind:
titanic_lite <- titanic[,c(1,2,3)]
titanic_lite2 <- titanic[,-c(1,2,3)]
names(titanic_lite)
names(titanic_lite2)

titanic_combined2 <- cbind(titanic_lite,titanic_lite2)


#ordering R objects
?sort
fare_sort <- sort(titanic$fare, decreasing=TRUE) #vector
head(fare_sort)

?order
titanic_sort <- titanic[order(titanic$fare, decreasing=TRUE),]
head(titanic_sort)