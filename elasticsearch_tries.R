library('RCurl')
library('rjson')
searchResult <- fromJSON("http://localhost:9200/cflrepository/_search?pretty -d {size:0,'aggs':{'group_by_type':{'terms':{'field':'Type'}}}}")
response <- fromJSON(searchResult)
print(response$took)
print(response$total)

library(httr)
r <- POST("http://localhost:9200/cflrepository/_search", 
          body = '{size:0,"aggs":{"group_by_type":{"terms":{"field":"Type"}}}}')
stop_for_status(r)
response <- content(r, "parsed", "application/json")

print(length(response$aggregations$group_by_type$buckets))