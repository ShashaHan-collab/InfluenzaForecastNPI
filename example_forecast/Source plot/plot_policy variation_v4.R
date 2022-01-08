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
              "Mask full " = "#FF4500",
              "Mask frist half " = "#FF4500",
              "Mask second half " = "#FF4500",
              "Dom mobility 50%" = "#F804A2",
              "Dom mobility 30%" = "#F804A2",
              "Dom mobility 70%" = "#F804A2",
              "Int mobility 50%" = "#FF7800",
              "Int mobility 30%" = "#FF7800",
              "Int mobility 70%" = "#FF7800")
line_type<-c("No intervention" = "solid", 
             "No intervention" = "solid", 
             "No intervention" = "solid", 
             "Mask full " = "solid",
             "Mask frist half " = "dashed",
             "Mask second half " = "dotted",
             "Dom mobility 50%" = "solid",
             "Dom mobility 30%" = "dotted",
             "Dom mobility 70%" = "dashed",
             "Int mobility 50%" = "solid",
             "Int mobility 30%" = "dotted",
             "Int mobility 70%" = "dashed")


# northern china
#####
# load data
no<-read.xlsx("Source Data/plot_policy variation_v4/cn.xlsx", sheetName = "no")
mask<-read.xlsx("Source Data/plot_policy variation_v4/cn.xlsx", sheetName = "mask")
mask4550<-read.xlsx("Source Data/plot_policy variation_v4/cn.xlsx", sheetName = "mask45-50")
mask5104<-read.xlsx("Source Data/plot_policy variation_v4/cn.xlsx", sheetName = "mask51-4")
mvni<-read.xlsx("Source Data/plot_policy variation_v4/cn.xlsx", sheetName = "mvni")
m3vni<-read.xlsx("Source Data/plot_policy variation_v4/cn.xlsx", sheetName = "3vni")
m7vni<-read.xlsx("Source Data/plot_policy variation_v4/cn.xlsx", sheetName = "7vni")
nvmi<-read.xlsx("Source Data/plot_policy variation_v4/cn.xlsx", sheetName = "nvmi")
nv3i<-read.xlsx("Source Data/plot_policy variation_v4/cn.xlsx", sheetName = "nv3i")
nv7i<-read.xlsx("Source Data/plot_policy variation_v4/cn.xlsx", sheetName = "nv7i")

cnmask<-mask%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202148, NA))%>%
  mutate(scenario = "Mask full ")
cnmask4550<-mask4550%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202148, NA))%>%
  mutate(scenario = "Mask frist half ")
cnmask5104<-mask5104%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202148, NA))%>%
  mutate(scenario = "Mask second half ")
cnmvni<-mvni%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202148, NA))%>%
  mutate(scenario = "Dom mobility 50%")
cn3vni<-m3vni%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202148, NA))%>%
  mutate(scenario = "Dom mobility 70%")
cn7vni<-m7vni%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202148, NA))%>%
  mutate(scenario = "Dom mobility 30%")
cnnvmi<-nvmi%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202148, NA))%>%
  mutate(scenario = "Int mobility 50%")
cnnv3i<-nv3i%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202148, NA))%>%
  mutate(scenario = "Int mobility 70%")
cnnv7i<-nv7i%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202148, NA))%>%
  mutate(scenario = "Int mobility 30%")

# plot subfig 1
cnno<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")


timeidx<-cnno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100


