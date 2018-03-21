rainbowColor = 10
xSize=10
fromSubmissionDate="2001-01-08T00:00:00.000+05:30"
toSubmissionDate="2015-01-01T00:00:00.000+05:30"


typesClientsMatrixEL = getXYsMatrixFromElasticsearch(types, clients, "Type", "ClientID")
clientsTypesMatrixEL = getXYsMatrixFromElasticsearch(clients, types, "ClientID", "Type")

statusesClientsMatrixEL = getXYsMatrixFromElasticsearch(statuses, clients, "Status", "ClientID")
clientsStatusesMatrixEL = getXYsMatrixFromElasticsearch(clients, statuses, "ClientID", "Status")

languagesClientsMatrixEL = getXYsMatrixFromElasticsearch(languages, clients, "Language", "ClientID")
clientsLanguagesMatrixEL = getXYsMatrixFromElasticsearch(clients, languages, "ClientID", "Language")

languagesTypesMatrixEL = getXYsMatrixFromElasticsearch(languages, types, "Language", "Type")
typesLanguagesMatrixEL = getXYsMatrixFromElasticsearch(types, languages, "Type", "Language")

centerPointCountriesTypesMatrixEL = getXYsMatrixFromElasticsearch(centerPointCountries, types, "CenterPointCountry", "Type")
typesCenterPointCountriesMatrixEL = getXYsMatrixFromElasticsearch(types, centerPointCountries, "Type", "CenterPointCountry")

centerPointContinentsTypesMatrixEL = getXYsMatrixFromElasticsearch(centerPointContinents, types, "CenterPointContinent", "Type")
typesCenterPointContinentsMatrixEL = getXYsMatrixFromElasticsearch(types, centerPointContinents, "Type", "CenterPointContinent")

#types vs client
barplot(typesClientsMatrixEL, main="Types vs Client", xlab= "Type", ylab= "Count", beside=TRUE, names.arg=types[,1], col=rainbow(rainbowColor))
legend("topright", legend=paste(clients[,1]), fill=rainbow(rainbowColor))
#Flip
barplot(clientsTypesMatrixEL, main="Client vs Types", xlab= "Client", ylab= "Count", beside=FALSE, names.arg=clients[,1], col=rainbow(rainbowColor))
legend("topright", legend=paste(types[,1]), fill=rainbow(rainbowColor))


#status vs client
barplot(statusesClientsMatrixEL, main="Status vs Client", xlab= "Status", ylab= "Count", beside=FALSE, names.arg=statuses[,1], col=rainbow(rainbowColor))
legend("topright", legend=paste(clients[,1]), fill=rainbow(rainbowColor))
#Flip
rainbowColor = 4
barplot(clientsStatusesMatrixEL, main="Client vs Status", xlab= "Client", ylab= "Count", beside=FALSE, names.arg=clients[,1], col=rainbow(rainbowColor))
legend("topright", legend=paste(statuses[,1]), fill=rainbow(rainbowColor))

#language vs client
rainbowColor = 10
barplot(languagesClientsMatrixEL, main="Language vs Client", xlab= "Language", ylab= "Count", beside=FALSE, names.arg=languages[,1], col=rainbow(rainbowColor))
legend("topright", legend=paste(clients[,1]), fill=rainbow(rainbowColor))
#Flip
barplot(clientsLanguagesMatrixEL, main="Client vs Language", xlab= "Client", ylab= "Count", beside=FALSE, names.arg=clients[,1], col=rainbow(rainbowColor))
legend("topright", legend=paste(languages[,1]), fill=rainbow(rainbowColor))

#language vs types
barplot(languagesTypesMatrixEL, main="Language vs Type", xlab= "Language", ylab= "Count", beside=FALSE, names.arg=languages[,1], col=rainbow(rainbowColor))
legend("topright", legend=paste(types[,1]), fill=rainbow(rainbowColor))
#Flip
barplot(typesLanguagesMatrixEL, main="Type vs Language", xlab= "Type", ylab= "Count", beside=FALSE, names.arg=types[,1], col=rainbow(rainbowColor))
legend("topright", legend=paste(languages[,1]), fill=rainbow(rainbowColor))

#centerPointCountry vs types
barplot(centerPointCountriesTypesMatrixEL, main="CenterPointCountry vs Type", xlab= "CenterPointCountry", ylab= "Count", beside=FALSE, names.arg=centerPointCountries[,1], col=rainbow(rainbowColor))
legend("topright", legend=paste(types[,1]), fill=rainbow(rainbowColor))
#Flip
barplot(typesCenterPointCountriesMatrixEL, main="Type vs CenterPointCountry", xlab= "Type", ylab= "Count", beside=FALSE, names.arg=types[,1], col=rainbow(rainbowColor))
legend("topright", legend=paste(centerPointCountries[,1]), fill=rainbow(rainbowColor))

#centerPointContinent vs types
barplot(centerPointContinentsTypesMatrixEL, main="CenterPointContinent vs Type", xlab= "CenterPointContinent", ylab= "Count", beside=FALSE, names.arg=centerPointContinents[,1], col=rainbow(rainbowColor))
legend("topright", legend=paste(types[,1]), fill=rainbow(rainbowColor))
#Flip
barplot(typesCenterPointContinentsMatrixEL, main="Type vs CenterPointContinent", xlab= "Type", ylab= "Count", beside=FALSE, names.arg=types[,1], col=rainbow(rainbowColor))
legend("topright", legend=paste(centerPointContinents[,1]), fill=rainbow(rainbowColor))
