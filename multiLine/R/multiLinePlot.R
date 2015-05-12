multiLinePlot <- function(xY,xlim=NULL,ylim=NULL,main=NULL,linkToTemplate=NULL) { 
  # xY is a matrix with first column being a vector of x values, common across all y's.
  # The remaining columns are the different y vectors.
  # The function currently only works properly if the x column is named
  # and the Y columns are all uniquely named
  if (any(colnames(xY)=="") || any(is.null(colnames(xY)))) {
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

  if (!is.null(xlim)) {
    html <- gsub("<myXLimLower>",toString(xlim[1]),html)
    html <- gsub("<myXLimUpper>",toString(xlim[2]),html)
  } else {
    html <- gsub("<myXLimLower>",toString(min(xY[,1])),html)
    html <- gsub("<myXLimUpper>",toString(max(xY[,1])),html)
  }
  if (!is.null(ylim))  {
    html <- gsub("<myYLimLower>",toString(ylim[1]),html)
    html <- gsub("<myYLimUpper>",toString(ylim[2]),html)
  } else {
    html <- gsub("<myYLimLower>",toString(min(xY[,-1])),html)
    html <- gsub("<myYLimUpper>",toString(max(xY[,-1])),html)
  }

  if (!is.null(main)) html <- gsub("<!--myMAIN-->",paste0("<h1>",main,"</h1>"),html)

  writeLines(html,"myMultiLinePlot/index.html")
  system('cd myMultiLinePlot; python -m webbrowser -t "http://localhost:4104"')
  system("cd myMultiLinePlot; python -m SimpleHTTPServer 4104")
}

# Example:
#m <- cbind(1:100,rnorm(100,30),rnorm(100,35))
#multiLinePlot(m)