plotf_mask_cn <-ggplot()+
  geom_line(aes(x = xseq, y = mean * scale, color = scenario, linetype=scenario), size = 1.5,data=cnno) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario, linetype=scenario), size = 1.5, data=cnmask) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario, linetype=scenario), size = 1.5, data=cnmask4550) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario, linetype=scenario), size = 1.5, data=cnmask5104) +
  
  scale_color_manual(
    values = line_color,
    name = "Treatment",
  ) +
  scale_linetype_manual(
    values = line_type,
    name = "Treatment",
  ) +
  annotate("text", label = "Mask-wearing, Northern China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=cnno) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=cnnvmi) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=cnnv3i) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=cnnv7i) +

  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_linetype_manual(values = line_type, name = "Treatment")+
  scale_shape_manual(values = c(0, 1, 2, 4),
                     name = "Treatment")+
  annotate("text", label = "International mobility mitigation, Northern China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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
plotf_international_cn

# plot subfig 3
cnno<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")


timeidx<-cnno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100

plotf_domestic_cn <-ggplot()+

  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=cnno) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=cnmvni) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=cn3vni) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=cn7vni) +

  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_linetype_manual(values = line_type, name = "Treatment")+
  scale_shape_manual(values = c(0, 1, 2, 4),
                     name = "Treatment")+
  annotate("text", label = "Domestric mobility mitigation, Northern China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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
no<-read.xlsx("Source Data/plot_policy variation_v4/cs.xlsx", sheetName = "no")
mask<-read.xlsx("Source Data/plot_policy variation_v4/cs.xlsx", sheetName = "mask")
mask4550<-read.xlsx("Source Data/plot_policy variation_v4/cs.xlsx", sheetName = "mask45-50")
mask5104<-read.xlsx("Source Data/plot_policy variation_v4/cs.xlsx", sheetName = "mask51-4")
mvni<-read.xlsx("Source Data/plot_policy variation_v4/cs.xlsx", sheetName = "mvni")
m3vni<-read.xlsx("Source Data/plot_policy variation_v4/cs.xlsx", sheetName = "3vni")
m7vni<-read.xlsx("Source Data/plot_policy variation_v4/cs.xlsx", sheetName = "7vni")
nvmi<-read.xlsx("Source Data/plot_policy variation_v4/cs.xlsx", sheetName = "nvmi")
nv3i<-read.xlsx("Source Data/plot_policy variation_v4/cs.xlsx", sheetName = "nv3i")
nv7i<-read.xlsx("Source Data/plot_policy variation_v4/cs.xlsx", sheetName = "nv7i")

csmask<-mask%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202144, NA))%>%
  mutate(scenario = "Mask full ")
csmask4550<-mask4550%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202144, NA))%>%
  mutate(scenario = "Mask frist half ")
csmask5104<-mask5104%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202144, NA))%>%
  mutate(scenario = "Mask second half ")
csmvni<-mvni%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202144, NA))%>%
  mutate(scenario = "Dom mobility 50%")
cs3vni<-m3vni%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202144, NA))%>%
  mutate(scenario = "Dom mobility 70%")
cs7vni<-m7vni%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202144, NA))%>%
  mutate(scenario = "Dom mobility 30%")
csnvmi<-nvmi%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202144, NA))%>%
  mutate(scenario = "Int mobility 50%")
csnv3i<-nv3i%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202144, NA))%>%
  mutate(scenario = "Int mobility 70%")
csnv7i<-nv7i%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202144, NA))%>%
  mutate(scenario = "Int mobility 30%")

# plot subfig 1
csno<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")


timeidx<-csno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100

