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
              "No vaccine" = "#3CB371", 
              "Mask full " = "#FF4500",
              "Mask frist half" = "#FF4500",
              "Mask second half " = "#FF4500",
              "Vaccine" = "#F804A2",
              "Vaccine & mask 70%" = "#F804A2",
              "Mask intensity 50%" = "#FF7800",
              "Mask intensity 30%" = "#FF7800",
              "Mask intensity 70%" = "#FF7800",
              "No Vaccine & mask 70%" = "#F804A2",
              "Dom mobility 50%  + Int mobility 50%" = "#FF7800",
              "Mask + Int mobility 50%" = "#FF4500")
line_type<-c("No intervention" = "solid", 
             "No intervention" = "solid", 
             "No vaccine" = "solid", 
             "Mask full " = "solid",
             "Mask frist half" = "dashed",
             "Mask second half " = "dotted",
             "Vaccine" = "dotted",
             "Vaccine & mask 70%" = "dashed",
             "Mask intensity 50%" = "dashed",
             "Mask intensity 30%" = "dotted",
             "Mask intensity 70%" = "solid",
             "No Vaccine & mask 70%" = "solid",
             "Dom mobility 50%  + Int mobility 50%" = "solid",
             "Mask + Int mobility 50%" = "solid")


# northern china
#####
# load data
no<-read.xlsx("Source Data/policy_implication_mask_v2/cn.xlsx", sheetName = "no")
mask<-read.xlsx("Source Data/policy_implication_mask_v2/cn.xlsx", sheetName = "mask_d")
mask4550<-read.xlsx("Source Data/policy_implication_mask_v2/cn.xlsx", sheetName = "mask45-50_d")
mask5104<-read.xlsx("Source Data/policy_implication_mask_v2/cn.xlsx", sheetName = "mask51-4_d")
nvmi<-read.xlsx("Source Data/policy_implication_mask_v2/cn.xlsx", sheetName = "mask45-50_fwd")
nv3i<-read.xlsx("Source Data/policy_implication_mask_v2/cn.xlsx", sheetName = "mask_fwd")
nv7i<-read.xlsx("Source Data/policy_implication_mask_v2/cn.xlsx", sheetName = "mask51-4_fwd")
vaccine<-read.xlsx("Source Data/policy_implication_mask_v2/cn.xlsx", sheetName = "vaccine")
vaccine30<-read.xlsx("Source Data/policy_implication_mask_v2/cn.xlsx", sheetName = "vaccine_30")
novaccine30<-read.xlsx("Source Data/policy_implication_mask_v2/cn.xlsx", sheetName = "novaccine_30")
mvmi<-read.xlsx("Source Data/policy_implication_mask_v2/cn.xlsx", sheetName = "mvmi")
mask50i<-read.xlsx("Source Data/policy_implication_mask_v2/cn.xlsx", sheetName = "mask50i")



cnmask<-mask%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202148, NA))%>%
  mutate(scenario = "Mask full ")
cnmask4550<-mask4550%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202148, NA))%>%
  mutate(scenario = "Mask frist half")
cnmask5104<-mask5104%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202148, NA))%>%
  mutate(scenario = "Mask second half ")





# plot subfig 1
cnno<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")

timeidx<-cnno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100
cnno<-cnno%>% 
  mutate(time = replace(time,TRUE,xseq))
cnmask<-cnmask%>% 
  mutate(time = replace(time,TRUE,xseq))
cnmask4550<-cnmask4550%>% 
  mutate(time = replace(time,TRUE,xseq))
cnmask5104<-cnmask5104%>% 
  mutate(time = replace(time,TRUE,xseq))

plot_data_1cn <- NULL
plot_data_1cn <- plot_data_1cn %>%
  rbind(cnno,cnmask,cnmask4550,cnmask5104) %>%
  select(time, mean, lower, upper, scenario)
plot_data_1cn$scenario <- factor(plot_data_1cn$scenario, levels=c( "No intervention", "Mask full ","Mask frist half" , "Mask second half "))

plotf_mask_cn <-ggplot(plot_data_1cn)+
  geom_line(aes(x = time, y = mean * scale, color = scenario,linetype=scenario,  group=scenario),size=1.5) +
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
cnnvmi<-nvmi%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202148, NA))%>%
  mutate(scenario = "Mask intensity 70%")
