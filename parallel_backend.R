library(doSNOW)
library(doParallel)
library(doMC)

#set up parallel backend (windows) doesn't support forking
?detectCores
?makeCluster

num<-max(detectCores()-2,1)
cluster <-makeCluster(num, type = "SOCK")
registerDoSNOW(cluster)
getDoParWorkers()

#set up parallel backend (mac OSX, linux) 
forkcluster <- makeCluster(num, type = "FORK")
registerDoSNOW(forkcluster)
getDoParWorkers()