numberOfRecordsToFetch = 10
rainbowColor = 10
clients = getTwoDimensionalData("ClientID", numberOfRecordsToFetch, "DESC")
types = getTwoDimensionalData("Type", numberOfRecordsToFetch, "DESC")
statuses = getTwoDimensionalData("Status", numberOfRecordsToFetch, "DESC")
languages = getTwoDimensionalData("Language", numberOfRecordsToFetch, "DESC")
centerPointCountries = getTwoDimensionalData("CenterPointCountry", numberOfRecordsToFetch, "DESC")
centerPointContinents = getTwoDimensionalData("CenterPointContinent", numberOfRecordsToFetch, "DESC")

barplot(c(clients$recordCount), names.arg=paste(clients$ClientID), main="Client", xlab="Client", ylab="Count", col=rainbow(rainbowColor) )
legend("topright", legend=paste(clients$ClientID), fill=rainbow(rainbowColor))

barplot(c(types$recordCount), main="AnomalyType", xlab="Type", ylab="Count", col=rainbow(rainbowColor) )
legend("topright", legend=paste(types$Type), fill=rainbow(rainbowColor))

barplot(c(statuses$recordCount), names.arg=paste(statuses$Status), main="Status", xlab="Status", ylab="Count", col=rainbow(rainbowColor) )
legend("topright", legend=paste(statuses$Status), fill=rainbow(rainbowColor))

barplot(c(languages$recordCount), names.arg=paste(languages$Language), main="Language", xlab="Language", ylab="Count", col=rainbow(rainbowColor) )
legend("topright", legend=paste(languages$Language), fill=rainbow(rainbowColor))

barplot(c(centerPointCountries$recordCount), names.arg=paste(centerPointCountries$CenterPointCountry), main="CenterPointCountry", xlab="CenterPointCountry", ylab="Count", col=rainbow(rainbowColor) )
legend("topright", legend=paste(centerPointCountries$CenterPointCountry), fill=rainbow(rainbowColor))

barplot(c(centerPointContinents$recordCount), names.arg=paste(centerPointContinents$CenterPointContinent), main="CenterPointContinent", xlab="CenterPointContinent", ylab="Count", col=rainbow(rainbowColor) )
legend("topright", legend=paste(centerPointContinents$CenterPointContinent), fill=rainbow(rainbowColor))