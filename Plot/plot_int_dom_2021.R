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

##############################
# plot northern china
# load data
TwoNpi<-read.xlsx("Source Data/plot_int_dom_2021/cn.xlsx", sheetName = "bothtwonpis")
NoNpi<-read.xlsx("Source Data/plot_int_dom_2021/cn.xlsx", sheetName = "neithertwonpis")
d1i2<-read.xlsx("Source Data/plot_int_dom_2021/cn.xlsx", sheetName = "d1i2")
d2i1<-read.xlsx("Source Data/plot_int_dom_2021/cn.xlsx", sheetName = "d2i1")

cn20TwoNpi<-TwoNpi%>% filter(time>=202040&time<=202139)%>%
  mutate(positive_rate = replace(positive_rate, time > 202128, NA))%>%
  mutate(scenario = "Observed intervention", lower = positive_rate, upper = positive_rate, mean = positive_rate)
cnd1i2<-d1i2%>% filter(time>=202040&time<=202139)%>%
  mutate(scenario = "Dom mobility change alone")
cnd2i1<-d2i1%>% filter(time>=202040&time<=202139) %>%
  #mutate(mean = replace(mean, time <= 202003, NA))%>%
  mutate(scenario = "Int mobility change alone")
cn20NoNpi<-NoNpi%>% filter(time>=202040&time<=202139)%>%
  mutate(scenario = "No intervention")


#plot 20-21 season_d2i1
cn20timeidx<-cn20TwoNpi$time
cn20xseq<-seq(1,length(cn20timeidx))
xlabelpos<-makelabel(length(cn20timeidx))
xlabel<-cn20timeidx[xlabelpos]%%100

