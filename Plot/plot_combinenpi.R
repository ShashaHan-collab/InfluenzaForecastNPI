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
makelabel <- function(len) {
  xseq<-seq(1,len,by=10)
  xseq[length(xseq)]<-len
  return(xseq)
}

scale = 100
ylimits = 50

line_color<-c("No intervention" = "#3CB371", 
              "No intervention" = "#3CB371", 
              "No intervention" = "#3CB371", 
              "Dom mobility 50%  + Int mobility 50%" = "#FF4500",
              "Mask + Dom mobility 50%" = "#F804A2",
              "Mask + Int mobility 50%" = "#FF7800")


# northern china
#####
# load data
no<-read.xlsx("Source Data/plot_combinenpi/cn.xlsx", sheetName = "no")
mask<-read.xlsx("Source Data/plot_combinenpi/cn.xlsx", sheetName = "mvmi")
mvni<-read.xlsx("Source Data/plot_combinenpi/cn.xlsx", sheetName = "mask50v")
nvmi<-read.xlsx("Source Data/plot_combinenpi/cn.xlsx", sheetName = "mask50i")

cnmask<-mask%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202148, NA))%>%
  mutate(upper = replace(upper, time <= 202148, NA))%>%
  mutate(lower = replace(lower, time <= 202148, NA))%>%
  mutate(scenario = "Dom mobility 50%  + Int mobility 50%")
cnmvni<-mvni%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202148, NA))%>%
  mutate(upper = replace(upper, time <= 202148, NA))%>%
  mutate(lower = replace(lower, time <= 202148, NA))%>%
  mutate(scenario = "Mask + Dom mobility 50%")
cnnvmi<-nvmi%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202148, NA))%>%
  mutate(upper = replace(upper, time <= 202148, NA))%>%
  mutate(lower = replace(lower, time <= 202148, NA))%>%
  mutate(scenario = "Mask + Int mobility 50%")

# plot subfig 1
cnno<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")


timeidx<-cnno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100

plotf_mask_cn <-ggplot()+
  geom_ribbon(aes(x = xseq, ymax = upper * scale,ymin = lower*scale), fill = "#00B488", color = NA, 
              alpha = 0.2, data = cnno)+ 
  geom_ribbon(aes(x = xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FFC0CB", color = NA, 
              alpha = 0.8, data = cnmask)+
  geom_line(aes(x = xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=cnno) +
  geom_line(aes(x = xseq, y = mean * scale, color = "Dom mobility 50%  + Int mobility 50%"), size = 1.5,data=cnmask) +
  
  scale_color_manual(values = line_color,
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "Dom and Int mobility, Northern China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  labs(x="", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 52, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.7, 0.8),
    legend.title=element_blank(),
    # legend.title = element_text(size = 13, color = "black"),
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
plotf_mask_cn

# plot subfig 2
cnno<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")


timeidx<-cnno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100

plotf_international_cn <-ggplot()+
  geom_ribbon(aes(x = xseq, ymax = upper * scale,ymin = lower*scale), fill = "#00B488", color = NA, 
              alpha = 0.2, data = cnno)+ 
  geom_ribbon(aes(x = xseq, ymax = upper * scale,ymin = lower*scale), fill = "#fece11", color = NA, 
              alpha = 0.3, data = cnnvmi)+
  geom_line(aes(x = xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=cnno) +
  geom_line(aes(x = xseq, y = mean * scale, color = "Mask + Int mobility 50%"), size = 1.5,data=cnnvmi) +
  
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "Mask and Int mobility mitigation, Northern China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  labs( x="", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 52, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.7, 0.8),
    legend.title=element_blank(),
    # legend.title = element_text(size = 13, color = "black"),
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
plotf_international_cn

# plot subfig 3
cnno<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")


timeidx<-cnno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100

plotf_domestic_cn <-ggplot()+
  geom_ribbon(aes(x = xseq, ymax = upper * scale,ymin = lower*scale), fill = "#00B488", color = NA, 
              alpha = 0.2, data = cnno)+ 
  geom_ribbon(aes(x = xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FDAFEB", color = NA, 
              alpha = 0.3, data = cnmvni)+
  
  geom_line(aes(x = xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=cnno) +
  geom_line(aes(x = xseq, y = mean * scale, color = "Mask + Dom mobility 50%"), size = 1.5,data=cnmvni) +
  
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "Mask and Dom mobility mitigation, Northern China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  labs(x="Week", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 52, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.7, 0.8),
    legend.title=element_blank(),
    # legend.title = element_text(size = 13, color = "black"),
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
plotf_domestic_cn


# southern china
#####
# load data
no<-read.xlsx("Source Data/plot_combinenpi/cs.xlsx", sheetName = "no")
mask<-read.xlsx("Source Data/plot_combinenpi/cs.xlsx", sheetName = "mvmi")
mvni<-read.xlsx("Source Data/plot_combinenpi/cs.xlsx", sheetName = "mask50v")
nvmi<-read.xlsx("Source Data/plot_combinenpi/cs.xlsx", sheetName = "mask50i")

csmask<-mask%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202144, NA))%>%
  mutate(upper = replace(upper, time <= 202144, NA))%>%
  mutate(lower = replace(lower, time <= 202144, NA))%>%
  mutate(scenario = "Dom mobility 50%  + Int mobility 50%")
csmvni<-mvni%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202144, NA))%>%
  mutate(upper = replace(upper, time <= 202144, NA))%>%
  mutate(lower = replace(lower, time <= 202144, NA))%>%
  mutate(scenario = "Mask + Dom mobility 50%")
csnvmi<-nvmi%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202144, NA))%>%
  mutate(upper = replace(upper, time <= 202144, NA))%>%
  mutate(lower = replace(lower, time <= 202144, NA))%>%
  mutate(scenario = "Mask + Int mobility 50%")

