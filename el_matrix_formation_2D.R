getTwoDimensionalMatrixFromElasticsearch <- function(coloumnName) {
  responseJSON = getResponseJSON_For_Coloumn(coloumnName)
  return(getValueAndCount(responseJSON))
}

getValueAndCount <- function(tops) {
  topMatrix = matrix(0, ncol=2, nrow = xSize)
  
  index = 1
  for(top in tops$aggregations$for_dates$group_by_coloumn$buckets) {
    topMatrix[index, 1] = top$key
    topMatrix[index, 2] = as.numeric(top$doc_count)
    index = index + 1
  }
  return(topMatrix)
}

getResponseJSON_For_Coloumn <- function(coloumnName) {
  library(httr)
  aggregationQuery = getAggregationQueryForTop(coloumnName)
  response <- POST("http://localhost:9200/cflrepository/_search", body = aggregationQuery)
  stop_for_status(response)
  return(content(response, "parsed", "application/json"))
}

getAggregationQueryForTop <- function(coloumnName) {
  prefix = '{"size":0,'
  
  group_by_coloumn = paste('"aggs":{"group_by_coloumn":{"terms":{"field":"', coloumnName, '"}}}', sep="")
  suffix = '}}}'
  for_dates = getForDatesAggregationQuery()
  body = paste(prefix, for_dates, group_by_coloumn, suffix, sep="")  
  return(body)
}

getForDatesAggregationQuery <- function() {
  for_dates = paste('"aggs":{"for_dates":{"filter":{"range":{"SubmissionDate":{"from":"', fromSubmissionDate, '","to":"', toSubmissionDate, '"}}},', sep="")
  return(for_dates)
}

setFromAndToDates <- function(from, to) {
  fromSubmissionDate <<- from
  toSubmissionDate <<- to
}