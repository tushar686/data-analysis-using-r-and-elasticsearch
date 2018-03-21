getXsMatrixFromElasticsearch <- function(y, xColoumn, yColoumn) {
  responseJSON = getResponseJSON_For_One_Fixed_Y_FromElasticsearch(y, xColoumn, yColoumn)
  xsMatrix = getXsValueAndCountForAY(responseJSON)
  return(xsMatrix)
}

getXsValueAndCountForAY <- function(xsForAY) {
  xsValuesCount = matrix(0, ncol=xSize, nrow = 2)
  
  index = 1
  for(subXForY in xsForAY$aggregations$for_y$for_dates$group_by_xs$buckets) {
    xsValuesCount[1, index] = subXForY$key
    xsValuesCount[2, index] = as.numeric(subXForY$doc_count)
    index = index + 1
  }
  return(xsValuesCount)
}

getResponseJSON_For_One_Fixed_Y_FromElasticsearch <- function(y, xColoumn, yColoumn) {
  library(httr)
  aggregationQuery = getAggregationQueryForOneFixed_y(y, xColoumn, yColoumn)
  response <- POST("http://localhost:9200/cflrepository/_search", body = aggregationQuery)
  stop_for_status(response)
  return(content(response, "parsed", "application/json"))
}

getAggregationQueryForOneFixed_y <- function(y, xColoumn, yColoumn) {
  prefix = '{"size":0,"aggs":{"for_y":{"filter":'
  boolY = paste(getBoolFilterForY(y, yColoumn), ',', spe="")
  for_dates = getForDatesAggregationQuery()
  group_by_coloumn = paste('"aggs":{"group_by_xs":{"terms":{"field":"', xColoumn, '"}}}', sep="")
  suffix = '}}}}}'
  body = paste(prefix, boolY, for_dates, group_by_coloumn, suffix, sep="")
  return(body)
}