# plot subfig 1
csno<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")


timeidx<-csno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100

plotf_mask_cs <-ggplot()+
  geom_ribbon(aes(x = xseq, ymax = upper * scale,ymin = lower*scale), fill = "#00B488", color = NA, 
              alpha = 0.2, data = csno)+ 
  geom_ribbon(aes(x = xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FFC0CB", color = NA, 
              alpha = 0.8, data = csmask)+
  geom_line(aes(x = xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=csno) +
  geom_line(aes(x = xseq, y = mean * scale, color = "Dom mobility 50%  + Int mobility 50%"), size = 1.5,data=csmask) +
  
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "Dom and Int mobility, Southern China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  labs( x="", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 52, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.7, 0.8),
    legend.title=element_blank(),
    # legend.title = element_text(size = 13, color = "black"),
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
plotf_mask_cs

# plot subfig 2
csno<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")


timeidx<-csno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100

plotf_international_cs <-ggplot()+
   geom_ribbon(aes(x = xseq, ymax = upper * scale,ymin = lower*scale), fill = "#00B488", color = NA, 
              alpha = 0.2, data = csno)+ 
  geom_ribbon(aes(x = xseq, ymax = upper * scale,ymin = lower*scale), fill = "#fece11", color = NA, 
              alpha = 0.3, data = csnvmi)+
  geom_line(aes(x = xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=csno) +
  geom_line(aes(x = xseq, y = mean * scale, color = "Mask + Int mobility 50%"), size = 1.5,data=csnvmi) +
  
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "Mask and Int mobility mitigation, Southern China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  labs(x="", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 52, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.7, 0.8),
    legend.title=element_blank(),
    # legend.title = element_text(size = 13, color = "black"),
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
plotf_international_cs

# plot subfig 3
csno<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")


timeidx<-csno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100

plotf_domestic_cs <-ggplot()+
  geom_ribbon(aes(x = xseq, ymax = upper * scale,ymin = lower*scale), fill = "#00B488", color = NA, 
              alpha = 0.2, data = csno)+ 
  geom_ribbon(aes(x = xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FDAFEB", color = NA, 
              alpha = 0.3, data = csmvni)+
  
  geom_line(aes(x = xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=csno) +
  geom_line(aes(x = xseq, y = mean * scale, color = "Mask + Dom mobility 50%"), size = 1.5,data=csmvni) +
  
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "Mask and Dom mobility mitigation, Southern China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  labs(x="Week", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 52, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.7, 0.8),
    legend.title=element_blank(),
    # legend.title = element_text(size = 13, color = "black"),
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
plotf_domestic_cs

# England
#####
# load data
no<-read.xlsx("Source Data/plot_combinenpi/uk.xlsx", sheetName = "no")
mask<-read.xlsx("Source Data/plot_combinenpi/uk.xlsx", sheetName = "mvmi")
mvni<-read.xlsx("Source Data/plot_combinenpi/uk.xlsx", sheetName = "mask50v")
nvmi<-read.xlsx("Source Data/plot_combinenpi/uk.xlsx", sheetName = "mask50i")

ukmask<-mask%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202149, NA))%>%
  mutate(upper = replace(upper, time <= 202149, NA))%>%
  mutate(lower = replace(lower, time <= 202149, NA))%>%
  mutate(scenario = "Dom mobility 50%  + Int mobility 50%")
ukmvni<-mvni%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202149, NA))%>%
  mutate(upper = replace(upper, time <= 202149, NA))%>%
  mutate(lower = replace(lower, time <= 202149, NA))%>%
  mutate(scenario = "Mask + Dom mobility 50%")
uknvmi<-nvmi%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202149, NA))%>%
  mutate(upper = replace(upper, time <= 202149, NA))%>%
  mutate(lower = replace(lower, time <= 202149, NA))%>%
  mutate(scenario = "Mask + Int mobility 50%")