plotf_mask_cs <-ggplot()+
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=csno) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario, linetype = scenario), size = 1.5,data=csmask) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario, linetype = scenario), size = 1.5, data=csmask4550) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario, linetype = scenario), size = 1.5, data=csmask5104) +

  scale_color_manual(values = line_color, name = "Treatment")+
  scale_linetype_manual(values = line_type, name = "Treatment")+
  scale_shape_manual(values = c(0, 1, 2, 4),
                     name = "Treatment")+
  annotate("text", label = "Mask-wearing, Southern China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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
plotf_mask_cs

# plot subfig 2
csno<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")


timeidx<-csno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100

plotf_international_cs <-ggplot()+
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=csno) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=csnvmi) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=csnv3i) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=csnv7i) +

  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_linetype_manual(values = line_type, name = "Treatment")+
  scale_shape_manual(values = c(0, 1, 2, 4),
                     name = "Treatment")+
  annotate("text", label = "International mobility mitigation, Southern China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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

  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=csno) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=csmvni) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=cs3vni) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=cs7vni) +

  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_linetype_manual(values = line_type, name = "Treatment")+
  scale_shape_manual(values = c(0, 1, 2, 4),
                     name = "Treatment")+
  annotate("text", label = "Domestric mobility mitigation, Southern China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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
no<-read.xlsx("Source Data/plot_policy variation_v4/uk.xlsx", sheetName = "no")
mask<-read.xlsx("Source Data/plot_policy variation_v4/uk.xlsx", sheetName = "mask")
mask4550<-read.xlsx("Source Data/plot_policy variation_v4/uk.xlsx", sheetName = "mask45-50")
mask5104<-read.xlsx("Source Data/plot_policy variation_v4/uk.xlsx", sheetName = "mask51-4")
mvni<-read.xlsx("Source Data/plot_policy variation_v4/uk.xlsx", sheetName = "mvni")
m3vni<-read.xlsx("Source Data/plot_policy variation_v4/uk.xlsx", sheetName = "3vni")
m7vni<-read.xlsx("Source Data/plot_policy variation_v4/uk.xlsx", sheetName = "7vni")
nvmi<-read.xlsx("Source Data/plot_policy variation_v4/uk.xlsx", sheetName = "nvmi")
nv3i<-read.xlsx("Source Data/plot_policy variation_v4/uk.xlsx", sheetName = "nv3i")
nv7i<-read.xlsx("Source Data/plot_policy variation_v4/uk.xlsx", sheetName = "nv7i")

ukmask<-mask%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202149, NA))%>%
  mutate(scenario = "Mask full ")
ukmask4550<-mask4550%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202149, NA))%>%
  mutate(scenario = "Mask frist half ")
ukmask5104<-mask5104%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202149, NA))%>%
  mutate(scenario = "Mask second half ")
ukmvni<-mvni%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202149, NA))%>%
  mutate(scenario = "Dom mobility 50%")
uk3vni<-m3vni%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202149, NA))%>%
  mutate(scenario = "Dom mobility 70%")
uk7vni<-m7vni%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202149, NA))%>%
  mutate(scenario = "Dom mobility 30%")
uknvmi<-nvmi%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202149, NA))%>%
  mutate(scenario = "Int mobility 50%")
uknv3i<-nv3i%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202149, NA))%>%
  mutate(scenario = "Int mobility 70%")
uknv7i<-nv7i%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202149, NA))%>%
  mutate(scenario = "Int mobility 30%")

# plot subfig 1
ukno<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")


timeidx<-ukno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100

plotf_mask_uk <-ggplot()+
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=ukno) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario, linetype = scenario), size = 1.5,data=ukmask) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario, linetype = scenario), size = 1.5, data=ukmask4550) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario, linetype = scenario), size = 1.5, data=ukmask5104) +

  scale_color_manual(values = line_color, name = "Treatment")+
  scale_linetype_manual(values = line_type, name = "Treatment")+
  scale_shape_manual(values = c(0, 1, 2, 4),
                     name = "Treatment")+
  annotate("text", label = "Mask-wearing, England", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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
plotf_mask_uk

# plot subfig 2
ukno<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")


timeidx<-ukno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100

plotf_international_uk <-ggplot()+
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=ukno) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=uknvmi) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=uknv3i) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=uknv7i) +

  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_linetype_manual(values = line_type, name = "Treatment")+
  scale_shape_manual(values = c(0, 1, 2, 4),
                     name = "Treatment")+
  annotate("text", label = "International mobility mitigation, England", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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

  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=ukno) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=ukmvni) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=uk3vni) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=uk7vni) +

  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_linetype_manual(values = line_type, name = "Treatment")+
  scale_shape_manual(values = c(0, 1, 2, 4),
                     name = "Treatment")+
  annotate("text", label = "Domestric mobility mitigation, England", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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
no<-read.xlsx("Source Data/plot_policy variation_v4/usa.xlsx", sheetName = "no")
mask<-read.xlsx("Source Data/plot_policy variation_v4/usa.xlsx", sheetName = "mask")
mask4550<-read.xlsx("Source Data/plot_policy variation_v4/usa.xlsx", sheetName = "mask45-50")
mask5104<-read.xlsx("Source Data/plot_policy variation_v4/usa.xlsx", sheetName = "mask51-4")
mvni<-read.xlsx("Source Data/plot_policy variation_v4/usa.xlsx", sheetName = "mvni")
m3vni<-read.xlsx("Source Data/plot_policy variation_v4/usa.xlsx", sheetName = "3vni")
m7vni<-read.xlsx("Source Data/plot_policy variation_v4/usa.xlsx", sheetName = "7vni")
nvmi<-read.xlsx("Source Data/plot_policy variation_v4/usa.xlsx", sheetName = "nvmi")
nv3i<-read.xlsx("Source Data/plot_policy variation_v4/usa.xlsx", sheetName = "nv3i")
nv7i<-read.xlsx("Source Data/plot_policy variation_v4/usa.xlsx", sheetName = "nv7i")

usamask<-mask%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202147, NA))%>%
  mutate(scenario = "Mask full ")