plotf_cn_d2i1 <-ggplot()+
  geom_ribbon(aes(x = cn20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#dceef2", color = NA, 
              alpha = 0.8, data = cn20NoNpi)+
  geom_ribbon(aes(x = cn20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#fece11", color = NA,
              alpha = 0.2, data = cnd2i1)+
  # geom_ribbon(aes(x = cn20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FFC0CB", color = NA, 
  #             alpha = 0.8, data = cn20Mask)+
  geom_line(aes(x = cn20xseq, y = mean * scale, color = "Int mobility change alone"), size = 1.5,data=cnd2i1) +
  geom_line(aes(x = cn20xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=cn20NoNpi) +
  geom_line(aes(x = cn20xseq, y = positive_rate * scale, color = "Observed intervention"), size = 1.5,data=cn20TwoNpi) +
  # geom_line(aes(x = cn20xseq, y = mean * scale, color = "Mask-wearing alone"), size = 1.5, data=cn20Mask) +
  scale_color_manual(values = c(
    "Observed intervention" = "#3CB371",#"#8A2BE2",
    "Int mobility change alone" = "#FF7800",
    "Dom mobility change alone" = "#F804A2", 
    "No intervention" = "#00B2EE"
  ),
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "2020 - 2021 season, Northern China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="Week", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 53, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.6, 0.8),
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
plotf_cn_d2i1

#plot 20-21 season_d1i2
cn20timeidx<-cn20TwoNpi$time
cn20xseq<-seq(1,length(cn20timeidx))
xlabelpos<-makelabel(length(cn20timeidx))
xlabel<-cn20timeidx[xlabelpos]%%100

plotf_cn_d1i2 <-ggplot()+
  geom_ribbon(aes(x = cn20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#dceef2", color = NA, 
              alpha = 0.8, data = cn20NoNpi)+
  geom_ribbon(aes(x = cn20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FDAFEB", color = NA,
              alpha = 0.2, data = cnd1i2)+
  # geom_ribbon(aes(x = cn20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FFC0CB", color = NA, 
  #             alpha = 0.8, data = cn20Mask)+
  geom_line(aes(x = cn20xseq, y = mean * scale, color = "Dom mobility change alone"), size = 1.5,data=cnd1i2) +
  geom_line(aes(x = cn20xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=cn20NoNpi) +
  geom_line(aes(x = cn20xseq, y = positive_rate * scale, color = "Observed intervention"), size = 1.5,data=cn20TwoNpi) +
  # geom_line(aes(x = cn20xseq, y = mean * scale, color = "Mask-wearing alone"), size = 1.5, data=cn20Mask) +
  scale_color_manual(values = c(
    "Observed intervention" = "#3CB371",#"#8A2BE2",
    "Int mobility change alone" = "#FF7800",
    "Dom mobility change alone" = "#F804A2", 
    "No intervention" = "#00B2EE"
  ),
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "2020 - 2021 season, Northern China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="Week", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 53, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.6, 0.8),
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
plotf_cn_d1i2

##############################

################
##############################
# plot Southern china
# load data
TwoNpi<-read.xlsx("Source Data/plot_int_dom_2021/cs.xlsx", sheetName = "bothtwonpis")
NoNpi<-read.xlsx("Source Data/plot_int_dom_2021/cs.xlsx", sheetName = "neithertwonpis")
d1i2<-read.xlsx("Source Data/plot_int_dom_2021/cs.xlsx", sheetName = "d1i2")
d2i1<-read.xlsx("Source Data/plot_int_dom_2021/cs.xlsx", sheetName = "d2i1")

cs20TwoNpi<-TwoNpi%>% filter(time>=202040&time<=202139)%>%
  mutate(positive_rate = replace(positive_rate, time > 202128, NA))%>%
  mutate(scenario = "Observed intervention", lower = positive_rate, upper = positive_rate, mean = positive_rate)
csd1i2<-d1i2%>% filter(time>=202040&time<=202139)%>%
  mutate(scenario = "Dom mobility change alone")
csd2i1<-d2i1%>% filter(time>=202040&time<=202139) %>%
  #mutate(mean = replace(mean, time <= 202003, NA))%>%
  mutate(scenario = "Int mobility change alone")
cs20NoNpi<-NoNpi%>% filter(time>=202040&time<=202139)%>%
  mutate(scenario = "No intervention")


#plot 20-21 season_d2i1
cs20timeidx<-cs20TwoNpi$time
cs20xseq<-seq(1,length(cs20timeidx))
xlabelpos<-makelabel(length(cs20timeidx))
xlabel<-cs20timeidx[xlabelpos]%%100

plotf_cs_d2i1 <-ggplot()+
  geom_ribbon(aes(x = cs20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#dceef2", color = NA, 
              alpha = 0.8, data = cs20NoNpi)+
  geom_ribbon(aes(x = cs20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#fece11", color = NA,
              alpha = 0.2, data = csd2i1)+
  # geom_ribbon(aes(x = cs20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FFC0CB", color = NA, 
  #             alpha = 0.8, data = cs20Mask)+
  geom_line(aes(x = cs20xseq, y = mean * scale, color = "Int mobility change alone"), size = 1.5,data=csd2i1) +
  geom_line(aes(x = cs20xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=cs20NoNpi) +
  geom_line(aes(x = cs20xseq, y = positive_rate * scale, color = "Observed intervention"), size = 1.5,data=cs20TwoNpi) +
  # geom_line(aes(x = cs20xseq, y = mean * scale, color = "Mask-wearing alone"), size = 1.5, data=cs20Mask) +
  scale_color_manual(values = c(
    "Observed intervention" = "#3CB371",#"#8A2BE2",
    "Int mobility change alone" = "#FF7800",
    "Dom mobility change alone" = "#F804A2", 
    "No intervention" = "#00B2EE"
  ),
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "2020 - 2021 season, Southern China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="Week", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 53, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.87, 0.95),
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
plotf_cs_d2i1

#plot 20-21 season_d1i2
cs20timeidx<-cs20TwoNpi$time
cs20xseq<-seq(1,length(cs20timeidx))
xlabelpos<-makelabel(length(cs20timeidx))
xlabel<-cs20timeidx[xlabelpos]%%100

plotf_cs_d1i2 <-ggplot()+
  geom_ribbon(aes(x = cs20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#dceef2", color = NA, 
              alpha = 0.8, data = cs20NoNpi)+
  geom_ribbon(aes(x = cs20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FDAFEB", color = NA,
              alpha = 0.2, data = csd1i2)+
  # geom_ribbon(aes(x = cs20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FFC0CB", color = NA, 
  #             alpha = 0.8, data = cs20Mask)+
  geom_line(aes(x = cs20xseq, y = mean * scale, color = "Dom mobility change alone"), size = 1.5,data=csd1i2) +
  geom_line(aes(x = cs20xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=cs20NoNpi) +
  geom_line(aes(x = cs20xseq, y = positive_rate * scale, color = "Observed intervention"), size = 1.5,data=cs20TwoNpi) +
  # geom_line(aes(x = cs20xseq, y = mean * scale, color = "Mask-wearing alone"), size = 1.5, data=cs20Mask) +
  scale_color_manual(values = c(
    "Observed intervention" = "#3CB371",#"#8A2BE2",
    "Int mobility change alone" = "#FF7800",
    "Dom mobility change alone" = "#F804A2", 
    "No intervention" = "#00B2EE"
  ),
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "2020 - 2021 season, Southern China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="Week", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 53, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.87, 0.95),
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
plotf_cs_d1i2

##############################
# plot England
# load data
TwoNpi<-read.xlsx("Source Data/plot_int_dom_2021/uk.xlsx", sheetName = "bothtwonpis")
NoNpi<-read.xlsx("Source Data/plot_int_dom_2021/uk.xlsx", sheetName = "neithertwonpis")
d1i2<-read.xlsx("Source Data/plot_int_dom_2021/uk.xlsx", sheetName = "d1i2")
d2i1<-read.xlsx("Source Data/plot_int_dom_2021/uk.xlsx", sheetName = "d2i1")

uk20TwoNpi<-TwoNpi%>% filter(time>=202040&time<=202139)%>%
  mutate(positive_rate = replace(positive_rate, time > 202128, NA))%>%
  mutate(scenario = "Observed intervention", lower = positive_rate, upper = positive_rate, mean = positive_rate)
ukd1i2<-d1i2%>% filter(time>=202040&time<=202139)%>%
  mutate(scenario = "Dom mobility change alone")
ukd2i1<-d2i1%>% filter(time>=202040&time<=202139) %>%
  #mutate(mean = replace(mean, time <= 202003, NA))%>%
  mutate(scenario = "Int mobility change alone")
uk20NoNpi<-NoNpi%>% filter(time>=202040&time<=202139)%>%
  mutate(scenario = "No intervention")


#plot 20-21 season_d2i1
uk20timeidx<-uk20TwoNpi$time
uk20xseq<-seq(1,length(uk20timeidx))
xlabelpos<-makelabel(length(uk20timeidx))
xlabel<-uk20timeidx[xlabelpos]%%100

plotf_uk_d2i1 <-ggplot()+
  geom_ribbon(aes(x = uk20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#dceef2", color = NA, 
              alpha = 0.8, data = uk20NoNpi)+
  geom_ribbon(aes(x = uk20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#fece11", color = NA,
              alpha = 0.2, data = ukd2i1)+
  # geom_ribbon(aes(x = uk20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FFC0CB", color = NA, 
  #             alpha = 0.8, data = uk20Mask)+
  geom_line(aes(x = uk20xseq, y = mean * scale, color = "Int mobility change alone"), size = 1.5,data=ukd2i1) +
  geom_line(aes(x = uk20xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=uk20NoNpi) +
  geom_line(aes(x = uk20xseq, y = positive_rate * scale, color = "Observed intervention"), size = 1.5,data=uk20TwoNpi) +
  # geom_line(aes(x = uk20xseq, y = mean * scale, color = "Mask-wearing alone"), size = 1.5, data=uk20Mask) +
  scale_color_manual(values = c(
    "Observed intervention" = "#3CB371",#"#8A2BE2",
    "Int mobility change alone" = "#FF7800",
    "Dom mobility change alone" = "#F804A2", 
    "No intervention" = "#00B2EE"
  ),
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "2020 - 2021 season, England", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="Week", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 53, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.87, 0.95),
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
plotf_uk_d2i1

#plot 20-21 season_d1i2
uk20timeidx<-uk20TwoNpi$time
uk20xseq<-seq(1,length(uk20timeidx))
xlabelpos<-makelabel(length(uk20timeidx))
xlabel<-uk20timeidx[xlabelpos]%%100

plotf_uk_d1i2 <-ggplot()+
  geom_ribbon(aes(x = uk20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#dceef2", color = NA, 
              alpha = 0.8, data = uk20NoNpi)+
  geom_ribbon(aes(x = uk20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FDAFEB", color = NA,
              alpha = 0.2, data = ukd1i2)+
  # geom_ribbon(aes(x = uk20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FFC0CB", color = NA, 
  #             alpha = 0.8, data = uk20Mask)+
  geom_line(aes(x = uk20xseq, y = mean * scale, color = "Dom mobility change alone"), size = 1.5,data=ukd1i2) +
  geom_line(aes(x = uk20xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=uk20NoNpi) +
  geom_line(aes(x = uk20xseq, y = positive_rate * scale, color = "Observed intervention"), size = 1.5,data=uk20TwoNpi) +
  # geom_line(aes(x = uk20xseq, y = mean * scale, color = "Mask-wearing alone"), size = 1.5, data=uk20Mask) +
  scale_color_manual(values = c(
    "Observed intervention" = "#3CB371",#"#8A2BE2",
    "Int mobility change alone" = "#FF7800",
    "Dom mobility change alone" = "#F804A2", 
    "No intervention" = "#00B2EE"
  ),
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "2020 - 2021 season, England", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="Week", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 53, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.87, 0.95),
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
plotf_uk_d1i2

##############################
# plot U.S.
# load data
TwoNpi<-read.xlsx("Source Data/plot_int_dom_2021/usa.xlsx", sheetName = "bothtwonpis")
NoNpi<-read.xlsx("Source Data/plot_int_dom_2021/usa.xlsx", sheetName = "neithertwonpis")
d1i2<-read.xlsx("Source Data/plot_int_dom_2021/usa.xlsx", sheetName = "d1i2")
d2i1<-read.xlsx("Source Data/plot_int_dom_2021/usa.xlsx", sheetName = "d2i1")

usa20TwoNpi<-TwoNpi%>% filter(time>=202040&time<=202139)%>%
  mutate(positive_rate = replace(positive_rate, time > 202128, NA))%>%
  mutate(scenario = "Observed intervention", lower = positive_rate, upper = positive_rate, mean = positive_rate)
usad1i2<-d1i2%>% filter(time>=202040&time<=202139)%>%
  mutate(scenario = "Dom mobility change alone")
usad2i1<-d2i1%>% filter(time>=202040&time<=202139) %>%
  #mutate(mean = replace(mean, time <= 202003, NA))%>%
  mutate(scenario = "Int mobility change alone")
usa20NoNpi<-NoNpi%>% filter(time>=202040&time<=202139)%>%
  mutate(scenario = "No intervention")


#plot 20-21 season_d2i1
usa20timeidx<-usa20TwoNpi$time
usa20xseq<-seq(1,length(usa20timeidx))
xlabelpos<-makelabel(length(usa20timeidx))
xlabel<-usa20timeidx[xlabelpos]%%100

plotf_usa_d2i1 <-ggplot()+
  geom_ribbon(aes(x = usa20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#dceef2", color = NA, 
              alpha = 0.8, data = usa20NoNpi)+
  geom_ribbon(aes(x = usa20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#fece11", color = NA,
              alpha = 0.2, data = usad2i1)+
  # geom_ribbon(aes(x = usa20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FFC0CB", color = NA, 
  #             alpha = 0.8, data = usa20Mask)+
  geom_line(aes(x = usa20xseq, y = mean * scale, color = "Int mobility change alone"), size = 1.5,data=usad2i1) +
  geom_line(aes(x = usa20xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=usa20NoNpi) +
  geom_line(aes(x = usa20xseq, y = positive_rate * scale, color = "Observed intervention"), size = 1.5,data=usa20TwoNpi) +
  # geom_line(aes(x = usa20xseq, y = mean * scale, color = "Mask-wearing alone"), size = 1.5, data=usa20Mask) +
  scale_color_manual(values = c(
    "Observed intervention" = "#3CB371",#"#8A2BE2",
    "Int mobility change alone" = "#FF7800",
    "Dom mobility change alone" = "#F804A2", 
    "No intervention" = "#00B2EE"
  ),
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "2020 - 2021 season, U.S. ", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="Week", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 53, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.87, 0.95),
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
plotf_usa_d2i1

#plot 20-21 season_d1i2
usa20timeidx<-usa20TwoNpi$time
usa20xseq<-seq(1,length(usa20timeidx))
xlabelpos<-makelabel(length(usa20timeidx))
xlabel<-usa20timeidx[xlabelpos]%%100

plotf_usa_d1i2 <-ggplot()+
  geom_ribbon(aes(x = usa20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#dceef2", color = NA, 
              alpha = 0.8, data = usa20NoNpi)+
  geom_ribbon(aes(x = usa20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FDAFEB", color = NA,
              alpha = 0.2, data = usad1i2)+
  # geom_ribbon(aes(x = usa20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FFC0CB", color = NA, 
  #             alpha = 0.8, data = usa20Mask)+
  geom_line(aes(x = usa20xseq, y = mean * scale, color = "Dom mobility change alone"), size = 1.5,data=usad1i2) +
  geom_line(aes(x = usa20xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=usa20NoNpi) +
  geom_line(aes(x = usa20xseq, y = positive_rate * scale, color = "Observed intervention"), size = 1.5,data=usa20TwoNpi) +
  # geom_line(aes(x = usa20xseq, y = mean * scale, color = "Mask-wearing alone"), size = 1.5, data=usa20Mask) +
  scale_color_manual(values = c(
    "Observed intervention" = "#3CB371",#"#8A2BE2",
    "Int mobility change alone" = "#FF7800",
    "Dom mobility change alone" = "#F804A2", 
    "No intervention" = "#00B2EE"
  ),
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "2020 - 2021 season, U.S.", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="Week", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 53, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.87, 0.95),
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
plotf_usa_d1i2



# combine above 8 plots into one figure
prow <- plot_grid(plotf_cn_d2i1 + labs(x = ""),
                  NULL,
                  plotf_cs_d2i1 + theme(legend.position = "none") + labs(x = "", y = ""),
                  NULL,
                  plotf_uk_d2i1 + theme(legend.position = "none") + labs(x = "", y = ""),
                  NULL,
                  plotf_usa_d2i1 + theme(legend.position = "none") + labs(x = "", y = ""),
                  NULL,
                  plotf_cn_d1i2 ,
                  NULL,
                  plotf_cs_d1i2 + theme(legend.position = "none") + labs(y = ""),
                  NULL,
                  plotf_uk_d1i2 + theme(legend.position = "none") + labs(y = ""), 
                  NULL,
                  plotf_usa_d1i2 + theme(legend.position = "none") + labs(y = ""), 
                  rel_widths = c(1, -0.05, 1, -0.05, 1, -0.05, 1,-0.05, 1, -0.05, 1,-0.05, 1, -0.05, 1), 
                  label_x = c(0.1, 0, 0.1, 0, 0.1, 0, 0.1, 0, 0.1, 0, 0.1,0, 0.1, 0, 0.1), 
                  nrow = 2, labels = c("a", "", "b", "", "c", "", "d", "", "e", "", "f","","g","","h"))
prow

#legend <- get_legend(plotf_mask_cn19)

finalplot <- plot_grid( NULL,NULL,prow,NULL, nrow = 2, 
                       rel_heights = c(0.02,1),rel_widths = c(1,0.02))
finalplot


outfile <- glue("output/mobility_2019_2021_Int_Dom.tif")
tiff(outfile, width = 20, height = 12, unit = "in", res = 300, compression = "lzw")
print(finalplot)
dev.off()

