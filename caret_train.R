##########################
#model building with caret
##########################
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

#create data partition
train <- runif(nrow(titanic)) <= .75
train_x <- x[train == TRUE,]
test_x <- x[train == FALSE,]

train_y <- y[train==TRUE]
test_y  <- y[train==FALSE]

#caret package
?train
?trainControl

tr <- trainControl(method='cv',
                   number=10,
                   verboseIter=TRUE)

#train random forest model
system.time(randforest <- train(train_x,
                                train_y,
                                method='rf',
                                trControl=tr,
                                #tuneGrid=expand.grid(.mtry=1:5)
                                tuneLength=5))

randforest
plot(randforest)

#score test set
pred <- predict(randforest, newdata=test_x)
table(test_y,pred)
plot(table(test_y,pred)) #plot of our confusion matrix