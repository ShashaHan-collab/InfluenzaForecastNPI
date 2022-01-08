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
# plot Minnesota
# load data
TwoNpi<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/mn.xlsx", sheetName = "bothtwonpis")
Move<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/mn.xlsx", sheetName = "movementrestriction")
Mask<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/mn.xlsx", sheetName = "maskwearingorder")
NoNpi<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/mn.xlsx", sheetName = "neithertwonpis")



## TODO: Yan, pls use the coding below to fix the order of the lengend ##
# plot_data <- NULL
# plot_data <- plot_data %>%
#   rbind(TwoNpi,Move,Mask,NoNpi) %>%
#   select(time, mean, lower, upper, scenario)
# plot_data$scenario <- factor(plot_data$scenario, levels=c("No intervention", "Mobility change alone", "Mask-wearing alone","Observed intervention"))

# TwoNpi<-TwoNpi%>% filter(time>=201940&time<=202039)
# Move<-Move%>% filter(time>=201940&time<=202039)
# Mask<-Mask%>% filter(time>=201940&time<=202039)
# NoNpi<-NoNpi%>% filter(time>=201940&time<=202039)

# plot 19-20 season
cn19TwoNpi<-TwoNpi%>% filter(time>=201940&time<=202039)%>%
  mutate(scenario = "Observed intervention", lower = positive_rate, upper = positive_rate, mean = positive_rate)
cn19Move<-Move%>% filter(time>=201940&time<=202039)%>%
  mutate(mean = replace(mean, time <= 202011, NA))%>%
  mutate(scenario = "Mobility change alone")
cn19Mask<-Mask%>% filter(time>=201940&time<=202039) %>%
  mutate(mean = replace(mean, time <= 202029, NA))%>%
  mutate(lower = replace(lower, time <= 202029, NA))%>%
  mutate(upper = replace(upper, time <= 202029, NA))%>%
  mutate(scenario = "Mask-wearing alone")
cn19NoNpi<-NoNpi%>% filter(time>=201940&time<=202039)%>%
  mutate(scenario = "No intervention")
cn19timeidx<-cn19Move$time
cn19xseq<-seq(1,length(cn19timeidx))
#xlabelpos<-makelabel(c(seq(1, length(timeidx), by = 10),length(timeidx))
xlabelpos<-makelabel(length(cn19timeidx))
xlabel<-cn19timeidx[xlabelpos]%%100

