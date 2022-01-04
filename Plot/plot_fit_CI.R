################################################################################
#### Plot Fig. 1 in main text ####
rm(list = ls())

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
ylimits = 50

line_color<-c("Observed" = "#228B22", 
              "Fitted" = "#FF4500")
line_type<-c("Observed" = "solid", 
             "Fitted" = "solid")

##############################
# plot northern china
# load data
Observed<-read.xlsx("Source Data/plot_fit_CI/cn.xlsx", sheetName = "bothtwonpis")
hatyci<-read.xlsx("Source Data/plot_fit_CI/cn.xlsx", sheetName = "hatyci")
lrci<-read.xlsx("Source Data/plot_fit_CI/cn.xlsx", sheetName = "lrci")


cnobserved<-Observed%>% filter(time>=201140&time<=202128)%>%
  mutate(scenario = "Observed", mean = positive_rate,lower = positive_rate,upper = positive_rate)
tmp<-cnobserved
tmp[tmp$time>=201240&tmp$time<=202003,c("mean","lower","upper")]<-hatyci[hatyci$time>=201240&hatyci$time<=202003,c("mean","lower","upper")]
tmp[tmp$time>=202004&tmp$time<=202128,c("mean","lower","upper")]<-lrci[lrci$time>=202004&lrci$time<=202128,c("mean","lower","upper")]
cnfit<-tmp%>% filter(time>=201140&time<=202128)%>%
  mutate(mean = replace(mean, time < 201240, NA))%>%
  mutate(lower = replace(lower, time < 201240, NA))%>%
  mutate(upper = replace(upper, time < 201240, NA))%>%
  mutate(scenario = "Fitted")
cntimeidx<-cnobserved$time
cnxseq<-seq(1,length(cntimeidx))
cnxlabelpos<-makelabel(cntimeidx)
cnxlabel<-as.integer(cntimeidx[cnxlabelpos]/100)

