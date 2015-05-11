multiLinePlot <- function(xY,linkToTemplate=NULL) { 
  # xY is a matrix with first column being a vector of x values, common across all y's.
  # The remaining columns are the different y vectors.
  # The function currently only works properly if the x column is named
  # and the Y columns are all uniquely named
  if (any(colnames(xY)=="")) {
    colnames(xY) <- c("x",paste0("y",1:ncol(xY[,-1])))
  }
  system("mkdir -p myMultiLinePlot")
  if (is.null(linkToTemplate)) {
    system("wget http://luiarthur.github.io/multiLineTemplate.html -O myMultiLinePlot/index.html")
  } else {
    system(paste("cp",linkToTemplate,"myMultiLinePlot/index.html"))
  }
  write.table(xY,file="myMultiLinePlot/myDat.tsv",quote=F,row.names=F,sep="\t")
  myColNames <- colnames(xY)
  html <- readLines("myMultiLinePlot/index.html")
  dataPathLines <- grep("<myDataPath>",html)
  html <- gsub("<myDataPath>","myDat.tsv",html)
  html <- gsub("<myXname>",myColNames[1],html)
  writeLines(html,"myMultiLinePlot/index.html")
  system('cd myMultiLinePlot; python -m webbrowser -t "http://localhost:4104"')
  system("cd myMultiLinePlot; python -m SimpleHTTPServer 4104")
}

# Example:
set.seed(5)
k <- 10
n <- 100
delta <- 20/k
x <- 1:n
y <- matrix(0,n,k)
y[,1] <- rnorm(n,30,sd=10)
for (j in 2:k) y[,j] <- delta + y[,j-1]
out <- cbind(x,y)
colnames(out) <- c("x",paste0("y",1:k))

multiLinePlot(out)
