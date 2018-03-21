library(shiny)


# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("CFL Data analysis with R"),
  
  # Sidebar with controls to select the variable to plot against mpg
  # and to specify whether outliers should be included
  sidebarPanel(
    selectInput("xColoumn", "X-Coloumn", coloumns),
	selectInput("yColoumn", "Y-Coloumn", coloumns),	
	dateRangeInput("fromToDates", "Date Range", start = "2005-01-02", end = "2014-08-30", format = "yyyy-mm-dd", language = "en", separator = " to "),
	tableOutput("xGTable"),
	tableOutput("yGTable")
  ),
  
  # Show the caption and plot of the requested variable against mpg
  mainPanel(
  tabsetPanel(
      tabPanel("2D", plotOutput("xG"), plotOutput("yG")), 
      tabPanel("3D", radioButtons('graphType', 'GraphType', c(Bar='bar', Stacked='stacked'), 'bar'), plotOutput("xsys"), plotOutput("flip_xsys"), tableOutput("xsysTable"), tableOutput("ysxsTable") ),
	  tabPanel("3D-Fix X", textInput("fixX", "Find Top ten Y for Fix-X"), plotOutput("ownTopYsForFixX"), tableOutput("ownTopYsForFixXTable"), plotOutput("cflTopYsForFixX"), tableOutput("cflTopYsForFixXTable")),
	  tabPanel("3D-Fix Y", textInput("fixY", "Find Top ten X for Fix-Y"), plotOutput("ownTopXsForFixY"), tableOutput("ownTopXsForFixYTable"), plotOutput("cflTopXsForFixY"), tableOutput("cflTopXsForFixYTable") ),
	  tabPanel("Histogram", plotOutput("histogramByYear"), dateRangeInput("fromToDatesHist", "Date Range", start = "2013-01-02", end = "2014-01-01", format = "yyyy-mm-dd", separator = " to "), plotOutput("histogramByMonth") )
    )
  )
))