# plot subfig 1
ukno<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")


timeidx<-ukno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100

plotf_mask_uk <-ggplot()+
  geom_ribbon(aes(x = xseq, ymax = upper * scale,ymin = lower*scale), fill = "#00B488", color = NA, 
              alpha = 0.2, data = ukno)+ 
  geom_ribbon(aes(x = xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FFC0CB", color = NA, 
              alpha = 0.8, data = ukmask)+
  
  geom_line(aes(x = xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=ukno) +
  geom_line(aes(x = xseq, y = mean * scale, color = "Dom mobility 50%  + Int mobility 50%"), size = 1.5,data=ukmask) +
  
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "Dom and Int mobility, England", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  labs(x="",  y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 52, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.7, 0.8),
    legend.title=element_blank(),
    # legend.title = element_text(size = 13, color = "black"),
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
plotf_mask_uk

# plot subfig 2
ukno<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")


timeidx<-ukno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100

plotf_international_uk <-ggplot()+
  geom_ribbon(aes(x = xseq, ymax = upper * scale,ymin = lower*scale), fill = "#00B488", color = NA, 
              alpha = 0.2, data = ukno)+ 
  geom_ribbon(aes(x = xseq, ymax = upper * scale,ymin = lower*scale), fill = "#fece11", color = NA, 
              alpha = 0.3, data = uknvmi)+
  
  geom_line(aes(x = xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=ukno) +
  geom_line(aes(x = xseq, y = mean * scale, color = "Mask + Int mobility 50%"), size = 1.5,data=uknvmi) +
  
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "Mask and Int mobility mitigation, England", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  labs(x="", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 52, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.7, 0.8),
    legend.title=element_blank(),
    # legend.title = element_text(size = 13, color = "black"),
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
plotf_international_uk

# plot subfig 3
ukno<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")


timeidx<-ukno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100

plotf_domestic_uk <-ggplot()+
  geom_ribbon(aes(x = xseq, ymax = upper * scale,ymin = lower*scale), fill = "#00B488", color = NA, 
              alpha = 0.2, data = ukno)+ #"#00B488"
  geom_ribbon(aes(x = xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FDAFEB", color = NA, 
              alpha = 0.3, data = ukmvni)+
  
  geom_line(aes(x = xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=ukno) +
  geom_line(aes(x = xseq, y = mean * scale, color = "Mask + Dom mobility 50%"), size = 1.5,data=ukmvni) +
  
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "Mask and Dom mobility mitigation, England", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  labs(x="Week", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 52, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.7, 0.8),
    legend.title=element_blank(),
    # legend.title = element_text(size = 13, color = "black"),
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
plotf_domestic_uk


# the U.S.
#####
# load data
no<-read.xlsx("Source Data/plot_combinenpi/usa.xlsx", sheetName = "no")
mask<-read.xlsx("Source Data/plot_combinenpi/usa.xlsx", sheetName = "mvmi")
mvni<-read.xlsx("Source Data/plot_combinenpi/usa.xlsx", sheetName = "mask50v")
nvmi<-read.xlsx("Source Data/plot_combinenpi/usa.xlsx", sheetName = "mask50i")

usamask<-mask%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202147, NA))%>%
  mutate(upper = replace(upper, time <= 202147, NA))%>%
  mutate(lower = replace(lower, time <= 202147, NA))%>%
  mutate(scenario = "Dom mobility 50%  + Int mobility 50%")
usamvni<-mvni%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202147, NA))%>%
  mutate(upper = replace(upper, time <= 202147, NA))%>%
  mutate(lower = replace(lower, time <= 202147, NA))%>%
  mutate(scenario = "Mask + Dom mobility 50%")
usanvmi<-nvmi%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202147, NA))%>%
  mutate(upper = replace(upper, time <= 202147, NA))%>%
  mutate(lower = replace(lower, time <= 202147, NA))%>%
  mutate(scenario = "Mask + Int mobility 50%")

# plot subfig 1
usano<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")


timeidx<-usano$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100

