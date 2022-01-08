rm(list = ls())
setwd("~/InfluenzaForecastNPI-main/example_estimation/")
library(tidyverse)
library(glue)
library(xlsx)
library(cowplot)
library(scales)
# library(grid)
# library(pBrackets)

#https://blog.datawrapper.de/beautifulcolors/

makelabel <- function(len) {
  xseq<-seq(1,len,by=10)
  xseq[length(xseq)]<-len
  return(xseq)
}


scale = 1
ylimits = 150

line_color<-c("vaccine" = "#20B2AA")


##############################
# plot northern china
# load data
vaccine<-read.xlsx("Source Data/plot_vaccine/cn.xlsx", sheetName = "vaccine")

cnvaccine<-vaccine%>% filter(time>=202040&time<=202139)%>%
  mutate(vaccine = replace(vaccine, time > 202133, NA))%>%
  mutate(vaccine = replace(vaccine, time < 202051, NA))%>%
  mutate(scenario = "vaccine")
cntimeidx<-cnvaccine$time
cnxseq<-seq(1,length(cntimeidx))
cnxlabelpos<-makelabel(length(cntimeidx))
cnxlabel<-cntimeidx[cnxlabelpos]%%100

plot_cn_vaccine <-ggplot()+
  geom_line(aes(x = cnxseq, y = vaccine * scale, color = "vaccine"), size = 1.5,data=cnvaccine) +
  scale_color_manual(values = line_color,
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1), 
                     name = "Treatment")+
  annotate("text", label = "Northern China", x = 25, y =  145* scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="year", y = "Cumulative vaccine doses per 100 person") +
  scale_x_continuous(breaks=cnxlabelpos, label=cnxlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 30* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 53, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.8, 0.85),
    legend.title=element_blank(),

    legend.key.width = unit(1, 'cm'),
    legend.text = element_text(size=10),
    plot.background = element_rect(fill = "transparent", color = NA),
    plot.title = element_text(hjust = 0.5, face = "bold", margin = margin(0, 0, -0.5, 0, unit = "line")),
    axis.text.x = element_text(size = 13, color = "black"),
    axis.ticks.x = element_line(color = "darkgray"),
    axis.title.x = element_text(size = 13, color = "black", face = "bold"),
    axis.text.y = element_text(size = 13, color = "black"),
    axis.ticks.y = element_line(color = "darkgray"),
    axis.title.y = element_text(size = 13, color = "black", face = "bold")
  )
plot_cn_vaccine


# plot Southern China
# load data
vaccine<-read.xlsx("Source Data/plot_vaccine/cs.xlsx", sheetName = "vaccine")

csvaccine<-vaccine%>% filter(time>=202040&time<=202139)%>%
  mutate(vaccine = replace(vaccine, time > 202133, NA))%>%
  mutate(vaccine = replace(vaccine, time < 202051, NA))%>%
  mutate(scenario = "vaccine")
cstimeidx<-csvaccine$time
csxseq<-seq(1,length(cstimeidx))
csxlabelpos<-makelabel(length(cstimeidx))
csxlabel<-cstimeidx[csxlabelpos]%%100

plot_cs_vaccine <-ggplot()+
  geom_line(aes(x = csxseq, y = vaccine * scale, color = "vaccine"), size = 1.5,data=csvaccine) +
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_shape_manual(values = c(0, 1), 
                     name = "Treatment")+
  annotate("text", label = "Southern China", x = 25, y = 145* scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="year", y = "Cumulative vaccine doses per 100 person") +
  scale_x_continuous(breaks=csxlabelpos, label=csxlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 30* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 53, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.8, 0.85),
    legend.title=element_blank(),
    
    legend.key.width = unit(1, 'cm'),
    legend.text = element_text(size=10),
    plot.background = element_rect(fill = "transparent", color = NA),
    plot.title = element_text(hjust = 0.5, face = "bold", margin = margin(0, 0, -0.5, 0, unit = "line")),
    axis.text.x = element_text(size = 13, color = "black"),
    axis.ticks.x = element_line(color = "darkgray"),
    axis.title.x = element_text(size = 13, color = "black", face = "bold"),
    axis.text.y = element_text(size = 13, color = "black"),
    axis.ticks.y = element_line(color = "darkgray"),
    axis.title.y = element_text(size = 13, color = "black", face = "bold")
  )
plot_cs_vaccine


# plot England
# load data
vaccine<-read.xlsx("Source Data/plot_vaccine/uk.xlsx", sheetName = "vaccine")

ukvaccine<-vaccine%>% filter(time>=202040&time<=202139)%>%
  mutate(vaccine = replace(vaccine, time > 202133, NA))%>%
  mutate(vaccine = replace(vaccine, time < 202050, NA))%>%
  mutate(scenario = "vaccine")
