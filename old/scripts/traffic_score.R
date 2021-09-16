#Script to create time series of indicators, histogram, and simple score for ESPs

install.packages("parsedate", dependencies = TRUE)
install.packages("sp", dependencies = TRUE)
install.packages("lubridate", dependencies = TRUE)
install.packages("RColorBrewer", dependencies = TRUE)
install.packages("colorRamps")
install.packages("tidyverse")
install.packages("tidyr")
install.packages("dplyr")
install.packages("devtools")
install.packages("ggfortify", dependencies = TRUE)
install.packages("reshape2", dependencies = TRUE)
install.packages("plotly")
install.packages("gmodels")
install.packages("ggforce")

library("ggplot2")
library("sf")
library("maps")
library("reshape2")
library("ggfortify")
library("mapdata")
library("lubridate")
library("RColorBrewer")
library("colorRamps")
library("dplyr")
library("tidyr")
library("plotly")
library("gmodels")
library("ggforce")
library("ggcorrplot")

#Set working directory to location of indicator csv
#Read in name of indicator csv, first read in original values
#Following creation of time series graphic, read in csv with residual values

traffic<-read.csv("sablefish_indicators_2020_new_ma.csv",header=T)
traffic<-read.csv("sablefish_indicators_2020_new_ma_res.csv",header=T)

#Create object that toggles between a csv of original values or a csv of residual values from the mean
res<-c("normal","residual")

#CHANGE THIS SECTION for each stock
s<-1 #change variable depending on stock being evaluated
nsocecon<-8 #input variable for number of socioeconomic indicators (8 for pollock, 8 for sablefish, 5 EBS pcod, 7 GOA Pcod)
r<-1 #change variable based on whether selected *.csv or *_res.cvs above

#Add names of stocks as get more ESPs
names<-c("sablefish","GOA_pollock","GOA_Pacific_cod","EBS_Pacific_cod")

#Determine number of pages for time series graphics based on number of indicators in dimensions of time series plot and include in same order as names
dim(traffic)
names(traffic)
spage<-c(10,7,8,7)

#Identify the ecosystem and socioeconomic indicator columns and make separate short form dataframes, 1 is for ecosystem, 2 is for socioeconomic

colnames(traffic)
dims<-dim(traffic)

#Separate traffic into ecosystem and socioeconomic dataframes
traffic1<-traffic[,1:(dims[2]-nsocecon)] #ecosystem
traffic2<-traffic[,c(1,(dims[2]-nsocecon+1):dims[2])] #socioecon

#Correlation matrix of ecosystem indicators, does not work when lots of missing values, useful to see if have highly correlated indicators in suite
traffic1_cor<-round(cor(traffic1, use="complete.obs"),1)
p.mat<-cor_pmat(traffic1)
traffic1_cor_plot<-ggcorrplot(traffic1_cor, hc.order = TRUE, type = "lower", lab=TRUE)
traffic1_cor_plot2<-ggcorrplot(traffic1_cor, hc.order = TRUE, type = "lower", p.mat = p.mat, insig = "blank")
ggsave(paste("ecosystem_cor_",names[s],".png",sep=""),plot=traffic1_cor_plot,width=12, height=10)
ggsave(paste("ecosystem_cor2_",names[s],".png",sep=""),plot=traffic1_cor_plot2,width=12, height=10)

#long form ecosystem and socioeconomic dataframes add type to characterize and then bind
teco<-melt(traffic1, id="Year")
tecon<-melt(traffic2, id="Year")
teco$type<-"Ecosystem"
tecon$type<-"Socioeconomic"
t1<-rbind(teco,tecon)

#Use if only have ecosystem data
#t1<-melt(traffic,id="Year")
#t1$type<-"Ecosystem"

#add extra columns for creating other sections of the time series graphic
#calculates overall mean, cis, se, percentile values of time series
t1 %>%
  group_by(variable) %>%
  summarize(allmean = ci(value,na.rm = TRUE)[1],
            low1ci = ci(value,confidence = 0.68,na.rm = TRUE)[2],
            hi1ci = ci(value,confidence = 0.68,na.rm = TRUE)[3],
            se = ci(value,na.rm = TRUE)[4],
            p80=quantile(value, probs = 0.8, na.rm = TRUE),
            p20=quantile(value, probs = 0.2, na.rm = TRUE),
            n=length(value))
