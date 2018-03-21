rainbowColor = 10
xSize=10

setFromAndToDates("2013-08-01", "2015-01-01")
clients = getTwoDimensionalMatrixFromElasticsearch("ClientID")

types = getTwoDimensionalMatrixFromElasticsearch("Type")
statuses = getTwoDimensionalMatrixFromElasticsearch("Status")
languages = getTwoDimensionalMatrixFromElasticsearch("Language")
centerPointCountries = getTwoDimensionalMatrixFromElasticsearch("CenterPointCountry")
centerPointContinents = getTwoDimensionalMatrixFromElasticsearch("CenterPointContinent")

barplot(as.numeric(clients[,2]), main="Client", xlab="Client", ylab="Count", names.arg=paste(clients[,1]), col=rainbow(rainbowColor) )
legend("topright", legend=paste(clients[,1]), fill=rainbow(rainbowColor))

barplot(as.numeric(types[,2]), main="AnomalyType", xlab="Type", ylab="Count", names.arg=paste(types[,1]), col=rainbow(rainbowColor) )
legend("topright", legend=paste(types[,1]), fill=rainbow(rainbowColor))

barplot(as.numeric(statuses[,2]), main="Status", xlab="Status", ylab="Count", names.arg=paste(statuses[,1]), col=rainbow(rainbowColor) )
legend("topright", legend=paste(statuses[,1]), fill=rainbow(rainbowColor))

barplot(as.numeric(languages[,2]), main="Language", xlab="Language", ylab="Count", names.arg=paste(languages[,1]), col=rainbow(rainbowColor) )
legend("topright", legend=paste(languages[,1]), fill=rainbow(rainbowColor))

barplot(as.numeric(centerPointCountries[,2]), main="CenterPointCountry", xlab="CenterPointCountry", ylab="Count", names.arg=paste(centerPointCountries[,1]), col=rainbow(rainbowColor) )
legend("topright", legend=paste(centerPointCountries[,1]), fill=rainbow(rainbowColor))

barplot(as.numeric(centerPointContinents[,2]), main="CenterPointContinent", xlab="CenterPointContinent", ylab="Count", names.arg=paste(centerPointContinents[,1]), col=rainbow(rainbowColor) )
legend("topright", legend=paste(centerPointContinents[,1]), fill=rainbow(rainbowColor))
