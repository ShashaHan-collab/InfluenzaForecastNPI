rm(list = ls())

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


scale = 100
ylimits = 200

line_color<-c("Domestic mobility" = "#F804A2", 
              "Oxford data" = "#20B2AA")
line_type<-c("Observed" = "solid", 
             "Oxford data" = "solid")

##############################
# plot northern china
# load data
domestic<-read.xlsx("Source Data/plot_oxfordnpivsvolume/cn.xlsx", sheetName = "domestic")


cnd<-domestic%>% filter(time>=202001&time<=202128)%>%
  mutate(domestic = replace(domestic, time > 202124, NA))%>%
  mutate(domestic = replace(domestic, time < 202004, NA))%>%
  mutate(npi = replace(npi, time > 202124, NA))%>%
  mutate(npi = replace(npi, time < 202004, NA))

cntimeidx<-cnd$time
cnxseq<-seq(1,length(cntimeidx))
cnxlabelpos<-makelabel(length(cntimeidx))
cnxlabel<-cntimeidx[cnxlabelpos]%%100

plot_cn_volume <-ggplot()+
  geom_line(aes(x = cnxseq, y = domestic * scale, color = "Domestic mobility"), size = 1.5,data=cnd) +
  geom_line(aes(x = cnxseq, y = -npi * scale+200, color = "Oxford data"), size = 1.5,data=cnd) +
  scale_color_manual(values = line_color,
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1), 
                     name = "Treatment")+
  annotate("text", label = "Northern China", x = 8, y =  1.45 * scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="year", y = "Domestic volume") +
  scale_x_continuous(breaks=cnxlabelpos, label=cnxlabel,expand = c(0.01,0),sec.axis=dup_axis(name="",breaks = c(1,54),labels = c("","")))+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.3* scale),sec.axis=dup_axis(name="Restriction level",breaks = c(0,100,200),labels = c("-2","-1","0"))) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 81, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(x = 1, xend = 81, y = Inf, yend = Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = Inf, xend = Inf), color = "darkgray") +
  theme(
    legend.position = c(0.95, 0.8),
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




##############################
# plot Southern china
# load data
domestic<-read.xlsx("Source Data/plot_oxfordnpivsvolume/cs.xlsx", sheetName = "domestic")


csd<-domestic%>% filter(time>=202001&time<=202128)%>%
  mutate(domestic = replace(domestic, time > 202124, NA))%>%
  mutate(domestic = replace(domestic, time < 202004, NA))%>%
  mutate(npi = replace(npi, time > 202124, NA))%>%
  mutate(npi = replace(npi, time < 202004, NA))

cstimeidx<-csd$time
csxseq<-seq(1,length(cstimeidx))
csxlabelpos<-makelabel(length(cstimeidx))
csxlabel<-cstimeidx[csxlabelpos]%%100

plot_cs_volume <-ggplot()+
  geom_line(aes(x = csxseq, y = domestic * scale, color = "Domestic mobility"), size = 1.5,data=csd) +
  geom_line(aes(x = csxseq, y = -npi * scale+200, color = "Oxford data"), size = 1.5,data=csd) +
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_shape_manual(values = c(0, 1), 
                     name = "Treatment")+
  annotate("text", label = "Southern China", x = 8, y =  1.45 * scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="year", y = "Domestic volume") +
  scale_x_continuous(breaks=csxlabelpos, label=csxlabel,expand = c(0.01,0),sec.axis=dup_axis(name="",breaks = c(1,54),labels = c("","")))+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.3* scale),sec.axis=dup_axis(name="Restriction level",breaks = c(0,100,200),labels = c("-2","-1","0"))) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 81, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(x = 1, xend = 81, y = Inf, yend = Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = Inf, xend = Inf), color = "darkgray") +
  theme(
    legend.position = c(0.95, 0.8),
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

##############################
# plot England
# load data
domestic<-read.xlsx("Source Data/plot_oxfordnpivsvolume/uk.xlsx", sheetName = "domestic")


ukd<-domestic%>% filter(time>=202001&time<=202128)%>%
  mutate(domestic = replace(domestic, time > 202124, NA))%>%
  mutate(domestic = replace(domestic, time < 202011, NA))%>%
  mutate(npi = replace(npi, time > 202124, NA))%>%
  mutate(npi = replace(npi, time < 202011, NA))

uktimeidx<-ukd$time
ukxseq<-seq(1,length(uktimeidx))
ukxlabelpos<-makelabel(length(uktimeidx))
ukxlabel<-uktimeidx[ukxlabelpos]%%100

plot_uk_volume <-ggplot()+
  geom_line(aes(x = ukxseq, y = domestic * scale, color = "Domestic mobility"), size = 1.5,data=ukd) +
  geom_line(aes(x = ukxseq, y = -npi * scale+200, color = "Oxford data"), size = 1.5,data=ukd) +
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_shape_manual(values = c(0, 1), 
                     name = "Treatment")+
  annotate("text", label = "England", x = 8, y =  1.45 * scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="year", y = "Domestic volume") +
  scale_x_continuous(breaks=ukxlabelpos, label=ukxlabel,expand = c(0.01,0),sec.axis=dup_axis(name="",breaks = c(1,54),labels = c("","")))+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.3* scale),sec.axis=dup_axis(name="Restriction level",breaks = c(0,100,200),labels = c("-2","-1","0"))) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 81, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(x = 1, xend = 81, y = Inf, yend = Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = Inf, xend = Inf), color = "darkgray") +
  theme(
    legend.position = c(0.95, 0.8),
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


##############################
# plot The U.S.
# load data
domestic<-read.xlsx("Source Data/plot_oxfordnpivsvolume/usa.xlsx", sheetName = "domestic")


usad<-domestic%>% filter(time>=202001&time<=202128)%>%
  mutate(domestic = replace(domestic, time > 202124, NA))%>%
  mutate(domestic = replace(domestic, time < 202012, NA))%>%
  mutate(npi = replace(npi, time > 202124, NA))%>%
  mutate(npi = replace(npi, time < 202012, NA))

usatimeidx<-usad$time
usaxseq<-seq(1,length(usatimeidx))
usaxlabelpos<-makelabel(length(usatimeidx))
usaxlabel<-usatimeidx[usaxlabelpos]%%100

plot_usa_volume <-ggplot()+
  geom_line(aes(x = usaxseq, y = domestic * scale, color = "Domestic mobility"), size = 1.5,data=usad) +
  geom_line(aes(x = usaxseq, y = -npi * scale+200, color = "Oxford data"), size = 1.5,data=usad) +
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_shape_manual(values = c(0, 1), 
                     name = "Treatment")+
  annotate("text", label = "The U.S.", x = 8, y =  1.45 * scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="year", y = "Domestic volume") +
  scale_x_continuous(breaks=usaxlabelpos, label=usaxlabel,expand = c(0.01,0),sec.axis=dup_axis(name="",breaks = c(1,54),labels = c("","")))+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.3* scale),sec.axis=dup_axis(name="Restriction level",breaks = c(0,100,200),labels = c("-2","-1","0"))) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 81, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(x = 1, xend = 81, y = Inf, yend = Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = Inf, xend = Inf), color = "darkgray") +
  theme(
    legend.position = c(0.95, 0.8),
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

title_cn <- ggdraw() +
  draw_label("2020", hjust = 8, size=13,vjust = 3.5)+
  draw_label("2021", hjust = -16, size=13,vjust = 3.5)
# combine above 8 plots into one figure

prow <- plot_grid(title_cn,
                  plot_cn_volume + labs(x = ""),
                  plot_cs_volume + theme(legend.position = "none") + labs(x = ""),
                  plot_uk_volume + theme(legend.position = "none") + labs(x = ""),
                  plot_usa_volume + theme(legend.position = "none") + labs(x = "Week"),
                  rel_heights = c(0.01,1,1,1,1),
                  label_x = c(0,0.001, 0.001, 0.001, 0.001), 
                  label_y = c(0,1.05,1.05,1.05,1.05),
                  nrow = 5, labels = c("","a", "b",  "c", "d"))
prow


finalplot <- plot_grid( NULL,NULL,prow,NULL, nrow = 2, 
                       rel_heights = c(0.02,1),rel_widths = c(1,0.02))
finalplot


outfile <- glue("Source plot/output/oxford_vs_volume_2020-2021.tif")
tiff(outfile, width = 20, height = 12, unit = "in", res = 300, compression = "lzw")
print(finalplot)
dev.off()

