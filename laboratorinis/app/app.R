4)---
  
library(ggplot2)
library(dplyr)
library(shiny)

  a<- read.csv("laboratorinis/data/lab_sodra.csv")
  a1=a[a$ecoActCode==479100,]
  
  ui = fluidPage(titlePanel("Jûsø ekonominës veiklos srities pavadinimas"),sidebarLayout(sidebarPanel(selectInput(inputId = "n",
    label="Áveskite ámonës kodà",choices = a1$code,selected=NULL)),
   mainPanel(plotOutput("aaa"))
  ))
  
  server = function(input, output,session){
    a<- read.csv("laboratorinis/data/lab_sodra.csv")
    a1=a[a$ecoActCode==479100,]
    output$aaa =renderPlot( ggplot(a1[a1$code==input$n,],aes(x=month,y=avgWage))+geom_line(aes(y=avgWage,color="red")))
  }
  shinyApp(ui=ui, server=server)
  