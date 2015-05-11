set.seed(6)
k <- 10
n <- 1000

x <- 1:n
y <- apply(matrix(1:k),1,function(dummy) rnorm(n,runif(n,30,70),sd=10))

#plot(x,y[,3])
out <- cbind(x,y)
colnames(out) <- c("x",paste0("y",1:k))
write.table(out,file="sim1.tsv",quote=F,row.names=F,sep="\t")

			
