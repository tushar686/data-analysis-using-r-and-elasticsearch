
getXYMatrix = function(x, y, xColoumn, yColoumn) {
  xsYsMatrix = matrix(0, nrow = dim(y)[1], ncol = dim(x)[1], byrow=TRUE)
  index = 1
  for(subY in y[,1]) {
    xsForASubY = getThreeDimensionalData(xColoumn, yColoumn, paste(shQuote(x[,1], type="sh"), collapse=", "), subY, "DESC")
    xsYsMatrix[index,] = getXsCountForASubY(xsForASubY, x, y)
    index = index + 1
  }
  return(xsYsMatrix)
}

getXsCountForASubY <- function(xsForASubY, x, y) {
  xsCount = matrix(0, ncol=dim(x)[1], nrow = 1)
  
  index = 1
  for(subX in as.matrix(x[,1])) {
    xsCount[,index] = getRecordCountFromXOfASubY(xsForASubY, subX)
    index = index + 1
  }  
  return(xsCount)
}

getRecordCountFromXOfASubY = function(xsForASubY, subX) {
  index = 1
  for(subXForSubY in xsForASubY[,1]) {
    if(subXForSubY == subX) {
      return(as.matrix(xsForASubY[2])[index])
    }
    index = index + 1
  }
  return(0)
}