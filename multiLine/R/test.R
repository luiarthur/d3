source("multiLinePlot.R")

m <- cbind(1:100,rnorm(100,30),rnorm(100,35))
#colnames(m) <- c("x","a1","$$\\alpha$$")
multiLinePlot(m,xlim=c(0,100),ylim=c(0,40),main="Multiline Plot")