plotf_mask_usa <-ggplot()+
  geom_ribbon(aes(x = xseq, ymax = upper * scale,ymin = lower*scale), fill = "#00B488", color = NA, 
              alpha = 0.2, data = usano)+ 
  geom_ribbon(aes(x = xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FFC0CB", color = NA, 
              alpha = 0.8, data = usamask)+
  
  geom_line(aes(x = xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=usano) +
  geom_line(aes(x = xseq, y = mean * scale, color = "Dom mobility 50%  + Int mobility 50%"), size = 1.5,data=usamask) +
  
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "Dom and Int mobility, the U.S.", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  labs(x="", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 52, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.7, 0.8),
    legend.title=element_blank(),
    # legend.title = element_text(size = 13, color = "black"),
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
plotf_mask_usa

# plot subfig 2
usano<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")


timeidx<-usano$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100

plotf_international_usa <-ggplot()+
  geom_ribbon(aes(x = xseq, ymax = upper * scale,ymin = lower*scale), fill = "#00B488", color = NA, 
              alpha = 0.2, data = usano)+ 
  geom_ribbon(aes(x = xseq, ymax = upper * scale,ymin = lower*scale), fill = "#fece11", color = NA, 
              alpha = 0.3, data = usanvmi)+
  
  geom_line(aes(x = xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=usano) +
  geom_line(aes(x = xseq, y = mean * scale, color = "Mask + Int mobility 50%"), size = 1.5,data=usanvmi) +
  
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "Mask and Int mobility mitigation, the U.S.", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  labs(x="",  y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 52, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.7, 0.8),
    legend.title=element_blank(),
    # legend.title = element_text(size = 13, color = "black"),
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
plotf_international_usa

# plot subfig 3
usano<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")


timeidx<-usano$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100

plotf_domestic_usa <-ggplot()+
  geom_ribbon(aes(x = xseq, ymax = upper * scale,ymin = lower*scale), fill = "#00B488", color = NA, 
              alpha = 0.2, data = usano)+ 
  geom_ribbon(aes(x = xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FDAFEB", color = NA, 
              alpha = 0.3, data = usamvni)+
  
  geom_line(aes(x = xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=usano) +
  geom_line(aes(x = xseq, y = mean * scale, color = "Mask + Dom mobility 50%"), size = 1.5,data=usamvni) +
  
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "Mask and Dom mobility mitigation, the U.S.", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  labs(x="Week", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 52, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.7, 0.8),
    legend.title=element_blank(),
    # legend.title = element_text(size = 13, color = "black"),
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
plotf_domestic_usa





# combine above 8 plots into one figure
#####
prow <- plot_grid(plotf_mask_cn + labs(x = ""),
                  NULL,
                  plotf_mask_cs + theme(legend.position = "none") + labs(x = "", y = ""),
                  NULL,
                  plotf_mask_uk + theme(legend.position = "none") + labs(x = "", y = ""),
                  NULL,
                  plotf_mask_usa + theme(legend.position = "none") + labs(x = "", y = ""),
                  NULL,
                  plotf_international_cn,
                  NULL,
                  plotf_international_cs + theme(legend.position = "none") + labs(y = ""),
                  NULL,
                  plotf_international_uk + theme(legend.position = "none") + labs(y = ""), 
                  NULL,
                  plotf_international_usa + theme(legend.position = "none") + labs(y = ""), 
                  NULL,
                  plotf_domestic_cn,
                  NULL,
                  plotf_domestic_cs + theme(legend.position = "none") + labs(y = ""),
                  NULL,
                  plotf_domestic_uk + theme(legend.position = "none") + labs(y = ""), 
                  NULL,
                  plotf_domestic_usa + theme(legend.position = "none") + labs(y = ""), 
                  rel_widths = c(1, -0.05, 1, -0.05, 1, -0.05, 1,-0.05, 1, -0.05, 1,-0.05, 1, -0.05, 1,-0.05, 1, -0.05, 1,-0.05, 1, -0.05, 1), 
                  label_x = c(0.1, 0, 0.1, 0, 0.1, 0, 0.1, 0, 0.1, 0, 0.1,0, 0.1, 0, 0.1,0, 0.1, 0, 0.1,0, 0.1, 0, 0.1), 
                  nrow = 3, labels = c("a", "", "b", "", "c", "", "d", "", "e", "", "f","","g","","h","", "i", "", "j","","k","","l"))
prow

#legend <- get_legend(plotf_mask_cn19)

finalplot <- plot_grid( NULL,NULL,prow,NULL, nrow = 2, 
                        rel_heights = c(0.02,1),rel_widths = c(1,0.02))
finalplot


# outfile <- glue("output/combine_npi.tif")
# tiff(outfile, width = 20, height = 18, unit = "in", res = 300, compression = "lzw")
pdf("output/combine_npi.pdf",width = 20, height = 18)
print(finalplot)
dev.off()
