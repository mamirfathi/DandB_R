library(caret)

#read in data
titanic <- read.csv(file="titanic.csv", header=T,as.is=T)

#subset
titanic <- titanic[-c(3,8,10)]

#create factors
titanic[c(1:3,5:6,8)] <- lapply(titanic[c(1:3,5:6,8)], as.factor)
str(titanic)

#create dummy vars
titanic_matrix <- as.data.frame(model.matrix(survived~.-1,data=titanic)) #-1 removes the intercept term

?dev.copy2pdf