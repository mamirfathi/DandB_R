##################
#visualizing data
##################
packages <- c("ggplot2", "lattice")
lapply(packages, require, character.only=T)


titanic <- read.csv(file='titanic.csv', header=T, as.is=T)


    ##base R graphics:

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
            

#histogram:
par(mfrow=c(1,1)) #reset plot window
hist(titanic$age, col="dodgerblue", main="Age Histogram", xlab="Age")

#density plot
df <- density(titanic$age[which(titanic$sex=='female')],na.rm=T)
dm <- density(titanic$age[which(titanic$sex=='male')],na.rm=T)

plot(dm,col="dodgerblue",lwd=2, main="Age Density", xlab="Age")
lines(df,col="orange",lwd=2)
legend("topright", c("male","female"), lty=c(1,1), lwd=c(2,2),col=c("dodgerblue","orange") )

#scatter plot
data(mtcars)
plot(mtcars$hp, mtcars$mpg, main="MPG/HP Scatterplot",
     xlab="Car Horsepower ", ylab="Miles Per Gallon ", pch=19) 

#scatter matrix
pairs(~mpg+disp+drat+wt,data=mtcars,
      main="Simple Scatterplot Matrix")


    ##ggplot2

#quick plot
?qplot
qplot(age,data=titanic,geom="density",fill=as.factor(sex), alpha=I(.5),
      main= "age/sex density plot",ylab="Density")

#ggplot
ex <- ggplot(data=titanic)

#histogram
ex + geom_histogram(aes(x=fare,fill=as.factor(sex)),binwidth=25)

#boxplot
ex + geom_boxplot(aes(x=as.factor(pclass),y=fare))

#barplot
ex  <- ggplot(data=titanic, aes(x=as.factor(pclass)))

ex+geom_bar()+labs(title='Standard Bar Graph')  #standard bar

ex+geom_bar(aes(fill=sex))+labs(title='Filled by sex') #put colors in by another variables

ex+geom_bar(aes(fill=sex),position='fill')+labs(title='A stacked Ratio using "position=fill"') # stacked ratio

ex+geom_bar(aes(fill=sex),position='dodge')+labs(title='Side by Side, using "position=dodge"') #put them side by side

#scales + facets
ex<-ggplot(data=titanic,aes(x=age,y=fare))
ex1<-ex+geom_point(aes(shape=as.factor(pclass)))+labs(title='Different Shapes for different classes')
ex1

ex2<-ex+geom_point(alpha=0.25,aes(shape=as.factor(pclass)))+labs(title='Different Shapes with Transparency')
ex2

ex3<-ex1+facet_grid(survived~sex)+labs(title='survived/sex facet grid')
ex3

ex4<-ex3+geom_smooth(method='lm',size=1)+labs(title='regression line for each facet')
ex4

    ##lattice
?densityplot
densityplot(~age|sex+as.factor(pclass), #viz formula
            data=titanic, # data
            main="density")
?histogram
histogram(~age|sex+as.factor(pclass),
          data=titanic, 
          main="histogram")
?xyplot
xyplot(fare~age|sex+as.factor(pclass), 
       data=titanic,
       main="scatter")