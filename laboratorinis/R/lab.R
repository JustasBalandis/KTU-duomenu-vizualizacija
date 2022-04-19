library(readr)
library(ggplot2)
library(dplyr)
library(shiny)
#1)--

a<- read_csv("https://raw.githubusercontent.com/JustasBalandis/KTU-duomenu-vizualizacija/main/laboratorinis/data/lab_sodra.csv")
a1=a[a$ecoActCode==479100,]


b2=count(a1,avgWage)

b2%>% ggplot()+ geom_histogram(aes( x=avgWage))

#2)---


b21=unique(a1$name)


x=1

data1=data.frame(b21[x],sum(a1[a1$name==b21[x],8],na.rm=TRUE))

names(data1)[1]="names"
names(data1)[2]="sum"

x=2
while(x<1319){
  s=data.frame(b21[x],sum(a1[a1$name==b21[x],8],na.rm=TRUE))
  names(s)=names(data1)
  data1=rbind(data1,s)
  x=x+1;
}
data2=data1 %>% arrange(desc(sum))

b22=a1[a1$name==data2[1:5,1],c(3,7,8)]
b22=a1[a1$name==data2[1,1],c(3,7,8)]
b23=a1[a1$name==data2[2,1],c(3,7,8)]
b24=a1[a1$name==data2[3,1],c(3,7,8)]
b25=a1[a1$name==data2[4,1],c(3,7,8)]
b26=a1[a1$name==data2[5,1],c(3,7,8)]

s1=rbind(b22,b23,b24,b25,b26)


ggplot(s1,aes(x=month,y=avgWage))+ geom_line(aes(color=name,linetype=name))+
  scale_color_manual(values=c("blue","green","red","mediumorchid1","orange"))+
  geom_point(aes(color=name))


#3)---


data3=data2[1:5,"names"]

x=1

data4=data.frame(data3[x],sum(a1[a1$name==data3[x],9],na.rm=TRUE))

names(data4)[1]="names"
names(data4)[2]="sum"


x=2
while(x<=5){
  s=data.frame(data3[x],sum(a1[a1$name==data3[x],9],na.rm=TRUE))
  names(s)=names(data4)
  data4=rbind(data4,s)
  x=x+1;
}

data4=data4 %>% arrange(desc(sum))


ggplot(data4,y=sum,x=reorder(names,sum)) + geom_col(aes(x=reorder(names,-sum),y=sum,fill=names)) + scale_fill_manual(values=c("deepskyblue1","green3","red1","yellow2","orange"))

#4)---
a<- read_csv("https://raw.githubusercontent.com/JustasBalandis/KTU-duomenu-vizualizacija/main/laboratorinis/data/lab_sodra.csv")
a1=a[a$ecoActCode==479100,]

ui = fluidPage(titlePanel("Jûsø ekonominës veiklos srities pavadinimas"),sidebarLayout(sidebarPanel(selectInput(inputId = "n",
                                                                                                                label="Áveskite ámonës kodà",choices = a1$code,selected=NULL)),
                                                                                       mainPanel(plotOutput("aaa"))
))

server = function(input, output,session){
  
  output$aaa =renderPlot( ggplot(a1[a1$code==input$n,],aes(x=month,y=avgWage))+geom_line(aes(y=avgWage,color="red")))
}
shinyApp(ui=ui, server=server)
