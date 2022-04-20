#4)---

library(ggplot2)
library(dplyr)
library(shiny)
library(readr)

lab_sodra<- read_csv("https://raw.githubusercontent.com/JustasBalandis/KTU-duomenu-vizualizacija/main/laboratorinis/data/lab_sodra.csv")
labS=lab_sodra[lab_sodra$ecoActCode==479100,]

ui = fluidPage(titlePanel("Jûsø ekonominës veiklos srities pavadinimas"),sidebarLayout(sidebarPanel(selectInput(inputId = "n",
            label="Áveskite ámonës kodà",choices = labS$code,selected=NULL)),
                         mainPanel(plotOutput("aaa")) ))

server = function(input, output,session){
  
  output$aaa =renderPlot( ggplot(labS[labS$code==input$n,],aes(x=month,y=avgWage))+geom_line(aes(y=avgWage,color="red")))
}
shinyApp(ui=ui, server=server)
  