usamask4550<-mask4550%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202147, NA))%>%
  mutate(scenario = "Mask frist half ")
usamask5104<-mask5104%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202147, NA))%>%
  mutate(scenario = "Mask second half ")
usamvni<-mvni%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202147, NA))%>%
  mutate(scenario = "Dom mobility 50%")
usa3vni<-m3vni%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202147, NA))%>%
  mutate(scenario = "Dom mobility 70%")
usa7vni<-m7vni%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202147, NA))%>%
  mutate(scenario = "Dom mobility 30%")
usanvmi<-nvmi%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202147, NA))%>%
  mutate(scenario = "Int mobility 50%")
usanv3i<-nv3i%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202147, NA))%>%
  mutate(scenario = "Int mobility 70%")
usanv7i<-nv7i%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202147, NA))%>%
  mutate(scenario = "Int mobility 30%")

# plot subfig 1
usano<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")


timeidx<-usano$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100

plotf_mask_usa <-ggplot()+
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=usano) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario, linetype = scenario), size = 1.5,data=usamask) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario, linetype = scenario), size = 1.5, data=usamask4550) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario, linetype = scenario), size = 1.5, data=usamask5104) +

  scale_color_manual(values = line_color, name = "Treatment")+
  scale_linetype_manual(values = line_type, name = "Treatment")+
  scale_shape_manual(values = c(0, 1, 2, 4),
                     name = "Treatment")+
  annotate("text", label = "Mask-wearing, the U.S.", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=usano) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=usanvmi) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=usanv3i) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=usanv7i) +

  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_linetype_manual(values = line_type, name = "Treatment")+
  scale_shape_manual(values = c(0, 1, 2, 4),
                     name = "Treatment")+
  annotate("text", label = "International mobility mitigation, the U.S.", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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
plotf_international_usa

# plot subfig 3
usano<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")


timeidx<-usano$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100

plotf_domestic_usa <-ggplot()+

  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=usano) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=usamvni) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=usa3vni) +
  geom_line(aes(x = xseq, y = mean * scale, color = scenario,linetype = scenario), size = 1.5,data=usa7vni) +

  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_linetype_manual(values = line_type, name = "Treatment")+
  scale_shape_manual(values = c(0, 1, 2, 4),
                     name = "Treatment")+
  annotate("text", label = "Domestric mobility mitigation, the U.S.", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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


# combine above 12 plots into one figure
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


# outfile <- glue("Source plot/output/policy_implication.tif")
# tiff(outfile, width = 20, height = 18, unit = "in", res = 300, compression = "lzw")
pdf("Source plot/output/policy_implication.pdf", width = 20, height = 18)
print(finalplot)
dev.off()
