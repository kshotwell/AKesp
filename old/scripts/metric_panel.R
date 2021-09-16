#To generate metric panel for ESPs
#Set working directory to location of metric panel csv
library(plyr)
library(reshape2)
library(gridExtra)
library(RColorBrewer)
library(ggplot2)
library(devtools)
library(googlesheets4)

#To connect to the metric panel data, connection works, but data not ready
esp_url<-"https://docs.google.com/spreadsheets/d/1NNZdV8hJD9JMDrBnNZ5sDPuV-FGveuO3P1GmKrDWMlI/edit?usp=sharing"
read_sheet(esp_url)

#Until data ready in esp_url, just upload the metric panel csv
panel<-read.csv("panel5.csv",header=T,stringsAsFactors=FALSE)

#Prep some of the data and subset for the species of interest, only five stocks in there now, but have data for all groundfish stocks
panel$Rank<-as.numeric(panel$Rank)
names<-c("Sablefish","Pollock","Pacific Cod","Arrowtooth","POP")
s<-1
panel_sp<-subset(panel,panel$Stock==names[s])

#Subset metrics further for only the approved metrics by the ESP teams
panel_sp<-subset(panel_sp,panel_sp$Use=='Yes')

#Arrange by Order1 if just want same order of metrics across all panels, or by Order2 if want metrics in order of vulnerability 
panel_sp<-arrange(panel_sp,Order2,decreasing=T)

#Create factors of metrics and assign dimensions
panel_sp$Metric<-factor(panel_sp$Metric,levels=panel_sp$Metric)
panel_sp_dim<-dim(panel_sp)

#Create main metric panel graphic
panel_chart<-ggplot(panel_sp) +
  geom_bar(aes(x=factor(Metric),y=Rank,fill=Quality),  stat="identity")+
  theme_bw(base_size=12)+
  scale_fill_gradient(low="green", high="blue",na.value = "transparent", 
                      breaks=c(0,2,4),labels=c("No Data","Medium","Complete"),
                      limits=c(0,4))+
  scale_y_continuous(limits=c(0,1), breaks = c(0,0.5,1),labels = c("Low","Med","High")) 
pc2<-panel_chart + 
  geom_rect(aes(xmin=0, ymin=0.8, xmax=panel_sp_dim[1]+0.5, ymax=0.9), fill="gray", color="gray", size=1.5)+
  geom_rect(aes(xmin=0, ymin=0.9, xmax=panel_sp_dim[1]+0.5, ymax=1), fill="black", color="black", size=1.5)+
  geom_bar(aes(x=reorder(Metric,Rank),y=Rank,fill=Quality), stat="identity")+
  coord_flip()+theme_bw(base_size=14)+
  scale_fill_gradient(low="green", high="blue",na.value = "transparent", 
                     breaks=c(0,2,4),labels=c("No Data","Medium","Complete"),
                    limits=c(0,4))+
  scale_y_continuous(limits=c(0,1), breaks = c(0,0.5,1),labels = c("Low","Med","High")) +
  ggtitle("")+
  xlab(" ")+
  ylab(" ")
  
ggsave(paste("panel_",names[s],".png",sep=""),plot=pc2,width=6, height=7.5)