cnnv3i<-nv3i%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202148, NA))%>%
  mutate(scenario = "Mask intensity 50%")
cnnv7i<-nv7i%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202148, NA))%>%
  mutate(scenario = "Mask intensity 30%")
cnno<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")

timeidx<-cnno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100
cnno<-cnno%>% 
  mutate(time = replace(time,TRUE,xseq))
cnnvmi<-cnnvmi%>% 
  mutate(time = replace(time,TRUE,xseq))
cnnv3i<-cnnv3i%>% 
  mutate(time = replace(time,TRUE,xseq))
cnnv7i<-cnnv7i%>% 
  mutate(time = replace(time,TRUE,xseq))

plot_data_2cn <- NULL
plot_data_2cn <- plot_data_2cn %>%
  rbind(cnno,cnnvmi,cnnv3i,cnnv7i) %>%
  select(time, mean, lower, upper, scenario)
plot_data_2cn$scenario <- factor(plot_data_2cn$scenario, levels=c( "No intervention", "Mask intensity 70%","Mask intensity 50%" , "Mask intensity 30%"))


plotf_international_cn <-ggplot(plot_data_2cn)+
  geom_line(aes(x = time, y = mean * scale, color = scenario,linetype=scenario,  group=scenario),size=1.5) +

  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_linetype_manual(values = line_type, name = "Treatment")+
  scale_shape_manual(values = c(0, 1, 2, 4),
                     name = "Treatment")+
  annotate("text", label = "Mask-wearing intensity, Northern China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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
  mutate(scenario = "No vaccine")
cnnovaccine30<-novaccine30%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202148, NA))%>%
  mutate(scenario = "No Vaccine & mask 70%")
cnvaccine30<-vaccine30%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202148, NA))%>%
  mutate(scenario = "Vaccine & mask 70%")
cnvaccine<-vaccine%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202148, NA))%>%
  mutate(scenario = "Vaccine")

timeidx<-cnno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100
cnno<-cnno%>% 
  mutate(time = replace(time,TRUE,xseq))
cnnovaccine30<-cnnovaccine30%>% 
  mutate(time = replace(time,TRUE,xseq))
cnvaccine30<-cnvaccine30%>% 
  mutate(time = replace(time,TRUE,xseq))
cnvaccine<-cnvaccine%>% 
  mutate(time = replace(time,TRUE,xseq))

plot_data_3cn <- NULL
plot_data_3cn <- plot_data_3cn %>%
  rbind(cnno,cnnovaccine30,cnvaccine30,cnvaccine) %>%
  select(time, mean, lower, upper, scenario)
plot_data_3cn$scenario <- factor(plot_data_3cn$scenario, levels=c( "No vaccine", "No Vaccine & mask 70%","Vaccine & mask 70%" , "Vaccine"))

plotf_domestic_cn <-ggplot(plot_data_3cn)+

  geom_line(aes(x = time, y = mean * scale, color = scenario,linetype=scenario,  group=scenario),size=1.5) +

  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_linetype_manual(values = line_type, name = "Treatment")+
  scale_shape_manual(values = c(0, 1, 2, 4),
                     name = "Treatment")+
  annotate("text", label = "Mask-wearing and vaccination, Northern China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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
plotf_domestic_cn

# plot subfig 4
cnno<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")
cnmvmi<-mvmi%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202148, NA))%>%
  mutate(scenario = "Dom mobility 50%  + Int mobility 50%")
cnmask50i<-mask50i%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202148, NA))%>%
  mutate(scenario = "Mask + Int mobility 50%")


timeidx<-cnno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100
cnno<-cnno%>% 
  mutate(time = replace(time,TRUE,xseq))
cnmvmi<-cnmvmi%>% 
  mutate(time = replace(time,TRUE,xseq))
cnmask50i<-cnmask50i%>% 
  mutate(time = replace(time,TRUE,xseq))

plot_data_4cn <- NULL
plot_data_4cn <- plot_data_4cn %>%
  rbind(cnno,cnmvmi,cnmask50i) %>%
  select(time, mean, lower, upper, scenario)
plot_data_4cn$scenario <- factor(plot_data_4cn$scenario, levels=c( "No intervention", "Dom mobility 50%  + Int mobility 50%","Mask + Int mobility 50%" ))

