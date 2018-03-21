getXYsMatrixFromElasticsearch <- function(x, y, xColoumn, yColoumn) {
  xsYsMatrix = matrix(0, nrow = dim(y)[1], ncol = dim(x)[1], byrow=TRUE)
  index = 1
  for(subY in y[,1]) { 
    xsForASubY = getResponseJSONFromElasticsearch(x, subY, xColoumn, yColoumn)
    xsYsMatrix[index,] = getXsCountForASubYJSON(xsForASubY, x, y)
    index = index + 1
  }
  return(xsYsMatrix)
}

getXsCountForASubYJSON <- function(xsForASubY, x, y) {
  xsCount = matrix(0, ncol=dim(x)[1], nrow = 1)
  
  index = 1
  for(subX in as.matrix(x[,1])) {
    xsCount[,index] = getRecordCountFromXOfASubYJSON(xsForASubY, subX)
    index = index + 1
  }
  return(xsCount)
}

getRecordCountFromXOfASubYJSON = function(xsForASubY, subX) {
  index = 1
  for(subXForSubY in xsForASubY$aggregations$for_y$for_xs$for_dates$group_by_xs$buckets) {
    if(!is.na(subX) & subXForSubY$key == tolower(c(subX))) {
      return(subXForSubY$doc_count)
    }
    index = index + 1
  }
  return(0)
}

getResponseJSONFromElasticsearch <- function(x, subY, xColoumn, yColoumn) {
  library(httr)
  aggregationQuery = getAggregationQueryForY(x, xColoumn, subY, yColoumn)
  response <- POST("http://localhost:9200/cflrepository/_search", body = aggregationQuery)
  stop_for_status(response)
  return(content(response, "parsed", "application/json"))
}

getAggregationQueryForY <- function(x, xColoumn, subY, yColoumn) {
    prefix = '{"size":0,"aggs":{"for_y":{"filter":'
    boolY = getBoolFilterForY(subY, yColoumn)
    prefixOr = ',"aggs":{"for_xs":{"filter":{"or":['
    orFilter = paste(getOrFilterForXs(x, xColoumn), ']},', sep="")
    for_dates = getForDatesAggregationQuery()
    suffix = paste('"aggs":{"group_by_xs":{"terms":{"field":"', xColoumn, '"}}}}}}}}}}', sep="")
    
    body = paste(prefix, boolY, prefixOr, orFilter, for_dates, suffix, sep="")
    return(body)
}

getBoolFilterForY <- function(subY, yColoumn) {
    bool = paste('{"bool":{"must":{"term":{"', yColoumn, '":"', tolower(c(subY)) ,'"}}}}', sep="")
}

getOrFilterForXs <- function(x, xColoumn) {
  xIndex = 1
  orFilter = ""
  for(subX in x[,1]) {
    subX = tolower(c(subX))
    if(xIndex == 1)
      orFilter = paste('{"term":{"', xColoumn, '":"', subX, '"}}', sep="")
    else
      orFilter = paste(orFilter, ',{"term":{"', xColoumn, '":"', subX, '"}}', sep="")
    xIndex = xIndex + 1
  }
  return(orFilter)  
}