#adds mean, cis, se, percentiles columns
t2<-t1 %>%
  group_by(variable) %>%
  mutate(allmean = ci(value, na.rm = TRUE)[1]) %>%
  mutate(low1ci = ci(value,confidence = 0.95,na.rm = TRUE)[2]) %>%
  mutate(hi1ci = ci(value,confidence = 0.95,na.rm = TRUE)[3]) %>%
  mutate(se = ci(value, na.rm = TRUE)[4]) %>%
  mutate(p90 = quantile(value, probs = 0.9, na.rm = TRUE))  %>%
  mutate(p10 = quantile(value, probs = 0.1, na.rm = TRUE)) %>%
  mutate(nobs=sum(!is.na(value)))

t2$lci<-t2$value-1.96*t2$se
t2$uci<-t2$value+1.96*t2$se

npages<-ceiling(length(levels(t2$variable)))
nyears<-max(t2$Year)

#Preliminary plot for looking at histogram of each timeseries prior to breaking into ecosystem and socioeconomic dataframes.
#Make sure to transform with 4th root if have non-normal series or zeros
p<-ggplot(traffic, aes(x=traffic[,i]))+
  geom_histogram(aes(y=..density..),color="black", fill="white", na.rm=TRUE)+
  geom_density(alpha=0.2, fill="yellow")

for(i in seq_len(npages)){
  p<-ggplot(data = t2, aes(value))
  p+
    geom_histogram(aes(y=..density..),color="black", fill="white", na.rm=TRUE)+
    geom_density(alpha=0.2, fill="yellow")+
    facet_wrap_paginate(~variable, ncol=3, nrow = 3, page = i, scales = "free")+
    ylab(" ")+
    theme_bw(base_size=12)
  ggsave(paste("traffic_",names[s],"_hist_",res[r],i,".png",sep = ""),height=6,width=8,dpi=300)
}

#Main time series plot for ecosystem indicators, spage pollock = 8, sablefish = 7, ebspcod = 7, goapcod = 8,
#for presentations use height=6 width=7 nrow=5, for documents use height=10 width=8 nrow=7

t2e<-subset(t2,type=="Ecosystem")
colMax <- function(data) sapply(data, max, na.rm = TRUE)
max_traffic1<-colMax(traffic1)
max_traffic1<-max_traffic1[2:length(max_traffic1)]
panel_label<-data.frame(x=rep(1976,ncol(traffic1)-1),y=max_traffic1,
                        lab=letters[seq(from = 1, to = ncol(traffic1)-1)],
                        variable=colnames(traffic1[2:length(colnames(traffic1))]))

for(i in seq_len(npages)){
  p1<-ggplot(data = t2e, aes(Year))
  #theme_bw(base_size=12)
  p1+
    geom_rect(aes(xmin=max(t2e$Year)-1, ymin=t2e$p10, xmax=max(t2e$Year), ymax=t2e$p90), fill="lightgreen")+
    geom_line(aes(y=value)) +
    geom_point(aes(y=value), size=1)+
    geom_line(aes(y=allmean),color="darkgreen",linetype="dotted") +
    geom_line(aes(y=p10),color="darkgreen",linetype="solid") +
    geom_line(aes(y=p90),color="darkgreen",linetype="solid") +
    geom_text(data = panel_label, aes(x = x,  y = y, label = lab)) +
    facet_wrap_paginate(~variable, ncol=1, nrow = spage[s], page = i, scales = "free_y")+
    geom_blank(aes(x = nyears))+
    scale_x_continuous(breaks=seq(min(t2e$Year),max(t2e$Year),by=7))+
    ylab(" ")+
    theme_bw(base_size=16)
  ggsave(paste("traffic_final",names[s],"_eco_ex_ts",i,".png",sep=""),height=10,width=7,dpi=300)
}

#Main time series plot for socioeconomic indicators, npage pollock = 6, sablefish = 8,
#for presentations use height=6 width=7 nrow=5, for documents use height=10 width=8 nrow=7