plotf_combine_cn <-ggplot(plot_data_4cn)+
  
  geom_line(aes(x = time, y = mean * scale, color = scenario,linetype=scenario,  group=scenario),size=1.5) +
  
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_linetype_manual(values = line_type, name = "Treatment")+
  scale_shape_manual(values = c(0, 1, 2, 4),
                     name = "Treatment")+
  annotate("text", label = "Combined NPIs, Northern China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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
plotf_combine_cn

# Southern China
#####
# load data
no<-read.xlsx("Source Data/policy_implication_mask_v2/cs.xlsx", sheetName = "no")
mask<-read.xlsx("Source Data/policy_implication_mask_v2/cs.xlsx", sheetName = "mask_d")
mask4550<-read.xlsx("Source Data/policy_implication_mask_v2/cs.xlsx", sheetName = "mask45-50_d")
mask5104<-read.xlsx("Source Data/policy_implication_mask_v2/cs.xlsx", sheetName = "mask51-4_d")
nvmi<-read.xlsx("Source Data/policy_implication_mask_v2/cs.xlsx", sheetName = "mask45-50_fwd")
nv3i<-read.xlsx("Source Data/policy_implication_mask_v2/cs.xlsx", sheetName = "mask_fwd")
nv7i<-read.xlsx("Source Data/policy_implication_mask_v2/cs.xlsx", sheetName = "mask51-4_fwd")
vaccine<-read.xlsx("Source Data/policy_implication_mask_v2/cs.xlsx", sheetName = "vaccine")
vaccine30<-read.xlsx("Source Data/policy_implication_mask_v2/cs.xlsx", sheetName = "vaccine_30")
novaccine30<-read.xlsx("Source Data/policy_implication_mask_v2/cs.xlsx", sheetName = "novaccine_30")
mvmi<-read.xlsx("Source Data/policy_implication_mask_v2/cs.xlsx", sheetName = "mvmi")
mask50i<-read.xlsx("Source Data/policy_implication_mask_v2/cs.xlsx", sheetName = "mask50i")



csmask<-mask%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202144, NA))%>%
  mutate(scenario = "Mask full ")
csmask4550<-mask4550%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202144, NA))%>%
  mutate(scenario = "Mask frist half")
csmask5104<-mask5104%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202144, NA))%>%
  mutate(scenario = "Mask second half ")





# plot subfig 1
csno<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")

timeidx<-csno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100
csno<-csno%>% 
  mutate(time = replace(time,TRUE,xseq))
csmask<-csmask%>% 
  mutate(time = replace(time,TRUE,xseq))
csmask4550<-csmask4550%>% 
  mutate(time = replace(time,TRUE,xseq))
csmask5104<-csmask5104%>% 
  mutate(time = replace(time,TRUE,xseq))

plot_data_1cs <- NULL
plot_data_1cs <- plot_data_1cs %>%
  rbind(csno,csmask,csmask4550,csmask5104) %>%
  select(time, mean, lower, upper, scenario)
plot_data_1cs$scenario <- factor(plot_data_1cs$scenario, levels=c( "No intervention", "Mask full ","Mask frist half" , "Mask second half "))

plotf_mask_cs <-ggplot(plot_data_1cs)+
  geom_line(aes(x = time, y = mean * scale, color = scenario,linetype=scenario,  group=scenario),size=1.5) +
  scale_color_manual(
    values = line_color,
    name = "Treatment",
  ) +
  scale_linetype_manual(
    values = line_type,
    name = "Treatment",
  ) +
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
csnvmi<-nvmi%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202144, NA))%>%
  mutate(scenario = "Mask intensity 70%")
csnv3i<-nv3i%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202144, NA))%>%
  mutate(scenario = "Mask intensity 50%")
csnv7i<-nv7i%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202144, NA))%>%
  mutate(scenario = "Mask intensity 30%")
csno<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")

timeidx<-csno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100
csno<-csno%>% 
  mutate(time = replace(time,TRUE,xseq))
csnvmi<-csnvmi%>% 
  mutate(time = replace(time,TRUE,xseq))
csnv3i<-csnv3i%>% 
  mutate(time = replace(time,TRUE,xseq))
csnv7i<-csnv7i%>% 
  mutate(time = replace(time,TRUE,xseq))

plot_data_2cs <- NULL
plot_data_2cs <- plot_data_2cs %>%
  rbind(csno,csnvmi,csnv3i,csnv7i) %>%
  select(time, mean, lower, upper, scenario)
