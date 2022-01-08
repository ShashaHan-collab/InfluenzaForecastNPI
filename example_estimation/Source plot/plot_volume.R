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

makelabel <- function(timeidx) {
  len = length(timeidx)
  startyear <- 2012
  endyear <- 2022
  xseq <- c()
  for (i in 1:len) {
    if (timeidx[i] == (startyear * 100 + 1)) {
      xseq <- c(xseq, i)
      startyear <- startyear + 1
      if (startyear == endyear) {
        return(xseq)
      }
    }
  }
}


scale = 100
ylimits = 150

line_color<-c("Domestic" = "#F804A2", 
              "International" = "#FF7800")
line_type<-c("Observed" = "solid", 
             "Fitted" = "solid")

##############################
# plot northern china
# load data
domestic<-read.xlsx("Source Data/plot_volume/cn.xlsx", sheetName = "domestic")
international<-read.xlsx("Source Data/plot_volume/cn.xlsx", sheetName = "international")

cnd<-domestic%>% filter(time>=201140&time<=202128)%>%
  mutate(scenario = "Domestic")
cni<-international%>% filter(time>=201140&time<=202128)%>%
  mutate(scenario = "international")
cntimeidx<-cnd$time
cnxseq<-seq(1,length(cntimeidx))
cnxlabelpos<-makelabel(cntimeidx)
cnxlabel<-as.integer(cntimeidx[cnxlabelpos]/100)

plot_cn_volume <-ggplot()+
  geom_line(aes(x = cnxseq, y = domestic * scale, color = "Domestic"), size = 1.5,data=cnd) +
  geom_line(aes(x = cnxseq, y = international * scale, color = "International"), size = 1.5,data=cni) +
  scale_color_manual(values = line_color,
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1), 
                     name = "Treatment")+
  annotate("text", label = "Northern China", x = 25, y =  1.45 * scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="year", y = "Volume") +
  scale_x_continuous(breaks=cnxlabelpos, label=cnxlabel,expand = c(0.01,0))+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.3* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 510, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.9, 0.9),
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
plot_cn_volume


# plot Southern China
# load data
domestic<-read.xlsx("Source Data/plot_volume/cs.xlsx", sheetName = "domestic")
international<-read.xlsx("Source Data/plot_volume/cs.xlsx", sheetName = "international")

csd<-domestic%>% filter(time>=201140&time<=202128)%>%
  mutate(scenario = "Domestic")
csi<-international%>% filter(time>=201140&time<=202128)%>%
  mutate(scenario = "international")
cstimeidx<-csd$time
csxseq<-seq(1,length(cstimeidx))
csxlabelpos<-makelabel(cstimeidx)
csxlabel<-as.integer(cstimeidx[csxlabelpos]/100)

plot_cs_volume <-ggplot()+
  geom_line(aes(x = csxseq, y = domestic * scale, color = "Domestic"), size = 1.5,data=csd) +
  geom_line(aes(x = csxseq, y = international * scale, color = "International"), size = 1.5,data=csi) +
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_shape_manual(values = c(0, 1), 
                     name = "Treatment")+
  annotate("text", label = "Southern China", x = 25, y =  1.45 * scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="year", y = "Volume") +
  scale_x_continuous(breaks=csxlabelpos, label=csxlabel,expand = c(0.01,0))+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.3* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 510, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.9, 0.9),
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
plot_cs_volume

# plot England
# load data
domestic<-read.xlsx("Source Data/plot_volume/uk.xlsx", sheetName = "domestic")
international<-read.xlsx("Source Data/plot_volume/uk.xlsx", sheetName = "international")

ukd<-domestic%>% filter(time>=201140&time<=202128)%>%
  mutate(domestic = replace(domestic, time > 202113, NA))%>%
  mutate(scenario = "Domestic")
uki<-international%>% filter(time>=201140&time<=202128)%>%
  mutate(international = replace(international, time > 202113, NA))%>%
  mutate(scenario = "international")
uktimeidx<-ukd$time
ukxseq<-seq(1,length(uktimeidx))
ukxlabelpos<-makelabel(uktimeidx)
ukxlabel<-as.integer(uktimeidx[ukxlabelpos]/100)

plot_uk_volume <-ggplot()+
  geom_line(aes(x = ukxseq, y = domestic * scale, color = "Domestic"), size = 1.5,data=ukd) +
  geom_line(aes(x = ukxseq, y = international * scale, color = "International"), size = 1.5,data=uki) +
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_shape_manual(values = c(0, 1), 
                     name = "Treatment")+
  annotate("text", label = "England", x = 25, y =  1.45 * scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="year", y = "Volume") +
  scale_x_continuous(breaks=ukxlabelpos, label=ukxlabel,expand = c(0.01,0))+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.3* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 510, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.9, 0.9),
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
plot_uk_volume


# plot The U.S.
# load data
domestic<-read.xlsx("Source Data/plot_volume/usa.xlsx", sheetName = "domestic")
international<-read.xlsx("Source Data/plot_volume/usa.xlsx", sheetName = "international")

usad<-domestic%>% filter(time>=201140&time<=202128)%>%
  mutate(domestic = replace(domestic, time > 202121, NA))%>%
  mutate(scenario = "Domestic")
usai<-international%>% filter(time>=201140&time<=202128)%>%
  mutate(international = replace(international, time > 202125, NA))%>%
  mutate(scenario = "international")
usatimeidx<-usad$time
usaxseq<-seq(1,length(usatimeidx))
usaxlabelpos<-makelabel(usatimeidx)
usaxlabel<-as.integer(usatimeidx[usaxlabelpos]/100)

plot_usa_volume <-ggplot()+
  geom_line(aes(x = usaxseq, y = domestic * scale, color = "Domestic"), size = 1.5,data=usad) +
  geom_line(aes(x = usaxseq, y = international * scale, color = "International"), size = 1.5,data=usai) +
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_shape_manual(values = c(0, 1), 
                     name = "Treatment")+
  annotate("text", label = "The U.S.", x = 25, y =  1.45 * scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="year", y = "Volume") +
  scale_x_continuous(breaks=usaxlabelpos, label=usaxlabel,expand = c(0.01,0))+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.3* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 510, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.9, 0.9),
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
plot_usa_volume




# combine above 8 plots into one figure
prow <- plot_grid(plot_cn_volume + labs(x = ""),
                  plot_cs_volume + theme(legend.position = "none") + labs(x = ""),
                  plot_uk_volume + theme(legend.position = "none") + labs(x = ""),
                  plot_usa_volume + theme(legend.position = "none") + labs(x = "Year"),
                  rel_widths = c(1, 1,  1,  1), 
                  label_x = c(0.001, 0.001, 0.001, 0.001), 
                  label_y = c(1.05,1.05,1.05,1.05),
                  nrow = 4, labels = c("a", "b",  "c", "d"))
prow


finalplot <- plot_grid( NULL,NULL,prow,NULL, nrow = 2, 
                       rel_heights = c(0.02,1),rel_widths = c(1,0.02))
finalplot


outfile <- glue("Source plot/output/Volume_2011-2021.tif")
tiff(outfile, width = 20, height = 12, unit = "in", res = 300, compression = "lzw")
print(finalplot)
dev.off()

