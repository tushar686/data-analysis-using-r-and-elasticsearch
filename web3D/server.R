library(shiny)
library(datasets)

# Define server logic required to plot various count against coloumnsZA
shinyServer(function(input, output) {
  
  xG <- reactive({
    switch(input$xColoumn, setFromAndToDates(input$fromToDates[1], input$fromToDates[2]))
	switch(input$xColoumn, getTwoDimensionalMatrixFromElasticsearch(input$xColoumn))
  })
  
  yG <- reactive({
    switch(input$xColoumn, setFromAndToDates(input$fromToDates[1], input$fromToDates[2]))
    switch(input$yColoumn, getTwoDimensionalMatrixFromElasticsearch(input$yColoumn) )
  })
  
  xsysMatrix <- reactive({
	switch(input$xColoumn, getXYsMatrixFromElasticsearch(xG(), yG(), input$xColoumn, input$yColoumn))
	switch(input$yColoumn, getXYsMatrixFromElasticsearch(xG(), yG(), input$xColoumn, input$yColoumn))
  })

  xsMatrixForFixY <- reactive({
	switch(input$fixY, if(input$fixY %in% yG()[,1]) getXsMatrixFromElasticsearch(input$fixY, input$xColoumn, input$yColoumn) )
  })
  
  xsCFLTopMatrixForFixY <- reactive({
	switch(input$fixY, if(input$fixY %in% yG()[,1]) getXYsMatrixFromElasticsearch(xG(), as.matrix(input$fixY), input$xColoumn, input$yColoumn) )
  })
  
  ysMatrixForFixX <- reactive({
	switch(input$fixX, if(input$fixX %in% xG()[,1]) getXsMatrixFromElasticsearch(input$fixX, input$yColoumn, input$xColoumn) )
  })
  
  ysCFLTopMatrixForFixX <- reactive({
	switch(input$fixX, if(input$fixX %in% xG()[,1]) getXYsMatrixFromElasticsearch(as.matrix(input$fixX), yG(), input$xColoumn, input$yColoumn) )
  })
  
  graphType <- reactive({
	switch(input$graphType, if(input$graphType == 'bar') TRUE else FALSE )
  })
  
  output$xGTable <- renderTable({
    head(xG(), 10)
  })
  
  output$yGTable <- renderTable({
    head(yG(), 10)
  })
  
  output$xsysTable <- renderTable({
    head(xsysMatrix(), 10)
  })
  
  output$ysxsTable <- renderTable({
    head(t(xsysMatrix()), 10)
  })

  output$ownTopXsForFixYTable <- renderTable({
    head(xsMatrixForFixY(), 10)
  })
  
  output$cflTopXsForFixYTable <- renderTable({
    head(xsCFLTopMatrixForFixY(), 10)
  })
  
  output$ownTopYsForFixXTable <- renderTable({
    head(ysMatrixForFixX(), 10)
  })
  
  output$cflTopYsForFixXTable <- renderTable({
    topMatrix = matrix(ncol=10, nrow = 2)
	topMatrix[1,] = t(yG()[,1])
	if(!is.null(ysCFLTopMatrixForFixX())) {
		topMatrix[2,] = t(ysCFLTopMatrixForFixX()[,1])
	}
	head(topMatrix)
  })
  
  output$xG <- renderPlot({
	xG <- xG()	
	barplot(as.numeric(xG[,2]), main=input$xColoumn, xlab=input$xColoumn, ylab="Count", names.arg=paste(xG[,1]), col=rainbow(rainbowColor) )
    legend("topright", legend=paste(xG[,1]), fill=rainbow(rainbowColor))
  })
  
  output$yG <- renderPlot({
	yG <- yG()
	barplot(as.numeric(yG[,2]), main=input$yColoumn, xlab=input$yColoumn, ylab="Count", names.arg=paste(yG[,1]), col=rainbow(rainbowColor) )
    legend("topright", legend=paste(yG[,1]), fill=rainbow(rainbowColor))
  })
  
  output$xsys <- renderPlot({
	xG <- xG()
	yG <- yG()
	barplot(xsysMatrix(), main=paste(input$xColoumn, "s"," vs ", input$yColoumn, "s", sep=""), xlab= input$xColoumn, ylab= "Count", beside=graphType(), names.arg=xG[,1], col=rainbow(rainbowColor))
	legend("topright", legend=paste(yG[,1]), fill=rainbow(rainbowColor)) 
  })
  
  output$flip_xsys <- renderPlot({
	xG <- xG()
	yG <- yG()	
	ysxsMatrix = t(xsysMatrix())
	barplot(ysxsMatrix, main=paste(input$yColoumn, "s"," vs ", input$xColoumn, "s", sep=""), xlab= input$yColoumn, ylab= "Count", beside=graphType(), names.arg=yG[,1], col=rainbow(rainbowColor))
	legend("topright", legend=paste(xG[,1]), fill=rainbow(rainbowColor)) 
  })
  
  output$ownTopXsForFixY <- renderPlot({
	if(length(xsMatrixForFixY()[2,]) != 0) {
		xG <- xG()
		yG <- yG()
		barplot(as.numeric(xsMatrixForFixY()[2,]), main=paste(input$xColoumn,"vs", input$yColoumn,input$fixY), xlab= input$xColoumn, ylab= "Count", names.arg=xsMatrixForFixY()[1,], col=rainbow(rainbowColor))
		legend("topright", legend=paste(xsMatrixForFixY()[1,]), fill=rainbow(rainbowColor))
	}	
  })
  
  output$cflTopXsForFixY <- renderPlot({
	if(length(xsCFLTopMatrixForFixY()[1,]) != 0) {
		xG <- xG()
		yG <- yG()
		barplot(as.numeric(xsCFLTopMatrixForFixY()[1,]), main=paste(input$xColoumn,"vs", input$yColoumn,input$fixY), xlab= input$xColoumn, ylab= "Count", names.arg=paste(xG()[,1]), col=rainbow(rainbowColor))
		legend("topright", legend=paste(xG()[,1]), fill=rainbow(rainbowColor))
	}	
  })
  
  output$ownTopYsForFixX <- renderPlot({
	if(length(ysMatrixForFixX()[2,]) != 0) {
		xG <- xG()
		yG <- yG()
		barplot(as.numeric(ysMatrixForFixX()[2,]), main=paste(input$yColoumn,"vs", input$xColoumn,input$fixX), xlab= input$yColoumn, ylab= "Count", names.arg=ysMatrixForFixX()[1,], col=rainbow(rainbowColor))
		legend("topright", legend=paste(ysMatrixForFixX()[1,]), fill=rainbow(rainbowColor))
	}	
  })
  
  output$cflTopYsForFixX <- renderPlot({
	if(length(ysCFLTopMatrixForFixX()[1,]) != 0) {
		xG <- xG()
		yG <- yG()
		
		barplot(as.numeric(t(ysCFLTopMatrixForFixX()[,1])), main=paste(input$yColoumn,"vs", input$xColoumn,input$fixY), xlab= input$yColoumn, ylab= "Count", names.arg=paste(yG()[,1]), col=rainbow(rainbowColor))
		legend("topright", legend=paste(yG()[,1]), fill=rainbow(rainbowColor))
	}	
  })
  
  output$histogramByYear <- renderPlot({
	xG <- xG()
	reportCountByYear= getReportCountOverDateRange('year', 'yyy')
	barplot(as.numeric(reportCountByYear[,2]), main="ReportCount", xlab="Year", ylab="Count", names.arg=paste(reportCountByYear[,1]), col=rainbow(rainbowColor) )
	legend("topleft", legend=paste(reportCountByYear[,1]), fill=rainbow(rainbowColor))
  })
  
  output$histogramByMonth <- renderPlot({
	setFromAndToDates(input$fromToDatesHist[1], input$fromToDatesHist[2])
	reportCountByMonth= getReportCountOverDateRange('month', 'MM-yyy')
	barplot(as.numeric(reportCountByMonth[,2]), main="ReportCount", xlab="Month", ylab="Count", names.arg=paste(reportCountByMonth[,1]), col=rainbow(rainbowColor) )
	legend("topleft", legend=paste(reportCountByMonth[,1]), fill=rainbow(rainbowColor))
  })
})