plot_data_2cs$scenario <- factor(plot_data_2cs$scenario, levels=c( "No intervention", "Mask intensity 70%","Mask intensity 50%" , "Mask intensity 30%"))


plotf_international_cs <-ggplot(plot_data_2cs)+
  geom_line(aes(x = time, y = mean * scale, color = scenario,linetype=scenario,  group=scenario),size=1.5) +
  
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_linetype_manual(values = line_type, name = "Treatment")+
  scale_shape_manual(values = c(0, 1, 2, 4),
                     name = "Treatment")+
  annotate("text", label = "Mask-wearing intensity, Southern China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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
  mutate(scenario = "No vaccine")
csnovaccine30<-novaccine30%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202144, NA))%>%
  mutate(scenario = "No Vaccine & mask 70%")
csvaccine30<-vaccine30%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202144, NA))%>%
  mutate(scenario = "Vaccine & mask 70%")
csvaccine<-vaccine%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202144, NA))%>%
  mutate(scenario = "Vaccine")

timeidx<-csno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100
csno<-csno%>% 
  mutate(time = replace(time,TRUE,xseq))
csnovaccine30<-csnovaccine30%>% 
  mutate(time = replace(time,TRUE,xseq))
csvaccine30<-csvaccine30%>% 
  mutate(time = replace(time,TRUE,xseq))
csvaccine<-csvaccine%>% 
  mutate(time = replace(time,TRUE,xseq))

plot_data_3cs <- NULL
plot_data_3cs <- plot_data_3cs %>%
  rbind(csno,csnovaccine30,csvaccine30,csvaccine) %>%
  select(time, mean, lower, upper, scenario)
plot_data_3cs$scenario <- factor(plot_data_3cs$scenario, levels=c( "No vaccine", "No Vaccine & mask 70%","Vaccine & mask 70%" , "Vaccine"))

plotf_domestic_cs <-ggplot(plot_data_3cs)+
  
  geom_line(aes(x = time, y = mean * scale, color = scenario,linetype=scenario,  group=scenario),size=1.5) +
  
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_linetype_manual(values = line_type, name = "Treatment")+
  scale_shape_manual(values = c(0, 1, 2, 4),
                     name = "Treatment")+
  annotate("text", label = "Mask-wearing and vaccination, Southern China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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
plotf_domestic_cs

# plot subfig 4
csno<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")
csmvmi<-mvmi%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202144, NA))%>%
  mutate(scenario = "Dom mobility 50%  + Int mobility 50%")
csmask50i<-mask50i%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202144, NA))%>%
  mutate(scenario = "Mask + Int mobility 50%")


timeidx<-csno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100
csno<-csno%>% 
  mutate(time = replace(time,TRUE,xseq))
csmvmi<-csmvmi%>% 
  mutate(time = replace(time,TRUE,xseq))
csmask50i<-csmask50i%>% 
  mutate(time = replace(time,TRUE,xseq))

plot_data_4cs <- NULL
plot_data_4cs <- plot_data_4cs %>%
  rbind(csno,csmvmi,csmask50i) %>%
  select(time, mean, lower, upper, scenario)
plot_data_4cs$scenario <- factor(plot_data_4cs$scenario, levels=c( "No intervention", "Dom mobility 50%  + Int mobility 50%","Mask + Int mobility 50%" ))