uktimeidx<-ukvaccine$time
ukxseq<-seq(1,length(uktimeidx))
ukxlabelpos<-makelabel(length(uktimeidx))
ukxlabel<-uktimeidx[ukxlabelpos]%%100

plot_uk_vaccine <-ggplot()+
  geom_line(aes(x = ukxseq, y = vaccine * scale, color = "vaccine"), size = 1.5,data=ukvaccine) +
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_shape_manual(values = c(0, 1), 
                     name = "Treatment")+
  annotate("text", label = "England", x = 25, y = 145* scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="year", y = "Cumulative vaccine doses per 100 person") +
  scale_x_continuous(breaks=ukxlabelpos, label=ukxlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 30* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 53, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.8, 0.85),
    legend.title=element_blank(),
    
    legend.key.width = unit(1, 'cm'),
    legend.text = element_text(size=10),
    plot.background = element_rect(fill = "transparent", color = NA),
    plot.title = element_text(hjust = 0.5, face = "bold", margin = margin(0, 0, -0.5, 0, unit = "line")),
    axis.text.x = element_text(size = 13, color = "black"),
    axis.ticks.x = element_line(color = "darkgray"),
    axis.title.x = element_text(size = 13, color = "black", face = "bold"),
    axis.text.y = element_text(size = 13, color = "black"),
    axis.ticks.y = element_line(color = "darkgray"),
    axis.title.y = element_text(size = 13, color = "black", face = "bold")
  )
plot_uk_vaccine


# plot The U.S.
# load data
vaccine<-read.xlsx("Source Data/plot_vaccine/usa.xlsx", sheetName = "vaccine")

usavaccine<-vaccine%>% filter(time>=202040&time<=202139)%>%
  mutate(vaccine = replace(vaccine, time > 202133, NA))%>%
  mutate(vaccine = replace(vaccine, time < 202052, NA))%>%
  mutate(scenario = "vaccine")
usatimeidx<-usavaccine$time
usaxseq<-seq(1,length(usatimeidx))
usaxlabelpos<-makelabel(length(usatimeidx))
usaxlabel<-usatimeidx[usaxlabelpos]%%100

plot_usa_vaccine <-ggplot()+
  geom_line(aes(x = usaxseq, y = vaccine * scale, color = "vaccine"), size = 1.5,data=usavaccine) +
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_shape_manual(values = c(0, 1), 
                     name = "Treatment")+
  annotate("text", label = "The U.S.", x = 25, y = 145* scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="year", y = "Cumulative vaccine doses per 100 person") +
  scale_x_continuous(breaks=usaxlabelpos, label=usaxlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 30* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 53, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.8, 0.85),
    legend.title=element_blank(),
    
    legend.key.width = unit(1, 'cm'),
    legend.text = element_text(size=10),
    plot.background = element_rect(fill = "transparent", color = NA),
    plot.title = element_text(hjust = 0.5, face = "bold", margin = margin(0, 0, -0.5, 0, unit = "line")),
    axis.text.x = element_text(size = 13, color = "black"),
    axis.ticks.x = element_line(color = "darkgray"),
    axis.title.x = element_text(size = 13, color = "black", face = "bold"),
    axis.text.y = element_text(size = 13, color = "black"),
    axis.ticks.y = element_line(color = "darkgray"),
    axis.title.y = element_text(size = 13, color = "black", face = "bold")
  )
plot_usa_vaccine




# combine above 8 plots into one figure
prow <- plot_grid(plot_cn_vaccine + theme(legend.position = "none")+ labs(x = ""),
                  NULL,
                  plot_cs_vaccine + theme(legend.position = "none") + labs(x = "",y=""),
                  NULL,
                  plot_uk_vaccine + theme(legend.position = "none") + labs(x = "Week"),
                  NULL,
                  plot_usa_vaccine + theme(legend.position = "none") + labs(x = "Week",y=""),
                  rel_widths = c(1, -0.05, 1, -0.05, 1, -0.05, 1), 
                  label_x = c(0.1, 0, 0.1, 0, 0.1, 0, 0.1), 
                  nrow = 2, labels = c("a", "", "b", "", "c", "", "d"))
prow

#legend <- get_legend(plotf_mask_cn19)

finalplot <- plot_grid( NULL,NULL,prow,NULL, nrow = 2, 
                       rel_heights = c(0.02,1),rel_widths = c(1,0.02))
finalplot


outfile <- glue("Source plot/output/Vaccine_2020-2021.tif")
tiff(outfile, width = 12, height = 12, unit = "in", res = 300, compression = "lzw")
print(finalplot)
dev.off()

