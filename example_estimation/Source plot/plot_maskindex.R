rm(list = ls())

library(tidyverse)
library(glue)
library(xlsx)
library(cowplot)
library(scales)
library(lubridate)
library(grid)
# library(pBrackets)

#https://blog.datawrapper.de/beautifulcolors/

makelabel <- function(len) {
  xseq<-seq(1,len,by=10)
  xseq[length(xseq)]<-len
  return(xseq)
}


scale = 1
ylimits = 1.0

line_color<-c("maskindex" = "#20B2AA")


##############################
# plot northern china
# load data
maskindex<-read.xlsx("Source Data/plot_maskindex/cn.xlsx", sheetName = "vaccine")

cnvaccine<-maskindex%>% filter(time>=202001&time<=202139)%>%
  mutate(maskindex = replace(maskindex, time > 202128, NA))%>%
  mutate(maskindex = replace(maskindex, time < 202004, NA))%>%
  mutate(scenario = "maskindex")
cntimeidx<-cnvaccine$time
cnxseq<-seq(1,length(cntimeidx))
cnxlabelpos<-makelabel(length(cntimeidx))
cnxlabel<-cntimeidx[cnxlabelpos]%%100


plot_cn_vaccine <-ggplot(cnvaccine)+
  geom_line(aes(x = cnxseq, y = maskindex * scale, color = "maskindex"), size = 1.5) +
  scale_color_manual(values = line_color,
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1), 
                     name = "Treatment")+
  # annotate("text", label = "Northern China", x = 25, y =  0.8* scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="year", y = "Mask Index") +
  scale_x_continuous(breaks=cnxlabelpos, label=cnxlabel,sec.axis=dup_axis(name="",breaks = c(1,54),labels = c("","")))+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.2* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 92, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  geom_segment(aes(x = 1, xend = 92, y = Inf, yend = Inf), color = "darkgray") +
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
    axis.title.y = element_text(size = 13, color = "black", face = "bold"),
  )
plot_cn_vaccine


# plot Southern China
# load data
maskindex<-read.xlsx("Source Data/plot_maskindex/cs.xlsx", sheetName = "vaccine")

csvaccine<-maskindex%>% filter(time>=202001&time<=202139)%>%
  mutate(maskindex = replace(maskindex, time > 202128, NA))%>%
  mutate(maskindex = replace(maskindex, time < 202004, NA))%>%
  mutate(scenario = "maskindex")
cstimeidx<-csvaccine$time
csxseq<-seq(1,length(cstimeidx))
csxlabelpos<-makelabel(length(cstimeidx))
csxlabel<-cstimeidx[csxlabelpos]%%100

plot_cs_vaccine <-ggplot()+
  geom_line(aes(x = csxseq, y = maskindex * scale, color = "maskindex"), size = 1.5,data=csvaccine) +
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_shape_manual(values = c(0, 1), 
                     name = "Treatment")+
  # annotate("text", label = "Southern China", x = 25, y =  0.8* scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="year", y = "Mask Index") +
  scale_x_continuous(breaks=csxlabelpos, label=csxlabel,sec.axis=dup_axis(name="",breaks = c(1,54),labels = c("","")))+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.2* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 92, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  geom_segment(aes(x = 1, xend = 92, y = Inf, yend = Inf), color = "darkgray") +
  # geom_segment(aes(y = -Inf, yend = 1, x = 1, xend = 1), color = "darkgray" ,size=1.5) +
  # annotate("text", label = "Year 2020", x = 2, y = 0.4, colour = "#20B2AA",hjust = 0)+
  # geom_segment(aes(y = -Inf, yend = 1, x = 54, xend = 54), color = "darkgray" ,size=1.5) +
  # annotate("text", label = "Year 2021", x = 55, y = 0.4, colour = "#20B2AA",hjust = 0)+
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
maskindex<-read.xlsx("Source Data/plot_maskindex/uk.xlsx", sheetName = "vaccine")

ukvaccine<-maskindex%>% filter(time>=202001&time<=202139)%>%
  mutate(maskindex = replace(maskindex, time > 202128, NA))%>%
  mutate(maskindex = replace(maskindex, time < 202030, NA))%>%
  mutate(scenario = "maskindex")
uktimeidx<-ukvaccine$time
ukxseq<-seq(1,length(uktimeidx))
ukxlabelpos<-makelabel(length(uktimeidx))
ukxlabel<-uktimeidx[ukxlabelpos]%%100

