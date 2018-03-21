rainbowColor = 10

typesClientsMatrix = getXYMatrix(types, clients, "Type", "ClientID")
clientsTypesMatrix = getXYMatrix(clients, types, "ClientID", "Type")

statusesClientsMatrix = getXYMatrix(statuses, clients, "Status", "ClientID")
clientsStatusesMatrix = getXYMatrix(clients, statuses, "ClientID", "Status")

clientsLanguagesMatrix = getXYMatrix(clients, languages, "ClientID", "Language")

#types vs client
barplot(typesClientsMatrix, main="Types vs Client", xlab= "Type", ylab= "Count", beside=FALSE, names.arg=types[,1], col=rainbow(rainbowColor))
legend("topright", legend=paste(clients[,1]), fill=rainbow(rainbowColor))
#Flip
barplot(clientsTypesMatrix, main="Client vs Types", xlab= "Client", ylab= "Count", beside=FALSE, names.arg=clients[,1], col=rainbow(rainbowColor))
legend("topright", legend=paste(types[,1]), fill=rainbow(rainbowColor))


#status vs client
barplot(statusesClientsMatrix, main="Status vs Client", xlab= "Status", ylab= "Count", beside=FALSE, names.arg=statuses[,1], col=rainbow(rainbowColor))
legend("topright", legend=paste(clients[,1]), fill=rainbow(rainbowColor))
#Flip
rainbowColor = 4
barplot(clientsStatusesMatrix, main="Client vs Status", xlab= "Client", ylab= "Count", beside=FALSE, names.arg=clients[,1], col=rainbow(rainbowColor))
legend("topright", legend=paste(statuses[,1]), fill=rainbow(rainbowColor))

#client vs language
barplot(clientsLanguagesMatrix, main="Client vs Language", xlab= "Client", ylab= "Count", beside=FALSE, names.arg=clients[,1], col=rainbow(rainbowColor))
legend("topright", legend=paste(languages[,1]), fill=rainbow(rainbowColor))