plotf_combine_cs <-ggplot(plot_data_4cs)+
  
  geom_line(aes(x = time, y = mean * scale, color = scenario,linetype=scenario,  group=scenario),size=1.5) +
  
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_linetype_manual(values = line_type, name = "Treatment")+
  scale_shape_manual(values = c(0, 1, 2, 4),
                     name = "Treatment")+
  annotate("text", label = "Combined NPIs, Southern China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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
plotf_combine_cs


# England
#####
# load data
no<-read.xlsx("Source Data/policy_implication_mask_v2/uk.xlsx", sheetName = "no")
mask<-read.xlsx("Source Data/policy_implication_mask_v2/uk.xlsx", sheetName = "mask_d")
mask4550<-read.xlsx("Source Data/policy_implication_mask_v2/uk.xlsx", sheetName = "mask45-50_d")
mask5104<-read.xlsx("Source Data/policy_implication_mask_v2/uk.xlsx", sheetName = "mask51-4_d")
nvmi<-read.xlsx("Source Data/policy_implication_mask_v2/uk.xlsx", sheetName = "mask45-50_fwd")
nv3i<-read.xlsx("Source Data/policy_implication_mask_v2/uk.xlsx", sheetName = "mask_fwd")
nv7i<-read.xlsx("Source Data/policy_implication_mask_v2/uk.xlsx", sheetName = "mask51-4_fwd")
vaccine<-read.xlsx("Source Data/policy_implication_mask_v2/uk.xlsx", sheetName = "vaccine")
vaccine30<-read.xlsx("Source Data/policy_implication_mask_v2/uk.xlsx", sheetName = "vaccine_30")
novaccine30<-read.xlsx("Source Data/policy_implication_mask_v2/uk.xlsx", sheetName = "novaccine_30")
mvmi<-read.xlsx("Source Data/policy_implication_mask_v2/uk.xlsx", sheetName = "mvmi")
mask50i<-read.xlsx("Source Data/policy_implication_mask_v2/uk.xlsx", sheetName = "mask50i")



ukmask<-mask%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202149, NA))%>%
  mutate(scenario = "Mask full ")
ukmask4550<-mask4550%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202149, NA))%>%
  mutate(scenario = "Mask frist half")
ukmask5104<-mask5104%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202149, NA))%>%
  mutate(scenario = "Mask second half ")





# plot subfig 1
ukno<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")

timeidx<-ukno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100
ukno<-ukno%>% 
  mutate(time = replace(time,TRUE,xseq))
ukmask<-ukmask%>% 
  mutate(time = replace(time,TRUE,xseq))
ukmask4550<-ukmask4550%>% 
  mutate(time = replace(time,TRUE,xseq))
ukmask5104<-ukmask5104%>% 
  mutate(time = replace(time,TRUE,xseq))

plot_data_1uk <- NULL
plot_data_1uk <- plot_data_1uk %>%
  rbind(ukno,ukmask,ukmask4550,ukmask5104) %>%
  select(time, mean, lower, upper, scenario)
plot_data_1uk$scenario <- factor(plot_data_1uk$scenario, levels=c( "No intervention", "Mask full ","Mask frist half" , "Mask second half "))

plotf_mask_uk <-ggplot(plot_data_1uk)+
  geom_line(aes(x = time, y = mean * scale, color = scenario,linetype=scenario,  group=scenario),size=1.5) +
  scale_color_manual(
    values = line_color,
    name = "Treatment",
  ) +
  scale_linetype_manual(
    values = line_type,
    name = "Treatment",
  ) +
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
uknvmi<-nvmi%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202149, NA))%>%
  mutate(scenario = "Mask intensity 70%")
uknv3i<-nv3i%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202149, NA))%>%
  mutate(scenario = "Mask intensity 50%")
uknv7i<-nv7i%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202149, NA))%>%
  mutate(scenario = "Mask intensity 30%")
ukno<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")

timeidx<-ukno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100
ukno<-ukno%>% 
  mutate(time = replace(time,TRUE,xseq))
uknvmi<-uknvmi%>% 
  mutate(time = replace(time,TRUE,xseq))
uknv3i<-uknv3i%>% 
  mutate(time = replace(time,TRUE,xseq))
uknv7i<-uknv7i%>% 
  mutate(time = replace(time,TRUE,xseq))

plot_data_2uk <- NULL
plot_data_2uk <- plot_data_2uk %>%
  rbind(ukno,uknvmi,uknv3i,uknv7i) %>%
  select(time, mean, lower, upper, scenario)
plot_data_2uk$scenario <- factor(plot_data_2uk$scenario, levels=c( "No intervention", "Mask intensity 70%","Mask intensity 50%" , "Mask intensity 30%"))


plotf_international_uk <-ggplot(plot_data_2uk)+
  geom_line(aes(x = time, y = mean * scale, color = scenario,linetype=scenario,  group=scenario),size=1.5) +
  
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_linetype_manual(values = line_type, name = "Treatment")+
  scale_shape_manual(values = c(0, 1, 2, 4),
                     name = "Treatment")+
  annotate("text", label = "Mask-wearing intensity, England", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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
  mutate(scenario = "No vaccine")
uknovaccine30<-novaccine30%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202149, NA))%>%
  mutate(scenario = "No Vaccine & mask 70%")
