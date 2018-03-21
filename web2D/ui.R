library(shiny)


# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("CFL Data analysis with R"),
  
  # Sidebar with controls to select the variable to plot against mpg
  # and to specify whether outliers should be included
  sidebarPanel(
    selectInput("coloumn1", "Graph-1:", coloumns),
	selectInput("coloumn2", "Graph-2:", coloumns)
  ),
  
  # Show the caption and plot of the requested variable against mpg
  mainPanel(
    plotOutput("Plot2D1"),
	plotOutput("Plot2D2")
  )
))