##################
#visualizing data
##################
packages <- c("ggplot2", "lattice")
lapply(packages, require, character.only=T)


titanic <- read.csv(file='titanic.csv', header=T, as.is=T)


#plot 
?plot
plot(titanic$age, titanic$fare)
plot(titanic[c(5,9)])
plot(titanic[titanic$sex=='female',c(5,9)])
plot(titanic[titanic$sex=='male',c(5,9)])

#args
plot(titanic$age, titanic$fare, 
     main="age/fare scatter", #title
     cex.main=2, #title size
     ylab="Fare", #y axis title
     xlab="Age", #x axis title
     cex.lab=2, #axis title size
     col="dodgerblue", #color
     pch = 6,# symbol
     cex=1.5, #symbol size
     bty= 'none', # remove border
     cex.axis=1.6, #axis size
     las=1 #makes y axis labels horizontal  
     )
          

#barplot
barplot(table(titanic$sex),
        #horiz=T, # plot horizontally 
        main="Sex",
        cex.main=2,
        ylab="count",
        cex.lab=2,
        col="dodgerblue")

#boxplot
boxplot(titanic$age,
        main= 'Age',
        col='dodgerblue')

boxplot(titanic$age~as.factor(titanic$pclass)+as.factor(titanic$sex),
        main='Age by Sex+Class',
        col=c(2,3,4))

#multiple plots in same window
?par
par(mfrow=c(2,2))

barplot(table(titanic$sex),
        #horiz=T, # plot horizontally 
        main="Sex",
        cex.main=2,
        ylab="count",
        cex.lab=2,
        col="dodgerblue")

barplot(table(titanic$sex),
        horiz=T, # plot horizontally 
        main="Sex",
        cex.main=2,
        ylab="count",
        cex.lab=2,
        col="dodgerblue")

boxplot(titanic$age,
        main= 'Age',
        col='dodgerblue')

plot(titanic$age, titanic$fare)

#ggplot2