ukvaccine30<-vaccine30%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202149, NA))%>%
  mutate(scenario = "Vaccine & mask 70%")
ukvaccine<-vaccine%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202149, NA))%>%
  mutate(scenario = "Vaccine")

timeidx<-ukno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100
ukno<-ukno%>% 
  mutate(time = replace(time,TRUE,xseq))
uknovaccine30<-uknovaccine30%>% 
  mutate(time = replace(time,TRUE,xseq))
ukvaccine30<-ukvaccine30%>% 
  mutate(time = replace(time,TRUE,xseq))
ukvaccine<-ukvaccine%>% 
  mutate(time = replace(time,TRUE,xseq))

plot_data_3uk <- NULL
plot_data_3uk <- plot_data_3uk %>%
  rbind(ukno,uknovaccine30,ukvaccine30,ukvaccine) %>%
  select(time, mean, lower, upper, scenario)
plot_data_3uk$scenario <- factor(plot_data_3uk$scenario, levels=c( "No vaccine", "No Vaccine & mask 70%","Vaccine & mask 70%" , "Vaccine"))

plotf_domestic_uk <-ggplot(plot_data_3uk)+
  
  geom_line(aes(x = time, y = mean * scale, color = scenario,linetype=scenario,  group=scenario),size=1.5) +
  
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_linetype_manual(values = line_type, name = "Treatment")+
  scale_shape_manual(values = c(0, 1, 2, 4),
                     name = "Treatment")+
  annotate("text", label = "Mask-wearing and vaccination, England", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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
plotf_domestic_uk

# plot subfig 4
ukno<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")
ukmvmi<-mvmi%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202149, NA))%>%
  mutate(scenario = "Dom mobility 50%  + Int mobility 50%")
ukmask50i<-mask50i%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202149, NA))%>%
  mutate(scenario = "Mask + Int mobility 50%")


timeidx<-ukno$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100
ukno<-ukno%>% 
  mutate(time = replace(time,TRUE,xseq))
ukmvmi<-ukmvmi%>% 
  mutate(time = replace(time,TRUE,xseq))
ukmask50i<-ukmask50i%>% 
  mutate(time = replace(time,TRUE,xseq))

plot_data_4uk <- NULL
plot_data_4uk <- plot_data_4uk %>%
  rbind(ukno,ukmvmi,ukmask50i) %>%
  select(time, mean, lower, upper, scenario)
plot_data_4uk$scenario <- factor(plot_data_4uk$scenario, levels=c( "No intervention", "Dom mobility 50%  + Int mobility 50%","Mask + Int mobility 50%" ))

plotf_combine_uk <-ggplot(plot_data_4uk)+
  
  geom_line(aes(x = time, y = mean * scale, color = scenario,linetype=scenario,  group=scenario),size=1.5) +
  
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_linetype_manual(values = line_type, name = "Treatment")+
  scale_shape_manual(values = c(0, 1, 2, 4),
                     name = "Treatment")+
  annotate("text", label = "Combined NPIs, England", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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
plotf_combine_uk

# the U.S.
#####
# load data
no<-read.xlsx("Source Data/policy_implication_mask_v2/usa.xlsx", sheetName = "no")
mask<-read.xlsx("Source Data/policy_implication_mask_v2/usa.xlsx", sheetName = "mask_d")
mask4550<-read.xlsx("Source Data/policy_implication_mask_v2/usa.xlsx", sheetName = "mask45-50_d")
mask5104<-read.xlsx("Source Data/policy_implication_mask_v2/usa.xlsx", sheetName = "mask51-4_d")
nvmi<-read.xlsx("Source Data/policy_implication_mask_v2/usa.xlsx", sheetName = "mask45-50_fwd")
nv3i<-read.xlsx("Source Data/policy_implication_mask_v2/usa.xlsx", sheetName = "mask_fwd")
nv7i<-read.xlsx("Source Data/policy_implication_mask_v2/usa.xlsx", sheetName = "mask51-4_fwd")
vaccine<-read.xlsx("Source Data/policy_implication_mask_v2/usa.xlsx", sheetName = "vaccine")
vaccine30<-read.xlsx("Source Data/policy_implication_mask_v2/usa.xlsx", sheetName = "vaccine_30")
novaccine30<-read.xlsx("Source Data/policy_implication_mask_v2/usa.xlsx", sheetName = "novaccine_30")
mvmi<-read.xlsx("Source Data/policy_implication_mask_v2/usa.xlsx", sheetName = "mvmi")
mask50i<-read.xlsx("Source Data/policy_implication_mask_v2/usa.xlsx", sheetName = "mask50i")



usamask<-mask%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202147, NA))%>%
  mutate(scenario = "Mask full ")