t2s<-subset(t2,type=="Socioeconomic")
colMax <- function(data) sapply(data, max, na.rm = TRUE)
max_traffic2<-colMax(traffic2)
max_traffic2<-max_traffic2[2:length(max_traffic2)]
panel_label<-data.frame(x=rep(1976,ncol(traffic2)-1),y=max_traffic2,
                        lab=letters[seq(from = 1, to = ncol(traffic2)-1)],
                        variable=colnames(traffic2[2:length(colnames(traffic2))]))

for(i in seq_len(npages)){
  p1<-ggplot(data = t2s, aes(Year))
  #theme_bw(base_size=12)
  p1+
    geom_rect(aes(xmin=max(t2s$Year)-1, ymin=t2s$p10, xmax=max(t2s$Year), ymax=t2s$p90), fill="lightgreen")+
    geom_line(aes(y=value)) +
    geom_point(aes(y=value), size=1)+
    geom_line(aes(y=allmean),color="darkgreen",linetype="dotted") +
    geom_line(aes(y=p10),color="darkgreen",linetype="solid") +
    geom_line(aes(y=p90),color="darkgreen",linetype="solid") +
    geom_text(data = panel_label, aes(x = x,  y = y, label = lab)) +
    facet_wrap_paginate(~variable, ncol=1, nrow = spage[s], page = i, scales = "free_y")+
    geom_blank(aes(x = nyears))+
    scale_x_continuous(breaks=seq(min(t2s$Year),max(t2s$Year),by=4))+
    ylab(" ")+
    theme_bw(base_size=16)
  ggsave(paste("traffic_final_",names[s],"_secon_ex_ts",i,".png",sep=""),height=10,width=8,dpi=300)
}

#Use for calculating beginning stage scores of indicator residuals, make sure to load species *_res.csv file
#Assign NA values and create dummy columns
t2[is.na(t2$value),]$value<-(9999)
t2$outside<-0
t2[t2$value>1&t2$value<9999,]$outside<-(1)
t2[t2$value<(-1),]$outside<-(-1)
t2$sign<-1
t2$category<-"Physical"
summary(t2$variable)

#Select the assignments below depending on the ESP
#Assignments for relationship between indicators and GOA Pollock and categories
t2[t2$variable=="Annual_Heatwave_GOA",]$sign<-(-1)
t2[t2$variable=="Spring_Surface_Temperature_WCGOA",]$sign<-(-1)
t2[t2$variable=="Summer_Bottom_Temperature_WCGOA",]$sign<-(-1)
t2[t2$variable=="Spring_Wind_Direction_CGOA",]$sign<-(-1)
t2[t2$variable=="Summer_Pollock_Predation_Age_1",]$sign<-(-1)
t2[t2$variable=="Summer_Pollock_Center_Gravity_Northeast_Survey",]$sign<-(-1)
t2[t2$variable=="Arrowtooth_Biomass_Assessment",]$sign<-(-1)
t2[t2$variable=="Pacific_ocean_perch_Biomass_Assessment",]$sign<-(-1)
t2[t2$variable=="Sablefish_Biomass_Assessment",]$sign<-(-1)
t2[t2$variable=="Steller_Sea_Lions_Adults",]$sign<-(-1)
cnames<-levels(t2$variable)
cassign<-c("Physical","Physical","Physical","Physical","Physical","Physical",
           "Lower Trophic","Lower Trophic","Lower Trophic","Lower Trophic",
           "Lower Trophic","Lower Trophic","Lower Trophic","Lower Trophic",
           "Lower Trophic","Upper Trophic","Upper Trophic","Upper Trophic",
           "Upper Trophic","Upper Trophic","Upper Trophic","Upper Trophic",
           "Upper Trophic","Upper Trophic","Upper Trophic","Performance",
           "Performance","Economic","Economic","Community","Community",
           "Community","Community")

for(i in 1:length(cnames)){
  t2[t2$variable==cnames[i],]$category<-cassign[i]
}

