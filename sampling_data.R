#########
#Sampling
#########

titanic <- read.csv(file='titanic.csv', as.is=T, header=T)

#Sample
?sample

#without replacement
name_samp <- sample(titanic$name,200, replace=F)

head(sort(table(name_samp), decreasing=T),5) #top 5 freq

#with replacement
name_samp_rep <- sample(titanic$name,200, replace=T)

head(sort(table(name_samp_rep), decreasing=T),5) #top 5 freq

#sampling from a dataframe 
nrow(titanic)
sample(nrow(titanic))
sample(nrow(titanic),10)
titanic[sample(nrow(titanic),10),]

#Random Uniform
?runif
runif(nrow(titanic))
plot(runif(nrow(titanic)))
ten_per <- runif(nrow(titanic)) <= .1
ten<-titanic[ten_per,]
ninety<-titanic[!ten_per,]