usamask4550<-mask4550%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202147, NA))%>%
  mutate(scenario = "Mask frist half")
usamask5104<-mask5104%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202147, NA))%>%
  mutate(scenario = "Mask second half ")





# plot subfig 1
usano<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")

timeidx<-usano$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100
usano<-usano%>% 
  mutate(time = replace(time,TRUE,xseq))
usamask<-usamask%>% 
  mutate(time = replace(time,TRUE,xseq))
usamask4550<-usamask4550%>% 
  mutate(time = replace(time,TRUE,xseq))
usamask5104<-usamask5104%>% 
  mutate(time = replace(time,TRUE,xseq))

plot_data_1usa <- NULL
plot_data_1usa <- plot_data_1usa %>%
  rbind(usano,usamask,usamask4550,usamask5104) %>%
  select(time, mean, lower, upper, scenario)
plot_data_1usa$scenario <- factor(plot_data_1usa$scenario, levels=c( "No intervention", "Mask full ","Mask frist half" , "Mask second half "))

plotf_mask_usa <-ggplot(plot_data_1usa)+
  geom_line(aes(x = time, y = mean * scale, color = scenario,linetype=scenario,  group=scenario),size=1.5) +
  scale_color_manual(
    values = line_color,
    name = "Treatment",
  ) +
  scale_linetype_manual(
    values = line_type,
    name = "Treatment",
  ) +
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
usanvmi<-nvmi%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202147, NA))%>%
  mutate(scenario = "Mask intensity 70%")
usanv3i<-nv3i%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202147, NA))%>%
  mutate(scenario = "Mask intensity 50%")
usanv7i<-nv7i%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202147, NA))%>%
  mutate(scenario = "Mask intensity 30%")
usano<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")

timeidx<-usano$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100
usano<-usano%>% 
  mutate(time = replace(time,TRUE,xseq))
usanvmi<-usanvmi%>% 
  mutate(time = replace(time,TRUE,xseq))
usanv3i<-usanv3i%>% 
  mutate(time = replace(time,TRUE,xseq))
usanv7i<-usanv7i%>% 
  mutate(time = replace(time,TRUE,xseq))

plot_data_2usa <- NULL
plot_data_2usa <- plot_data_2usa %>%
  rbind(usano,usanvmi,usanv3i,usanv7i) %>%
  select(time, mean, lower, upper, scenario)
plot_data_2usa$scenario <- factor(plot_data_2usa$scenario, levels=c( "No intervention", "Mask intensity 70%","Mask intensity 50%" , "Mask intensity 30%"))


plotf_international_usa <-ggplot(plot_data_2usa)+
  geom_line(aes(x = time, y = mean * scale, color = scenario,linetype=scenario,  group=scenario),size=1.5) +
  
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_linetype_manual(values = line_type, name = "Treatment")+
  scale_shape_manual(values = c(0, 1, 2, 4),
                     name = "Treatment")+
  annotate("text", label = "Mask-wearing intensity, the U.S.", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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
  mutate(scenario = "No vaccine")
usanovaccine30<-novaccine30%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202147, NA))%>%
  mutate(scenario = "No Vaccine & mask 70%")
usavaccine30<-vaccine30%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202147, NA))%>%
  mutate(scenario = "Vaccine & mask 70%")
usavaccine<-vaccine%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202147, NA))%>%
  mutate(scenario = "Vaccine")

timeidx<-usano$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100
usano<-usano%>% 
  mutate(time = replace(time,TRUE,xseq))
usanovaccine30<-usanovaccine30%>% 
  mutate(time = replace(time,TRUE,xseq))
usavaccine30<-usavaccine30%>% 
  mutate(time = replace(time,TRUE,xseq))
usavaccine<-usavaccine%>% 
  mutate(time = replace(time,TRUE,xseq))