plot_cn_fit <-ggplot()+
  geom_ribbon(aes(x = cnxseq, ymax = upper * scale,ymin = lower*scale), fill = "#FFC0CB", color = NA,
              alpha = 1, data = cnfit)+
  geom_line(aes(x = cnxseq, y = mean * scale, color = "Observed"), size = 0.2,data=cnobserved) +
  geom_line(aes(x = cnxseq, y = mean * scale, color = "Fitted"), size = 0.2,data=cnfit) +
  scale_color_manual(values = line_color,
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1), 
                     name = "Treatment")+
  annotate("text", label = "Northern China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="year", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=cnxlabelpos, label=cnxlabel,expand = c(0.01,0))+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
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
plot_cn_fit


# plot Southern China
# load data
Observed<-read.xlsx("Source Data/plot_fit_CI/cs.xlsx", sheetName = "bothtwonpis")
hatyci<-read.xlsx("Source Data/plot_fit_CI/cs.xlsx", sheetName = "hatyci")
lrci<-read.xlsx("Source Data/plot_fit_CI/cs.xlsx", sheetName = "lrci")

csobserved<-Observed%>% filter(time>=201140&time<=202128)%>%
  mutate(scenario = "Observed", mean = positive_rate,lower = positive_rate,upper = positive_rate)
tmp<-csobserved
tmp[tmp$time>=201240&tmp$time<=202003,c("mean","lower","upper")]<-hatyci[hatyci$time>=201240&hatyci$time<=202003,c("mean","lower","upper")]
tmp[tmp$time>=202004&tmp$time<=202128,c("mean","lower","upper")]<-lrci[lrci$time>=202004&lrci$time<=202128,c("mean","lower","upper")]
csfit<-tmp%>% filter(time>=201140&time<=202128)%>%
  mutate(mean = replace(mean, time < 201240, NA))%>%
  mutate(lower = replace(lower, time < 201240, NA))%>%
  mutate(upper = replace(upper, time < 201240, NA))%>%
  mutate(scenario = "Fitted")
cstimeidx<-csobserved$time
csxseq<-seq(1,length(cstimeidx))
csxlabelpos<-makelabel(cstimeidx)
csxlabel<-as.integer(cstimeidx[csxlabelpos]/100)

plot_cs_fit <-ggplot()+
  geom_ribbon(aes(x = csxseq, ymax = upper * scale,ymin = lower*scale), fill = "#FFC0CB", color = NA,
              alpha = 1, data = csfit)+
  geom_line(aes(x = csxseq, y = mean * scale, color = "Observed"), size = 0.2,data=csobserved) +
  geom_line(aes(x = csxseq, y = mean * scale, color = "Fitted"), size = 0.2,data=csfit) +
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_shape_manual(values = c(0, 1), 
                     name = "Treatment")+
  annotate("text", label = "Southern China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="year", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=csxlabelpos, label=csxlabel,expand = c(0.01,0))+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 510, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.95, 0.9),
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
plot_cs_fit

# plot England
# load data
Observed<-read.xlsx("Source Data/plot_fit_CI/uk.xlsx", sheetName = "bothtwonpis")
hatyci<-read.xlsx("Source Data/plot_fit_CI/uk.xlsx", sheetName = "hatyci")
lrci<-read.xlsx("Source Data/plot_fit_CI/uk.xlsx", sheetName = "lrci")

ukobserved<-Observed%>% filter(time>=201140&time<=202128)%>%
  mutate(scenario = "Observed", mean = positive_rate,lower = positive_rate,upper = positive_rate)
tmp<-ukobserved
tmp[tmp$time>=201240&tmp$time<=202029,c("mean","lower","upper")]<-hatyci[hatyci$time>=201240&hatyci$time<=202029,c("mean","lower","upper")]
tmp[tmp$time>=202030&tmp$time<=202128,c("mean","lower","upper")]<-lrci[lrci$time>=202030&lrci$time<=202128,c("mean","lower","upper")]
ukfit<-tmp%>% filter(time>=201140&time<=202128)%>%
  mutate(mean = replace(mean, time < 201240, NA))%>%
  mutate(lower = replace(lower, time < 201240, NA))%>%
  mutate(upper = replace(upper, time < 201240, NA))%>%
  mutate(scenario = "Fitted")
uktimeidx<-ukobserved$time
ukxseq<-seq(1,length(uktimeidx))
ukxlabelpos<-makelabel(uktimeidx)
ukxlabel<-as.integer(uktimeidx[ukxlabelpos]/100)

plot_uk_fit <-ggplot()+
  geom_ribbon(aes(x = ukxseq, ymax = upper * scale,ymin = lower*scale), fill = "#FFC0CB", color = NA,
              alpha = 1, data = ukfit)+
  geom_line(aes(x = ukxseq, y = mean * scale, color = "Observed"), size = 0.2,data=ukobserved) +
  geom_line(aes(x = ukxseq, y = mean * scale, color = "Fitted"), size = 0.2,data=ukfit) +
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_shape_manual(values = c(0, 1), 
                     name = "Treatment")+
  annotate("text", label = "England", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="year", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=ukxlabelpos, label=ukxlabel,expand = c(0.01,0))+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 510, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.95, 0.9),
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
plot_uk_fit

# plot The U.S.
# load data
Observed<-read.xlsx("Source Data/plot_fit_CI/usa.xlsx", sheetName = "bothtwonpis")
hatyci<-read.xlsx("Source Data/plot_fit_CI/usa.xlsx", sheetName = "hatyci")
lrci<-read.xlsx("Source Data/plot_fit_CI/usa.xlsx", sheetName = "lrci")

usaobserved<-Observed%>% filter(time>=201140&time<=202128)%>%
  mutate(scenario = "Observed", mean = positive_rate,lower = positive_rate,upper = positive_rate)
tmp<-usaobserved
tmp[tmp$time>=201240&tmp$time<=202013,c("mean","lower","upper")]<-hatyci[hatyci$time>=201240&hatyci$time<=202013,c("mean","lower","upper")]
tmp[tmp$time>=202014&tmp$time<=202128,c("mean","lower","upper")]<-lrci[lrci$time>=202014&lrci$time<=202128,c("mean","lower","upper")]
usafit<-tmp%>% filter(time>=201140&time<=202128)%>%
  mutate(mean = replace(mean, time < 201240, NA))%>%
  mutate(lower = replace(lower, time < 201240, NA))%>%
  mutate(upper = replace(upper, time < 201240, NA))%>%
  mutate(scenario = "Fitted")
usatimeidx<-usaobserved$time
usaxseq<-seq(1,length(usatimeidx))
usaxlabelpos<-makelabel(usatimeidx)
usaxlabel<-as.integer(usatimeidx[usaxlabelpos]/100)

plot_usa_fit <-ggplot()+
  geom_ribbon(aes(x = usaxseq, ymax = upper * scale,ymin = lower*scale), fill = "#FFC0CB", color = NA,
              alpha = 1, data = usafit)+
  geom_line(aes(x = usaxseq, y = mean * scale, color = "Observed"), size = 0.2,data=usaobserved) +
  geom_line(aes(x = usaxseq, y = mean * scale, color = "Fitted"), size = 0.2,data=usafit) +
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_shape_manual(values = c(0, 1), 
                     name = "Treatment")+
  annotate("text", label = "The U.S.", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="year", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=usaxlabelpos, label=usaxlabel,expand = c(0.01,0))+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 510, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.95, 0.9),
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
plot_usa_fit




# combine above 8 plots into one figure
prow <- plot_grid(plot_cn_fit + labs(x = ""),
                  plot_cs_fit + theme(legend.position = "none") + labs(x = ""),
                  plot_uk_fit + theme(legend.position = "none") + labs(x = ""),
                  plot_usa_fit + theme(legend.position = "none") + labs(x = "Year"),
                  rel_widths = c(1, 1,  1,  1), 
                  label_x = c(0.001, 0.001, 0.001, 0.001), 
                  label_y = c(1.05,1.05,1.05,1.05),
                  nrow = 4, labels = c("a", "b",  "c", "d"))
prow

#legend <- get_legend(plotf_mask_cn19)

finalplot <- plot_grid( NULL,NULL,prow,NULL, nrow = 2, 
                       rel_heights = c(0.02,1),rel_widths = c(1,0.02))
finalplot


# outfile <- glue("output/Fit_2011-2021_CI.tif")
# tiff(outfile, width = 20, height = 12, unit = "in", res = 300, compression = "lzw")
pdf("output/Fit_2011-2021_CI.pdf",width = 20, height = 12)
print(finalplot)
dev.off()

