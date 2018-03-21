getReportCountOverDateRange <- function(interval, format) {
  query = docCountOverTimeQueryHist(interval, format)
  responseJSON = getResponseJSONHist(query)  
  return(getValueAndCountHist(responseJSON))
}

getValueAndCountHist <- function(hist) {
  histMatrix = matrix(0, ncol=2, nrow = length(hist$aggregations$for_dates$reports_over_time$buckets))
  index = 1
  for(record in hist$aggregations$for_dates$reports_over_time$buckets) {
    histMatrix[index, 1] = record$key_as_string
    histMatrix[index, 2] = as.numeric(record$doc_count)
    index = index + 1
  }
  return(histMatrix)
}

getResponseJSONHist <- function(query) {
  library(httr)
  response <- POST("http://localhost:9200/cflrepository/_search", body = query)
  stop_for_status(response)
  return(content(response, "parsed", "application/json"))
}

docCountOverTimeQueryHist <- function(interval, format) {
  prefix = '{"size":0,'
  for_dates = getForDatesAggregationQuery()
  dateHistAgg = paste('"aggs":{"reports_over_time":{"date_histogram":{"format":"', format, '","field":"SubmissionDate","interval":"', interval, '"}}}', sep="")
  suffix = '}}}'
  body = paste(prefix, for_dates, dateHistAgg, suffix, sep="")  
  return(body)
}