plot_data_3usa <- NULL
plot_data_3usa <- plot_data_3usa %>%
  rbind(usano,usanovaccine30,usavaccine30,usavaccine) %>%
  select(time, mean, lower, upper, scenario)
plot_data_3usa$scenario <- factor(plot_data_3usa$scenario, levels=c( "No vaccine", "No Vaccine & mask 70%","Vaccine & mask 70%" , "Vaccine"))

plotf_domestic_usa <-ggplot(plot_data_3usa)+
  
  geom_line(aes(x = time, y = mean * scale, color = scenario,linetype=scenario,  group=scenario),size=1.5) +
  
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_linetype_manual(values = line_type, name = "Treatment")+
  scale_shape_manual(values = c(0, 1, 2, 4),
                     name = "Treatment")+
  annotate("text", label = "Mask-wearing and vaccination, the U.S.", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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
plotf_domestic_usa

# plot subfig 4
usano<-no%>% filter(time>=202140&time<=202239)%>%
  mutate(scenario = "No intervention")
usamvmi<-mvmi%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202147, NA))%>%
  mutate(scenario = "Dom mobility 50%  + Int mobility 50%")
usamask50i<-mask50i%>% filter(time>=202140&time<=202239)%>%
  mutate(mean = replace(mean, time <= 202147, NA))%>%
  mutate(scenario = "Mask + Int mobility 50%")


timeidx<-usano$time
xseq<-seq(1,length(timeidx))
xlabelpos<-makelabel(length(timeidx))
xlabel<-timeidx[xlabelpos]%%100
usano<-usano%>% 
  mutate(time = replace(time,TRUE,xseq))
usamvmi<-usamvmi%>% 
  mutate(time = replace(time,TRUE,xseq))
usamask50i<-usamask50i%>% 
  mutate(time = replace(time,TRUE,xseq))

plot_data_4usa <- NULL
plot_data_4usa <- plot_data_4usa %>%
  rbind(usano,usamvmi,usamask50i) %>%
  select(time, mean, lower, upper, scenario)
plot_data_4usa$scenario <- factor(plot_data_4usa$scenario, levels=c( "No intervention", "Dom mobility 50%  + Int mobility 50%","Mask + Int mobility 50%" ))

plotf_combine_usa <-ggplot(plot_data_4usa)+
  
  geom_line(aes(x = time, y = mean * scale, color = scenario,linetype=scenario,  group=scenario),size=1.5) +
  
  scale_color_manual(values = line_color,
                     name = "Treatment") +
  scale_linetype_manual(values = line_type, name = "Treatment")+
  scale_shape_manual(values = c(0, 1, 2, 4),
                     name = "Treatment")+
  annotate("text", label = "Combined NPIs, the U.S.", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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
plotf_combine_usa

# combine above 8 plots into one figure
#####
prow <- plot_grid(plotf_international_cn,
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
                  NULL,
                  plotf_combine_cn, 
                  NULL,
                  plotf_combine_cs + theme(legend.position = "none") + labs(y = ""), 
                  NULL,
                  plotf_combine_uk + theme(legend.position = "none") + labs(y = ""), 
                  NULL,
                  plotf_combine_usa + theme(legend.position = "none") + labs(y = ""), 
                  rel_widths = c(1, -0.05, 1, -0.05, 1, -0.05, 1,-0.05, 1, -0.05, 1,-0.05, 1, -0.05, 1,-0.05, 1, -0.05, 1,-0.05, 1, -0.05, 1), 
                  label_x = c(0.1, 0, 0.1, 0, 0.1, 0, 0.1, 0, 0.1, 0, 0.1,0, 0.1, 0, 0.1,0, 0.1, 0, 0.1,0, 0.1, 0, 0.1), 
                  nrow = 3, labels = c("a", "", "b", "", "c", "", "d", "", "e", "", "f","","g","","h","","i", "", "j", "", "k", "", "l"))
prow

#legend <- get_legend(plotf_mask_cn19)

finalplot <- plot_grid( NULL,NULL,prow,NULL, nrow = 2, 
                        rel_heights = c(0.02,1),rel_widths = c(1,0.02))
finalplot


# outfile <- glue("output/policy_implication_mask.tif")
# tiff(outfile, width = 20, height = 18, unit = "in", res = 300, compression = "lzw")
pdf("output/policy_implication_mask.pdf",width = 20, height = 18)
print(finalplot)
dev.off()
