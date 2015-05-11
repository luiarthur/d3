source("multiLinePlot.R")

m <- cbind(1:100,rnorm(100,30),rnorm(100,50))
multiLinePlot(m)
