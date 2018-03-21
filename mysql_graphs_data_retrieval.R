library(RODBC)
db <- odbcConnect("cflrepository")
sqlTables(db)

getTwoDimensionalData <- function(coloumn, numberOfRecordsToFetch, asc_dsc) {
  query <- paste("SELECT ", coloumn, ", Count(", coloumn, ") AS recordCount FROM cflrepository.attributedanomalies GROUP BY ", coloumn, " ORDER BY recordCount ", asc_dsc, " Limit ", numberOfRecordsToFetch)
  print(query)
  data <- sqlQuery(db, query)
  return(data)
}

getThreeDimensionalData <- function(selectColoumn, forColoumn, selectColoumnValue, forColoumnValue, asc_dsc) {
  query <- paste("SELECT ", selectColoumn, ", Count(", selectColoumn, ") AS recordCount FROM cflrepository.attributedanomalies WHERE ", forColoumn, "='", forColoumnValue, "' AND ", selectColoumn, " IN(", selectColoumnValue, ") GROUP BY ", selectColoumn, " ORDER BY ", selectColoumn, " ", asc_dsc, sep="")
  print(query)
  data <- sqlQuery(db, query)
  return(data)
}

odbcClose(db)