plot_uk_vaccine <-ggplot()+
  geom_line(aes(x = ukxseq, y = maskindex * scale, color = "maskindex"), size = 1.5,data=ukvaccine) +
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_shape_manual(values = c(0, 1), 
                     name = "Treatment")+
  # annotate("text", label = "England", x = 25, y =  0.8* scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="year", y = "Mask Index") +
  scale_x_continuous(breaks=ukxlabelpos, label=ukxlabel,sec.axis=dup_axis(name="",breaks = c(1,54),labels = c("","")))+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.2* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 92, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  geom_segment(aes(x = 1, xend = 92, y = Inf, yend = Inf), color = "darkgray") +
  # geom_segment(aes(y = -Inf, yend = 1, x = 1, xend = 1), color = "darkgray" ,size=1.5) +
  # annotate("text", label = "Year 2020", x = 2, y = 0.4, colour = "#20B2AA",hjust = 0)+
  # geom_segment(aes(y = -Inf, yend = 1, x = 54, xend = 54), color = "darkgray" ,size=1.5) +
  # annotate("text", label = "Year 2021", x = 55, y = 0.4, colour = "#20B2AA",hjust = 0)+
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

# plot the U.S.
# load data
maskindex<-read.xlsx("Source Data/plot_maskindex/usa.xlsx", sheetName = "vaccine")

usavaccine<-maskindex%>% filter(time>=202001&time<=202139)%>%
  mutate(maskindex = replace(maskindex, time > 202128, NA))%>%
  mutate(maskindex = replace(maskindex, time < 202014, NA))%>%
  mutate(scenario = "maskindex")
usatimeidx<-usavaccine$time
usaxseq<-seq(1,length(usatimeidx))
usaxlabelpos<-makelabel(length(usatimeidx))
usaxlabel<-usatimeidx[usaxlabelpos]%%100

plot_usa_vaccine <-ggplot()+
  geom_line(aes(x = usaxseq, y = maskindex * scale, color = "maskindex"), size = 1.5,data=usavaccine) +
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_shape_manual(values = c(0, 1), 
                     name = "Treatment")+
  # annotate("text", label = "The U.S.", x = 25, y =  0.8* scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="year", y = "Mask Index") +
  scale_x_continuous(breaks=usaxlabelpos, label=usaxlabel,sec.axis=dup_axis(name="",breaks = c(1,54),labels = c("","")))+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.2* scale)) +
  # geom_segment(aes(y = -Inf, yend = 1, x = 1, xend = 1), color = "darkgray" ,size=1.5) +
  # annotate("text", label = "Year 2020", x = 2, y = 0.4, colour = "#20B2AA",hjust = 0)+
  # geom_segment(aes(y = -Inf, yend = 1, x = 54, xend = 54), color = "darkgray" ,size=1.5) +
  # annotate("text", label = "Year 2021", x = 55, y = 0.4, colour = "#20B2AA",hjust = 0)+
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 92, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  geom_segment(aes(x = 1, xend = 92, y = Inf, yend = Inf), color = "darkgray") +
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

title_cn <- ggdraw() + draw_label("Northern China", fontface='bold',hjust = 0.3, size=13)+
  draw_label("2020", hjust = 2.1, size=13,vjust = 4)+
  draw_label("2021", hjust = -3.8, size=13,vjust = 4)
title_cs <- ggdraw() + draw_label("Southern China", fontface='bold',hjust = 0.3, size=13)+
  draw_label("2020", hjust = 2.1, size=13,vjust = 4)+
  draw_label("2021", hjust = -3.8, size=13,vjust = 4)
title_uk <- ggdraw() + draw_label("England", fontface='bold',hjust = 0.15, size=13)+
  draw_label("2020", hjust = 2.1, size=13,vjust = 4)+
  draw_label("2021", hjust = -3.8, size=13,vjust = 4)
title_usa <- ggdraw() + draw_label("The U.S.", fontface='bold',hjust = 0.15, size=13)+
  draw_label("2020", hjust = 2.1, size=13,vjust = 4)+
  draw_label("2021", hjust = -3.8, size=13,vjust = 4)

# combine above 8 plots into one figure
prow <- plot_grid(title_cn,
                  title_cs,
                  plot_cn_vaccine + theme(legend.position = "none")+ labs(x = ""),
                  plot_cs_vaccine + theme(legend.position = "none") + labs(x = "",y=""),
                  title_uk,
                  title_usa,
                  plot_uk_vaccine + theme(legend.position = "none") + labs(x = "Week"),
                  plot_usa_vaccine + theme(legend.position = "none") + labs(x = "Week",y=""),
                  rel_widths = c(1, 1), 
                  rel_heights = c(0.02,1,0.02,1),
                  label_x = c(0.1, 0.1, 0, 0, 0.1, 0.1, 0,0), 
                  nrow = 4, labels = c("a", "b", "", "", "c", "d", "",""))
prow

#legend <- get_legend(plotf_mask_cn19)

finalplot <- plot_grid( NULL,NULL,prow,NULL, nrow = 2, 
                       rel_heights = c(0.02,1),rel_widths = c(1,0.02))
finalplot


outfile <- glue("Source plot/output/Maskindex_2020-2021.tif")
tiff(outfile, width = 12, height = 12, unit = "in", res = 300, compression = "lzw")
print(finalplot)
dev.off()

