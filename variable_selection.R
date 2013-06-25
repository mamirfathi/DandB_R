##############################
#Variable Selection with caret
#############################
library(caret)

titanic <- read.csv(file='titanic.csv', header=T, as.is=T)
str(titanic)
summary(titanic)

#cleaning
titanic <- titanic[-c(3,8,10)] #remove name, ticket and cabin

titanic[c(1:3,8)] <- lapply(titanic[c(1:3,8)], as.factor) #create factors

#rename factor levels 
levels(titanic$survived) <- c('survived', 'died') 
levels(titanic$pclass) <- c("first", "second", "third")

#inspect data
str(titanic)
summary(titanic)


#create model matrix
y <- titanic$survived
x <- as.data.frame(model.matrix(survived~pclass+sex+age+sibsp+parch+fare+embarked,data=titanic))

age <- titanic$age

x <- as.data.frame(model.matrix(survived~pclass+sex+sibsp+parch+fare+embarked-1,data=titanic))

x <- cbind(x,age)

#impute missing data
prep <- preProcess(method="bagImpute", x)
x <- predict(prep, x)

#set up
rfec <- rfeControl(functions=rfFuncs,
                   method='boot632',
                   number=15,
                   verbose=TRUE)


system.time(RFE <- rfe(x,y,
           sizes = c(3:10),
           rfeControl = rfec))
RFE
plot(RFE)
RFE$optVariables