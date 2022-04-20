library(readr)
library(ggplot2)
library(dplyr)
library(shiny)
#1)--

lab_sodra<- read_csv("https://raw.githubusercontent.com/JustasBalandis/KTU-duomenu-vizualizacija/main/laboratorinis/data/lab_sodra.csv")
labS=lab_sodra[lab_sodra$ecoActCode==479100,]


b2=count(labS,avgWage)

b2%>% ggplot()+ geom_histogram(aes( x=avgWage))

#2)---


s4=labS%>% select(name,numInsured,month,avgWage) %>%group_by(name)%>% mutate(suma=sum(avgWage,na.rm = TRUE))%>% arrange(-suma)
s4=s4[1:60,]

ggplot(s4,aes(x=month,y=avgWage))+ geom_line(aes(color=name,linetype=name))+
  scale_color_manual(values=c("blue","green","red","mediumorchid1","orange"))+
  geom_point(aes(color=name))


#3)---


s5=s4%>% group_by(name) %>% summarise(apdrausteji=sum(numInsured)) %>% arrange(-apdrausteji)

ggplot(s5,y=apdrausteji,x=reorder(name,apdrausteji)) + geom_col(aes(x=reorder(name,-apdrausteji),y=apdrausteji,fill=name)) + scale_fill_manual(values=c("deepskyblue1","green3","red1","yellow2","orange"))


#4)---

lab_sodra<- read_csv("https://raw.githubusercontent.com/JustasBalandis/KTU-duomenu-vizualizacija/main/laboratorinis/data/lab_sodra.csv")
labS=lab_sodra[lab_sodra$ecoActCode==479100,]

ui = fluidPage(titlePanel("Jûsø ekonominës veiklos srities pavadinimas"),sidebarLayout(sidebarPanel(selectInput(inputId = "n",
               label="Áveskite ámonës kodà",choices = labS$code,selected=NULL)),
                      mainPanel(plotOutput("aaa"))
))

server = function(input, output,session){
  
  output$aaa =renderPlot( ggplot(labS[labS$code==input$n,],aes(x=month,y=avgWage))+geom_line(aes(y=avgWage,color="red")))
}
shinyApp(ui=ui, server=server)
