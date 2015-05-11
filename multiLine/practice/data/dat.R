set.seed(5)
k <- 10
n <- 100
delta <- 20/k

x <- 1:n
y <- matrix(0,n,k)
y[,1] <- rnorm(n,30,sd=10)
for (j in 2:k) y[,j] <- delta + y[,j-1]
#y <- apply(matrix(1:k),1,function(dummy) rnorm(n,runif(n,30,70),sd=10))

#plot(x,y[,3])
out <- cbind(x,y)
colnames(out) <- c("x",paste0("y",1:k))
write.table(out,file="sim1.tsv",quote=F,row.names=F,sep="\t")