plotf_mask_cn19 <-ggplot()+
  # geom_ribbon(aes(x = xseq, ymax = upper * scale,ymin = lower*scale), fill = "#fcedd9", color = NA, 
  #             alpha = 0.8, data = Move)+
  geom_ribbon(aes(x = cn19xseq, ymax = upper * scale,ymin = lower*scale), fill = "#dceef2", color = NA, 
              alpha = 0.8, data = cn19NoNpi)+
  geom_ribbon(aes(x = cn19xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FFC0CB", color = NA, 
              alpha = 0.8, data = cn19Mask)+
  # geom_line(aes(x = xseq, y = mean * scale, color = "Mobility change alone"), size = 1.5,data=Move) +
  geom_line(aes(x = cn19xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=cn19NoNpi) +
  geom_line(aes(x = cn19xseq, y = positive_rate * scale, color = "Observed intervention"), size = 1.5,data=cn19TwoNpi) +
  geom_line(aes(x = cn19xseq, y = mean * scale, color = "Mask-wearing alone"), size = 1.5, data=cn19Mask) +
  scale_color_manual(values = c(
    "Observed intervention" = "#3CB371",#"#8A2BE2",
    "Mobility change alone" = "#eca146",
    "Mask-wearing alone" = "#FF4500", #"#8A2BE2",#"#FC4E07",
    "No intervention" = "#00B2EE"
  ),
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "2019 - 2020 season, Minnesota", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  
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
plotf_mask_cn19
# grid.locator(unit="native")
# grid.brackets(0, 1, 100, 1, lwd=1, ticks=NA, type = 4)



#plot 20-21 season
TwoNpi<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/mn.xlsx", sheetName = "bothtwonpis")
Move<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/mn.xlsx", sheetName = "movementrestriction")
Mask<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/mn.xlsx", sheetName = "maskwearingorder")
NoNpi<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/mn.xlsx", sheetName = "neithertwonpis")
cn20TwoNpi<-TwoNpi%>% filter(time>=202040&time<=202139)%>%
  mutate(positive_rate = replace(positive_rate, time > 202128, NA))%>%
  mutate(scenario = "Observed intervention", lower = positive_rate, upper = positive_rate, mean = positive_rate)
cn20Move<-Move%>% filter(time>=202040&time<=202139)%>%
  #mutate(mean = replace(mean, time <= 202003, NA))%>%
  mutate(scenario = "Mobility change alone")
cn20Mask<-Mask%>% filter(time>=202040&time<=202139) %>%
  #mutate(mean = replace(mean, time <= 202003, NA))%>%
  mutate(scenario = "Mask-wearing alone")
cn20NoNpi<-NoNpi%>% filter(time>=202040&time<=202139)%>%
  mutate(scenario = "No intervention")
cn20timeidx<-cn20Move$time
cn20xseq<-seq(1,length(cn20timeidx))
#xlabelpos<-makelabel(c(seq(1, length(timeidx), by = 10),length(timeidx))
xlabelpos<-makelabel(length(cn20timeidx))
xlabel<-cn20timeidx[xlabelpos]%%100

plotf_mask_cn20 <-ggplot()+
  # geom_ribbon(aes(x = xseq, ymax = upper * scale,ymin = lower*scale), fill = "#fcedd9", color = NA, 
  #             alpha = 0.8, data = Move)+
  geom_ribbon(aes(x = cn20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#dceef2", color = NA, 
              alpha = 0.8, data = cn20NoNpi)+
  geom_ribbon(aes(x = cn20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FFC0CB", color = NA, 
              alpha = 0.8, data = cn20Mask)+
  # geom_line(aes(x = xseq, y = mean * scale, color = "Mobility change alone"), size = 1.5,data=Move) +
  geom_line(aes(x = cn20xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=cn20NoNpi) +
  geom_line(aes(x = cn20xseq, y = positive_rate * scale, color = "Observed intervention"), size = 1.5,data=cn20TwoNpi) +
  geom_line(aes(x = cn20xseq, y = mean * scale, color = "Mask-wearing alone"), size = 1.5, data=cn20Mask) +
  scale_color_manual(values = c(
    "Observed intervention" = "#3CB371",#"#8A2BE2",
    "Mobility change alone" = "#eca146",
    "Mask-wearing alone" = "#FF4500", #"#8A2BE2",#"#FC4E07",
    "No intervention" = "#00B2EE"
  ),
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "2020 - 2021 season, Minnesota", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="Week", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 53, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.7, 0.8),
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
plotf_mask_cn20

##############################

################
# plot Colorado
# load data
TwoNpi<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/co.xlsx", sheetName = "bothtwonpis")
Move<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/co.xlsx", sheetName = "movementrestriction")
Mask<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/co.xlsx", sheetName = "maskwearingorder")
NoNpi<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/co.xlsx", sheetName = "neithertwonpis")



## TODO: Yan, pls use the coding below to fix the order of the lengend ##
# plot_data <- NULL
# plot_data <- plot_data %>%
#   rbind(TwoNpi,Move,Mask,NoNpi) %>%
#   select(time, mean, lower, upper, scenario)
# plot_data$scenario <- factor(plot_data$scenario, levels=c("No intervention", "Mobility change alone", "Mask-wearing alone","Observed intervention"))

# TwoNpi<-TwoNpi%>% filter(time>=201940&time<=202039)
# Move<-Move%>% filter(time>=201940&time<=202039)
# Mask<-Mask%>% filter(time>=201940&time<=202039)
# NoNpi<-NoNpi%>% filter(time>=201940&time<=202039)



# plot 19-20 season
cs19TwoNpi<-TwoNpi%>% filter(time>=201940&time<=202039)%>%
  mutate(scenario = "Observed intervention", lower = positive_rate, upper = positive_rate, mean = positive_rate)
cs19Move<-Move%>% filter(time>=201940&time<=202039)%>%
  mutate(mean = replace(mean, time <= 202011, NA))%>%
  mutate(scenario = "Mobility change alone")
cs19Mask<-Mask%>% filter(time>=201940&time<=202039) %>%
  mutate(mean = replace(mean, time <= 202028, NA))%>%
  mutate(upper = replace(upper, time <= 202028, NA))%>%
  mutate(lower = replace(lower, time <= 202028, NA))%>%
  mutate(scenario = "Mask-wearing alone")
cs19NoNpi<-NoNpi%>% filter(time>=201940&time<=202039)%>%
  mutate(scenario = "No intervention")
cs19timeidx<-cs19Move$time
cs19xseq<-seq(1,length(cs19timeidx))
#xlabelpos<-makelabel(c(seq(1, length(cs19timeidx), by = 10),length(cs19timeidx))
xlabelpos<-makelabel(length(cs19timeidx))
xlabel<-cs19timeidx[xlabelpos]%%100

plotf_mask_cs19 <-ggplot()+
  # geom_ribbon(aes(x = cs19xseq, ymax = upper * scale,ymin = lower*scale), fill = "#fcedd9", color = NA, 
  #             alpha = 0.8, data = Move)+
  geom_ribbon(aes(x = cs19xseq, ymax = upper * scale,ymin = lower*scale), fill = "#dceef2", color = NA, 
              alpha = 0.8, data = cs19NoNpi)+
  geom_ribbon(aes(x = cs19xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FFC0CB", color = NA, 
              alpha = 0.8, data = cs19Mask)+
  # geom_line(aes(x = cs19xseq, y = mean * scale, color = "Mobility change alone"), size = 1.5,data=Move) +
  geom_line(aes(x = cs19xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=cs19NoNpi) +
  geom_line(aes(x = cs19xseq, y = positive_rate * scale, color = "Observed intervention"), size = 1.5,data=cs19TwoNpi) +
  geom_line(aes(x = cs19xseq, y = mean * scale, color = "Mask-wearing alone"), size = 1.5, data=cs19Mask) +
  scale_color_manual(values = c(
    "Observed intervention" = "#3CB371",#"#8A2BE2",
    "Mobility change alone" = "#eca146",
    "Mask-wearing alone" = "#FF4500", #"#8A2BE2",#"#FC4E07",
    "No intervention" = "#00B2EE"
  ),
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "2019 - 2020 season, Colorado", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  
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
plotf_mask_cs19
# grid.locator(unit="native")
# grid.brackets(0, 1, 100, 1, lwd=1, ticks=NA, type = 4)


#plot 20-21 season
TwoNpi<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/co.xlsx", sheetName = "bothtwonpis")
Move<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/co.xlsx", sheetName = "movementrestriction")
Mask<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/co.xlsx", sheetName = "maskwearingorder")
NoNpi<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/co.xlsx", sheetName = "neithertwonpis")
cs20TwoNpi<-TwoNpi%>% filter(time>=202040&time<=202139)%>%
  mutate(positive_rate = replace(positive_rate, time > 202128, NA))%>%
  mutate(scenario = "Observed intervention", lower = positive_rate, upper = positive_rate, mean = positive_rate)
cs20Move<-Move%>% filter(time>=202040&time<=202139)%>%
  #mutate(mean = replace(mean, time <= 202003, NA))%>%
  mutate(scenario = "Mobility change alone")
cs20Mask<-Mask%>% filter(time>=202040&time<=202139) %>%
  #mutate(mean = replace(mean, time <= 202003, NA))%>%
  mutate(scenario = "Mask-wearing alone")
cs20NoNpi<-NoNpi%>% filter(time>=202040&time<=202139)%>%
  mutate(scenario = "No intervention")
cs20timeidx<-cs20Move$time
cs20xseq<-seq(1,length(cs20timeidx))
#xlabelpos<-makelabel(c(seq(1, length(cs20timeidx), by = 10),length(cs20timeidx))
xlabelpos<-makelabel(length(cs20timeidx))
xlabel<-cs20timeidx[xlabelpos]%%100

plotf_mask_cs20 <-ggplot()+
  # geom_ribbon(aes(x = cs20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#fcedd9", color = NA, 
  #             alpha = 0.8, data = Move)+
  geom_ribbon(aes(x = cs20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#dceef2", color = NA, 
              alpha = 0.8, data = cs20NoNpi)+
  geom_ribbon(aes(x = cs20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FFC0CB", color = NA, 
              alpha = 0.8, data = cs20Mask)+
  # geom_line(aes(x = cs20xseq, y = mean * scale, color = "Mobility change alone"), size = 1.5,data=Move) +
  geom_line(aes(x = cs20xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=cs20NoNpi) +
  geom_line(aes(x = cs20xseq, y = positive_rate * scale, color = "Observed intervention"), size = 1.5,data=cs20TwoNpi) +
  geom_line(aes(x = cs20xseq, y = mean * scale, color = "Mask-wearing alone"), size = 1.5, data=cs20Mask) +
  scale_color_manual(values = c(
    "Observed intervention" = "#3CB371",#"#8A2BE2",
    "Mobility change alone" = "#eca146",
    "Mask-wearing alone" = "#FF4500", #"#8A2BE2",#"#FC4E07",
    "No intervention" = "#00B2EE"
  ),
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "2020 - 2021 season, Colorado", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="Week", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 53, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.7, 0.8),
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
plotf_mask_cs20



#######################
# plot uk
# load data
TwoNpi<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/in.xlsx", sheetName = "bothtwonpis")
Move<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/in.xlsx", sheetName = "movementrestriction")
Mask<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/in.xlsx", sheetName = "maskwearingorder")
NoNpi<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/in.xlsx", sheetName = "neithertwonpis")



## TODO: Yan, pls use the coding below to fix the order of the lengend ##
# plot_data <- NULL
# plot_data <- plot_data %>%
#   rbind(TwoNpi,Move,Mask,NoNpi) %>%
#   select(time, mean, lower, upper, scenario)
# plot_data$scenario <- factor(plot_data$scenario, levels=c("No intervention", "Mobility change alone", "Mask-wearing alone","Observed intervention"))

# TwoNpi<-TwoNpi%>% filter(time>=201940&time<=202039)
# Move<-Move%>% filter(time>=201940&time<=202039)
# Mask<-Mask%>% filter(time>=201940&time<=202039)
# NoNpi<-NoNpi%>% filter(time>=201940&time<=202039)

# plot 19-20 season
uk19TwoNpi<-TwoNpi%>% filter(time>=201940&time<=202039)%>%
  mutate(scenario = "Observed intervention", lower = positive_rate, upper = positive_rate, mean = positive_rate)
uk19Move<-Move%>% filter(time>=201940&time<=202039)%>%
  mutate(mean = replace(mean, time <= 202011, NA))%>%
  mutate(scenario = "Mobility change alone")
uk19Mask<-Mask%>% filter(time>=201940&time<=202039) %>%
  mutate(mean = replace(mean, time <= 202030, NA))%>%
  mutate(lower = replace(lower, time <= 202030, NA))%>%
  mutate(upper = replace(upper, time <= 202030, NA))%>%
  mutate(scenario = "Mask-wearing alone")
uk19NoNpi<-NoNpi%>% filter(time>=201940&time<=202039)%>%
  mutate(scenario = "No intervention")
uk19timeidx<-uk19Move$time
uk19xseq<-seq(1,length(uk19timeidx))
#xlabelpos<-makelabel(c(seq(1, length(uk19timeidx), by = 10),length(uk19timeidx))
xlabelpos<-makelabel(length(uk19timeidx))
xlabel<-uk19timeidx[xlabelpos]%%100

plotf_mask_uk19 <-ggplot()+
  # geom_ribbon(aes(x = uk19xseq, ymax = upper * scale,ymin = lower*scale), fill = "#fcedd9", color = NA, 
  #             alpha = 0.8, data = Move)+
  geom_ribbon(aes(x = uk19xseq, ymax = upper * scale,ymin = lower*scale), fill = "#dceef2", color = NA, 
              alpha = 0.8, data = uk19NoNpi)+
  geom_ribbon(aes(x = uk19xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FFC0CB", color = NA, 
              alpha = 0.8, data = uk19Mask)+
  # geom_line(aes(x = uk19xseq, y = mean * scale, color = "Mobility change alone"), size = 1.5,data=Move) +
  geom_line(aes(x = uk19xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=uk19NoNpi) +
  geom_line(aes(x = uk19xseq, y = positive_rate * scale, color = "Observed intervention"), size = 1.5,data=uk19TwoNpi) +
  geom_line(aes(x = uk19xseq, y = mean * scale, color = "Mask-wearing alone"), size = 1.5, data=uk19Mask) +
  scale_color_manual(values = c(
    "Observed intervention" = "#3CB371",#"#8A2BE2",
    "Mobility change alone" = "#eca146",
    "Mask-wearing alone" = "#FF4500", #"#8A2BE2",#"#FC4E07",
    "No intervention" = "#00B2EE"
  ),
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "2019 - 2020 season, Indiana", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  
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
plotf_mask_uk19
# grid.locator(unit="native")
# grid.brackets(0, 1, 100, 1, lwd=1, ticks=NA, type = 4)



#plot 20-21 season
TwoNpi<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/in.xlsx", sheetName = "bothtwonpis")
Move<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/in.xlsx", sheetName = "movementrestriction")
Mask<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/in.xlsx", sheetName = "maskwearingorder")
NoNpi<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/in.xlsx", sheetName = "neithertwonpis")
uk20TwoNpi<-TwoNpi%>% filter(time>=202040&time<=202139)%>%
  mutate(positive_rate = replace(positive_rate, time > 202128, NA))%>%
  mutate(scenario = "Observed intervention", lower = positive_rate, upper = positive_rate, mean = positive_rate)
uk20Move<-Move%>% filter(time>=202040&time<=202139)%>%
  #mutate(mean = replace(mean, time <= 202003, NA))%>%
  mutate(scenario = "Mobility change alone")
uk20Mask<-Mask%>% filter(time>=202040&time<=202139) %>%
  #mutate(mean = replace(mean, time <= 202003, NA))%>%
  mutate(scenario = "Mask-wearing alone")
uk20NoNpi<-NoNpi%>% filter(time>=202040&time<=202139)%>%
  mutate(scenario = "No intervention")
uk20timeidx<-uk20Move$time
uk20xseq<-seq(1,length(uk20timeidx))
#xlabelpos<-makelabel(c(seq(1, length(uk20timeidx), by = 10),length(uk20timeidx))
xlabelpos<-makelabel(length(uk20timeidx))
xlabel<-uk20timeidx[xlabelpos]%%100

plotf_mask_uk20 <-ggplot()+
  # geom_ribbon(aes(x = uk20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#fcedd9", color = NA, 
  #             alpha = 0.8, data = Move)+
  geom_ribbon(aes(x = uk20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#dceef2", color = NA, 
              alpha = 0.8, data = uk20NoNpi)+
  geom_ribbon(aes(x = uk20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FFC0CB", color = NA, 
              alpha = 0.8, data = uk20Mask)+
  # geom_line(aes(x = uk20xseq, y = mean * scale, color = "Mobility change alone"), size = 1.5,data=Move) +
  geom_line(aes(x = uk20xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=uk20NoNpi) +
  geom_line(aes(x = uk20xseq, y = positive_rate * scale, color = "Observed intervention"), size = 1.5,data=uk20TwoNpi) +
  geom_line(aes(x = uk20xseq, y = mean * scale, color = "Mask-wearing alone"), size = 1.5, data=uk20Mask) +
  scale_color_manual(values = c(
    "Observed intervention" = "#3CB371",#"#8A2BE2",
    "Mobility change alone" = "#eca146",
    "Mask-wearing alone" = "#FF4500", #"#8A2BE2",#"#FC4E07",
    "No intervention" = "#00B2EE"
  ),
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "2020 - 2021 season, Indiana", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="Week", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 53, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.7, 0.8),
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
plotf_mask_uk20


#######################
# plot usa
# load data
TwoNpi<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/wa.xlsx", sheetName = "bothtwonpis")
Move<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/wa.xlsx", sheetName = "movementrestriction")
Mask<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/wa.xlsx", sheetName = "maskwearingorder")
NoNpi<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/wa.xlsx", sheetName = "neithertwonpis")



## TODO: Yan, pls use the coding below to fix the order of the lengend ##
# plot_data <- NULL
# plot_data <- plot_data %>%
#   rbind(TwoNpi,Move,Mask,NoNpi) %>%
#   select(time, mean, lower, upper, scenario)
# plot_data$scenario <- factor(plot_data$scenario, levels=c("No intervention", "Mobility change alone", "Mask-wearing alone","Observed intervention"))

# TwoNpi<-TwoNpi%>% filter(time>=201940&time<=202039)
# Move<-Move%>% filter(time>=201940&time<=202039)
# Mask<-Mask%>% filter(time>=201940&time<=202039)
# NoNpi<-NoNpi%>% filter(time>=201940&time<=202039)

# plot 19-20 season
usa19TwoNpi<-TwoNpi%>% filter(time>=201940&time<=202039)%>%
  mutate(scenario = "Observed intervention", lower = positive_rate, upper = positive_rate, mean = positive_rate)
usa19Move<-Move%>% filter(time>=201940&time<=202039)%>%
  mutate(mean = replace(mean, time <= 202011, NA))%>%
  mutate(scenario = "Mobility change alone")
usa19Mask<-Mask%>% filter(time>=201940&time<=202039) %>%
  mutate(mean = replace(mean, time <= 202023, NA))%>%
  mutate(lower = replace(lower, time <= 202023, NA))%>%
  mutate(upper = replace(upper, time <= 202023, NA))%>%
  mutate(scenario = "Mask-wearing alone")
usa19NoNpi<-NoNpi%>% filter(time>=201940&time<=202039)%>%
  mutate(scenario = "No intervention")
usa19timeidx<-usa19Move$time
usa19xseq<-seq(1,length(usa19timeidx))
#xlabelpos<-makelabel(c(seq(1, length(usa19timeidx), by = 10),length(usa19timeidx))
xlabelpos<-makelabel(length(usa19timeidx))
xlabel<-usa19timeidx[xlabelpos]%%100

plotf_mask_usa19 <-ggplot()+
  # geom_ribbon(aes(x = usa19xseq, ymax = upper * scale,ymin = lower*scale), fill = "#fcedd9", color = NA, 
  #             alpha = 0.8, data = Move)+
  geom_ribbon(aes(x = usa19xseq, ymax = upper * scale,ymin = lower*scale), fill = "#dceef2", color = NA, 
              alpha = 0.8, data = usa19NoNpi)+
  geom_ribbon(aes(x = usa19xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FFC0CB", color = NA, 
              alpha = 0.8, data = usa19Mask)+
  # geom_line(aes(x = usa19xseq, y = mean * scale, color = "Mobility change alone"), size = 1.5,data=Move) +
  geom_line(aes(x = usa19xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=usa19NoNpi) +
  geom_line(aes(x = usa19xseq, y = positive_rate * scale, color = "Observed intervention"), size = 1.5,data=usa19TwoNpi) +
  geom_line(aes(x = usa19xseq, y = mean * scale, color = "Mask-wearing alone"), size = 1.5, data=usa19Mask) +
  scale_color_manual(values = c(
    "Observed intervention" = "#3CB371",#"#8A2BE2",
    "Mobility change alone" = "#eca146",
    "Mask-wearing alone" = "#FF4500", #"#8A2BE2",#"#FC4E07",
    "No intervention" = "#00B2EE"
  ),
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "2019 - 2020 season, Washington", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  
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
plotf_mask_usa19
# grid.locator(unit="native")
# grid.brackets(0, 1, 100, 1, lwd=1, ticks=NA, type = 4)





#plot 20-21 season
TwoNpi<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/wa.xlsx", sheetName = "bothtwonpis")
Move<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/wa.xlsx", sheetName = "movementrestriction")
Mask<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/wa.xlsx", sheetName = "maskwearingorder")
NoNpi<-read.xlsx("Source Data/plot_mask_sep year_v4_usastate/wa.xlsx", sheetName = "neithertwonpis")
usa20TwoNpi<-TwoNpi%>% filter(time>=202040&time<=202139)%>%
  mutate(positive_rate = replace(positive_rate, time > 202128, NA))%>%
  mutate(scenario = "Observed intervention", lower = positive_rate, upper = positive_rate, mean = positive_rate)
usa20Move<-Move%>% filter(time>=202040&time<=202139)%>%
  #mutate(mean = replace(mean, time <= 202003, NA))%>%
  mutate(scenario = "Mobility change alone")
usa20Mask<-Mask%>% filter(time>=202040&time<=202139) %>%
  #mutate(mean = replace(mean, time <= 202003, NA))%>%
  mutate(scenario = "Mask-wearing alone")
usa20NoNpi<-NoNpi%>% filter(time>=202040&time<=202139)%>%
  mutate(scenario = "No intervention")
usa20timeidx<-usa20Move$time
usa20xseq<-seq(1,length(usa20timeidx))
#xlabelpos<-makelabel(c(seq(1, length(usa20timeidx), by = 10),length(usa20timeidx))
xlabelpos<-makelabel(length(usa20timeidx))
xlabel<-usa20timeidx[xlabelpos]%%100

plotf_mask_usa20 <-ggplot()+
  # geom_ribbon(aes(x = usa20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#fcedd9", color = NA, 
  #             alpha = 0.8, data = Move)+
  geom_ribbon(aes(x = usa20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#dceef2", color = NA, 
              alpha = 0.8, data = usa20NoNpi)+
  geom_ribbon(aes(x = usa20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#FFC0CB", color = NA, 
              alpha = 0.8, data = usa20Mask)+
  # geom_line(aes(x = usa20xseq, y = mean * scale, color = "Mobility change alone"), size = 1.5,data=Move) +
  geom_line(aes(x = usa20xseq, y = mean * scale, color = "No intervention"), size = 1.5,data=usa20NoNpi) +
  geom_line(aes(x = usa20xseq, y = positive_rate * scale, color = "Observed intervention"), size = 1.5,data=usa20TwoNpi) +
  geom_line(aes(x = usa20xseq, y = mean * scale, color = "Mask-wearing alone"), size = 1.5, data=usa20Mask) +
  scale_color_manual(values = c(
    "Observed intervention" = "#3CB371",#"#8A2BE2",
    "Mobility change alone" = "#eca146",
    "Mask-wearing alone" = "#FF4500", #"#8A2BE2",#"#FC4E07",
    "No intervention" = "#00B2EE"
  ),
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "2020 - 2021 season, Washington", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  
  labs(x="Week", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 53, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.7, 0.8),
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
plotf_mask_usa20




# combine above 8 plots into one figure
prow <- plot_grid(plotf_mask_cs19 + labs(x = ""),
                  NULL,
                  plotf_mask_uk19 + theme(legend.position = "none") + labs(x = "", y = ""),
                  NULL,
                  plotf_mask_cn19 + theme(legend.position = "none") + labs(x = "", y = ""),
                  NULL,
                  plotf_mask_usa19 + theme(legend.position = "none") + labs(x = "", y = ""),
                  NULL,
                  plotf_mask_cs20 + theme(legend.position = "none"),
                  NULL,
                  plotf_mask_uk20 + theme(legend.position = "none") + labs(y = ""),
                  NULL,
                  plotf_mask_cn20 + theme(legend.position = "none") + labs(y = ""), 
                  NULL,
                  plotf_mask_usa20 + theme(legend.position = "none") + labs(y = ""), 
                  rel_widths = c(1, -0.05, 1, -0.05, 1, -0.05, 1,-0.05, 1, -0.05, 1,-0.05, 1, -0.05, 1), 
                  label_x = c(0.1, 0, 0.1, 0, 0.1, 0, 0.1, 0, 0.1, 0, 0.1,0, 0.1, 0, 0.1), 
                  nrow = 2, labels = c("a", "", "b", "", "c", "", "d", "", "e", "", "f","","g","","h"))
prow

#legend <- get_legend(plotf_mask_cn19)

finalplot <- plot_grid( NULL,NULL,prow,NULL, nrow = 2, 
                       rel_heights = c(0.02,1),rel_widths = c(1,0.02))
finalplot


outfile <- glue("Source plot/output/mask_2019_2021_usastate.tif")
tiff(outfile, width = 20, height = 12, unit = "in", res = 300, compression = "lzw")
print(finalplot)
dev.off()

