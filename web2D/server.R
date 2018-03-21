library(shiny)
library(datasets)

# Define server logic required to plot various count against coloumnsZA
shinyServer(function(input, output) {
  
  output$Plot2D1 <- renderPlot({
    record = getTwoDimensionalMatrixFromElasticsearch(input$coloumn1)
    barplot(as.numeric(record[,2]), main=input$coloumn1, xlab=input$coloumn1, ylab="Count", names.arg=paste(record[,1]), col=rainbow(rainbowColor) )
    legend("topright", legend=paste(record[,1]), fill=rainbow(rainbowColor))
  })
  
  output$Plot2D2 <- renderPlot({
    record = getTwoDimensionalMatrixFromElasticsearch(input$coloumn2)
    barplot(as.numeric(record[,2]), main=input$coloumn2, xlab=input$coloumn2, ylab="Count", names.arg=paste(record[,1]), col=rainbow(rainbowColor) )
    legend("topright", legend=paste(record[,1]), fill=rainbow(rainbowColor))
  })

})