#Assignments for relationship between indicators and Sablefish and categories
t2[t2$variable=="Summer_250m_Temperature_GOA_Slope",]$sign<-(-1)
t2[t2$variable=="Spring_Peak_Bloom_Timing_EGOA",]$sign<-(-1)
t2[t2$variable=="Spring_Peak_Bloom_Timing_SEBS",]$sign<-(-1)
t2[t2$variable=="Arrowtooth_Biomass_Assessment",]$sign<-(-1)
t2[t2$variable=="Sablefish_Incidental_Catch_BSAI_Fisheries",]$sign<-(-1)
t2[t2$variable=="Sablefish_Incidental_Catch_GOA_Fisheries",]$sign<-(-1)
cnames<-levels(t2$variable)
cassign<-c("Physical","Physical","Physical","Physical","Physical","Physical",
           "Physical","Physical","Lower Trophic","Lower Trophic",
           "Lower Trophic","Lower Trophic","Upper Trophic","Upper Trophic",
           "Upper Trophic","Upper Trophic","Upper Trophic","Upper Trophic",
           "Upper Trophic","Upper Trophic","Performance","Performance",
           "Performance","Performance","Performance","Performance","Economic",
           "Economic")

for(i in 1:length(cnames)){
  t2[t2$variable==cnames[i],]$category<-cassign[i]
}

#Assignments for relationship between indicators and EBS_Pcod and categories
t2[t2$variable=="Spring_Summer_Surface_Temperature_EBS",]$sign<-(-1)
t2[t2$variable=="Summer_Bottom_Temperature_EBS_Shelf_ROMS",]$sign<-(-1)
t2[t2$variable=="Summer_Center_Gravity_Northings_EBS_BTS_Survey",]$sign<-(-1)
t2[t2$variable=="Arrowtooth_Flounder_Total_Biomass_Assessment_BSAI",]$sign<-(-1)
cnames<-levels(t2$variable)
cassign<-c("Physical","Physical","Physical","Physical","Physical","Physical",
           "Lower Trophic","Upper Trophic","Upper Trophic","Upper Trophic",
           "Upper Trophic","Upper Trophic","Upper Trophic","Economic",
           "Economic","Economic","Community","Community")

for(i in 1:length(cnames)){
  t2[t2$variable==cnames[i],]$category<-cassign[i]
}

#Assignments for relationship between indicators and GOA Pcod and categories
t2[t2$variable=="Marine_Heatwave_Cumulative_Intensity_Spawning",]$sign<-(-1)
t2[t2$variable=="Summer_Bottom_Temperature_GOA_Shelf_CFSR_20.40cm",]$sign<-(-1)
t2[t2$variable=="Summer_Center_Gravity_NorthEastings_GOA_BTS_Survey",]$sign<-(-1)
t2[t2$variable=="Steller_Sea_Lions_Adults",]$sign<-(-1)
t2[t2$variable=="Arrowtooth_Flounder_Total_Biomass_Assessment_GOA",]$sign<-(-1)
cnames<-levels(t2$variable)
cassign<-c("Physical","Physical","Physical","Physical","Physical",
           "Lower Trophic","Lower Trophic","Lower Trophic","Lower Trophic",
           "Lower Trophic","Upper Trophic","Upper Trophic","Upper Trophic",
           "Upper Trophic","Upper Trophic","Upper Trophic","Economic",
           "Economic","Economic","Community","Community","Community","Community")

for(i in 1:length(cnames)){
  t2[t2$variable==cnames[i],]$category<-cassign[i]
}

#After creating assignements, calculate the score for each variable
t2$score<-t2$outside*t2$sign

#Group by for analysis by overall type or category
t3<-t2 %>%
  group_by(type,Year) %>%
  summarize(score = sum(score,na.rm = TRUE),
            nobs=sum(!is.na(lci)))
t3$final<-t3$score/t3$nobs

p2<-ggplot(data = t3, aes(Year))
p2+
  geom_line(aes(y=final,col=type))

t4<-t2 %>%
  group_by(category,Year) %>%
  summarize(score = sum(score,na.rm = TRUE),
            nobs=sum(!is.na(lci)))
t4$final<-t4$score/t4$nobs

#Output csv of scores
write.csv(t2,paste("all_score_final2_",names[s],".csv",sep=""),row.names=TRUE)
write.csv(t3,paste("type_score_final2_",names[s],".csv",sep=""),row.names=TRUE)
write.csv(t4,paste("category_score_final2_",names[s],".csv",sep=""),row.names=TRUE)

#Next steps are to automate the score graphic and indicator metadata using AKFIN
