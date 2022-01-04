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

# northern china
# season 19-20
# load data
NoCovid19<-read.xlsx("Source Data/plot_covid19_sep year_v4/cn.xlsx",  sheetName = "nocovid19")
Covid19<-read.xlsx("Source Data/plot_covid19_sep year_v4/cn.xlsx",  sheetName = "covid19")

cn19NoCovid19<-NoCovid19%>% filter(time>=201940&time<=202039)%>%
  mutate(mean = replace(mean, time <= 201951, NA))%>%
  mutate(scenario = "No SARS-CoV-2")
  
cn19Covid19<-Covid19%>% filter(time>=201940&time<=202039)%>%
  mutate(scenario = "SARS-CoV-2")

## TODO: Yan, pls use the coding below to fix the order of the lengend ##
# plot_data <- NULL
# plot_data <- plot_data %>%
#   rbind(NoCovid19,Move,Mask,Covid19) %>%
#   select(time, mean, lower, upper, scenario)
# plot_data$scenario <- factor(plot_data$scenario, levels=c("SARS-CoV-2", "Mobility change alone", "Mask-wearing alone","No SARS-CoV-2"))




scale = 100
ylimits = 50

cn19timeidx<-cn19Covid19$time
cn19xseq<-seq(1,length(cn19timeidx))
#xlabelpos<-c(seq(1, length(timeidx), by = 10),length(timeidx))
xlabelpos<-makelabel(length(cn19timeidx))
xlabel<-cn19timeidx[xlabelpos]%%100

plotf_covid19cn19 <-ggplot()+
  geom_ribbon(aes(x = cn19xseq, ymax = upper * scale,ymin = lower*scale), fill = "#dceef2", color = NA, 
              alpha = 0.8, data = cn19Covid19)+
  geom_ribbon(aes(x = cn19xseq, ymax = upper * scale,ymin = lower*scale), fill = "#EFC2F1", color = NA, 
              alpha = 0.4, data = cn19NoCovid19)+ ##68cfa3
  geom_line(aes(x = cn19xseq, y = mean * scale, color = "SARS-CoV-2"), size = 1.5,data=cn19Covid19) +
  geom_line(aes(x = cn19xseq, y = mean * scale, color = "No SARS-CoV-2"), size = 1.5,data=cn19NoCovid19) +
  scale_color_manual(values = c(
    "No SARS-CoV-2" = "#9370DB", ##"#3CB371",#"#8A2BE2",
    "Mobility change alone" = "#eca146",
    "Mask-wearing alone" = "#FF4500", #"#8A2BE2",#"#FC4E07",
    "SARS-CoV-2" = "#00B2EE"
  ),
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "2019 - 2020 season, Northern China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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
plotf_covid19cn19

# season 20-21
# load data
NoCovid19<-read.xlsx("Source Data/plot_covid19_sep year_v4/cn.xlsx",  sheetName = "nocovid19")
Covid19<-read.xlsx("Source Data/plot_covid19_sep year_v4/cn.xlsx",  sheetName = "covid19")

cn20NoCovid19<-NoCovid19%>% filter(time>=202040&time<=202139)%>%
  mutate(scenario = "No SARS-CoV-2")

cn20Covid19<-Covid19%>% filter(time>=202040&time<=202139)%>%
  mutate(scenario = "SARS-CoV-2")

## TODO: Yan, pls use the coding below to fix the order of the lengend ##
# plot_data <- NULL
# plot_data <- plot_data %>%
#   rbind(NoCovid19,Move,Mask,Covid19) %>%
#   select(time, mean, lower, upper, scenario)
# plot_data$scenario <- factor(plot_data$scenario, levels=c("SARS-CoV-2", "Mobility change alone", "Mask-wearing alone","No SARS-CoV-2"))




scale = 100
ylimits = 50

cn20timeidx<-cn20Covid19$time
cn20xseq<-seq(1,length(cn20timeidx))
#xlabelpos<-c(seq(1, length(timeidx), by = 10),length(timeidx))
xlabelpos<-makelabel(length(cn20timeidx))
xlabel<-cn20timeidx[xlabelpos]%%100

plotf_covid19cn20 <-ggplot()+
  geom_ribbon(aes(x = cn20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#dceef2", color = NA, 
              alpha = 0.8, data = cn20Covid19)+
  geom_ribbon(aes(x = cn20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#EFC2F1", color = NA, 
              alpha = 0.4, data = cn20NoCovid19)+ ##68cfa3
  geom_line(aes(x = cn20xseq, y = mean * scale, color = "SARS-CoV-2"), size = 1.5,data=cn20Covid19) +
  geom_line(aes(x = cn20xseq, y = mean * scale, color = "No SARS-CoV-2"), size = 1.5,data=cn20NoCovid19) +
  scale_color_manual(values = c(
    "No SARS-CoV-2" = "#9370DB", ##"#3CB371",#"#8A2BE2",
    "Mobility change alone" = "#eca146",
    "Mask-wearing alone" = "#FF4500", #"#8A2BE2",#"#FC4E07",
    "SARS-CoV-2" = "#00B2EE"
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
    legend.position = c(0.87, 0.95),
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
plotf_covid19cn20

# southern china
# season 19-20
# load data
NoCovid19<-read.xlsx("Source Data/plot_covid19_sep year_v4/cs.xlsx",  sheetName = "nocovid19")
Covid19<-read.xlsx("Source Data/plot_covid19_sep year_v4/cs.xlsx",  sheetName = "covid19")

cs19NoCovid19<-NoCovid19%>% filter(time>=201940&time<=202039)%>%
  mutate(mean = replace(mean, time <= 201951, NA))%>%
  mutate(scenario = "No SARS-CoV-2")

cs19Covid19<-Covid19%>% filter(time>=201940&time<=202039)%>%
  mutate(scenario = "SARS-CoV-2")

## TODO: Yan, pls use the coding below to fix the order of the lengend ##
# plot_data <- NULL
# plot_data <- plot_data %>%
#   rbind(NoCovid19,Move,Mask,Covid19) %>%
#   select(time, mean, lower, upper, scenario)
# plot_data$scenario <- factor(plot_data$scenario, levels=c("SARS-CoV-2", "Mobility change alone", "Mask-wearing alone","No SARS-CoV-2"))




scale = 100
ylimits = 50

cs19timeidx<-cs19Covid19$time
cs19xseq<-seq(1,length(cs19timeidx))
#xlabelpos<-c(seq(1, length(timeidx), by = 10),length(timeidx))
xlabelpos<-makelabel(length(cs19timeidx))
xlabel<-cs19timeidx[xlabelpos]%%100

plotf_covid19cs19 <-ggplot()+
  geom_ribbon(aes(x = cs19xseq, ymax = upper * scale,ymin = lower*scale), fill = "#dceef2", color = NA, 
              alpha = 0.8, data = cs19Covid19)+
  geom_ribbon(aes(x = cs19xseq, ymax = upper * scale,ymin = lower*scale), fill = "#EFC2F1", color = NA, 
              alpha = 0.4, data = cs19NoCovid19)+ ##68cfa3
  geom_line(aes(x = cs19xseq, y = mean * scale, color = "SARS-CoV-2"), size = 1.5,data=cs19Covid19) +
  geom_line(aes(x = cs19xseq, y = mean * scale, color = "No SARS-CoV-2"), size = 1.5,data=cs19NoCovid19) +
  scale_color_manual(values = c(
    "No SARS-CoV-2" = "#9370DB", ##"#3CB371",#"#8A2BE2",
    "Mobility change alone" = "#eca146",
    "Mask-wearing alone" = "#FF4500", #"#8A2BE2",#"#FC4E07",
    "SARS-CoV-2" = "#00B2EE"
  ),
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "2019 - 2020 season, Southern China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  labs(x="Week", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 52, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.87, 0.95),
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
plotf_covid19cs19

# season 20-21
# load data
NoCovid19<-read.xlsx("Source Data/plot_covid19_sep year_v4/cs.xlsx",  sheetName = "nocovid19")
Covid19<-read.xlsx("Source Data/plot_covid19_sep year_v4/cs.xlsx",  sheetName = "covid19")

cs20NoCovid19<-NoCovid19%>% filter(time>=202040&time<=202139)%>%
  mutate(scenario = "No SARS-CoV-2")

cs20Covid19<-Covid19%>% filter(time>=202040&time<=202139)%>%
  mutate(scenario = "SARS-CoV-2")

## TODO: Yan, pls use the coding below to fix the order of the lengend ##
# plot_data <- NULL
# plot_data <- plot_data %>%
#   rbind(NoCovid19,Move,Mask,Covid19) %>%
#   select(time, mean, lower, upper, scenario)
# plot_data$scenario <- factor(plot_data$scenario, levels=c("SARS-CoV-2", "Mobility change alone", "Mask-wearing alone","No SARS-CoV-2"))




scale = 100
ylimits = 50

cs20timeidx<-cs20Covid19$time
cs20xseq<-seq(1,length(cs20timeidx))
#xlabelpos<-c(seq(1, length(timeidx), by = 10),length(timeidx))
xlabelpos<-makelabel(length(cs20timeidx))
xlabel<-cs20timeidx[xlabelpos]%%100

plotf_covid19cs20 <-ggplot()+
  geom_ribbon(aes(x = cs20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#dceef2", color = NA, 
              alpha = 0.8, data = cs20Covid19)+
  geom_ribbon(aes(x = cs20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#EFC2F1", color = NA, 
              alpha = 0.4, data = cs20NoCovid19)+ ##68cfa3
  geom_line(aes(x = cs20xseq, y = mean * scale, color = "SARS-CoV-2"), size = 1.5,data=cs20Covid19) +
  geom_line(aes(x = cs20xseq, y = mean * scale, color = "No SARS-CoV-2"), size = 1.5,data=cs20NoCovid19) +
  scale_color_manual(values = c(
    "No SARS-CoV-2" = "#9370DB", ##"#3CB371",#"#8A2BE2",
    "Mobility change alone" = "#eca146",
    "Mask-wearing alone" = "#FF4500", #"#8A2BE2",#"#FC4E07",
    "SARS-CoV-2" = "#00B2EE"
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
plotf_covid19cs20



# UK
# season 19-20
# load data
NoCovid19<-read.xlsx("Source Data/plot_covid19_sep year_v4/uk.xlsx",  sheetName = "nocovid19")
Covid19<-read.xlsx("Source Data/plot_covid19_sep year_v4/uk.xlsx",  sheetName = "covid19")

uk19NoCovid19<-NoCovid19%>% filter(time>=201940&time<=202039)%>%
  mutate(mean = replace(mean, time <= 201951, NA))%>%
  mutate(scenario = "No SARS-CoV-2")

uk19Covid19<-Covid19%>% filter(time>=201940&time<=202039)%>%
  mutate(scenario = "SARS-CoV-2")

## TODO: Yan, pls use the coding below to fix the order of the lengend ##
# plot_data <- NULL
# plot_data <- plot_data %>%
#   rbind(NoCovid19,Move,Mask,Covid19) %>%
#   select(time, mean, lower, upper, scenario)
# plot_data$scenario <- factor(plot_data$scenario, levels=c("SARS-CoV-2", "Mobility change alone", "Mask-wearing alone","No SARS-CoV-2"))




scale = 100
ylimits = 50

uk19timeidx<-uk19Covid19$time
uk19xseq<-seq(1,length(uk19timeidx))
#xlabelpos<-c(seq(1, length(timeidx), by = 10),length(timeidx))
xlabelpos<-makelabel(length(uk19timeidx))
xlabel<-uk19timeidx[xlabelpos]%%100

plotf_covid19uk19 <-ggplot()+
  geom_ribbon(aes(x = uk19xseq, ymax = upper * scale,ymin = lower*scale), fill = "#dceef2", color = NA, 
              alpha = 0.8, data = uk19Covid19)+
  geom_ribbon(aes(x = uk19xseq, ymax = upper * scale,ymin = lower*scale), fill = "#EFC2F1", color = NA, 
              alpha = 0.4, data = uk19NoCovid19)+ ##68cfa3
  geom_line(aes(x = uk19xseq, y = mean * scale, color = "SARS-CoV-2"), size = 1.5,data=uk19Covid19) +
  geom_line(aes(x = uk19xseq, y = mean * scale, color = "No SARS-CoV-2"), size = 1.5,data=uk19NoCovid19) +
  scale_color_manual(values = c(
    "No SARS-CoV-2" = "#9370DB", ##"#3CB371",#"#8A2BE2",
    "Mobility change alone" = "#eca146",
    "Mask-wearing alone" = "#FF4500", #"#8A2BE2",#"#FC4E07",
    "SARS-CoV-2" = "#00B2EE"
  ),
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "2019 - 2020 season, England", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  labs(x="Week", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 52, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.87, 0.95),
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
plotf_covid19uk19

# season 20-21
# load data
NoCovid19<-read.xlsx("Source Data/plot_covid19_sep year_v4/uk.xlsx",  sheetName = "nocovid19")
Covid19<-read.xlsx("Source Data/plot_covid19_sep year_v4/uk.xlsx",  sheetName = "covid19")

uk20NoCovid19<-NoCovid19%>% filter(time>=202040&time<=202139)%>%
  mutate(scenario = "No SARS-CoV-2")

uk20Covid19<-Covid19%>% filter(time>=202040&time<=202139)%>%
  mutate(scenario = "SARS-CoV-2")

## TODO: Yan, pls use the coding below to fix the order of the lengend ##
# plot_data <- NULL
# plot_data <- plot_data %>%
#   rbind(NoCovid19,Move,Mask,Covid19) %>%
#   select(time, mean, lower, upper, scenario)
# plot_data$scenario <- factor(plot_data$scenario, levels=c("SARS-CoV-2", "Mobility change alone", "Mask-wearing alone","No SARS-CoV-2"))




scale = 100
ylimits = 50

uk20timeidx<-uk20Covid19$time
uk20xseq<-seq(1,length(uk20timeidx))
#xlabelpos<-c(seq(1, length(timeidx), by = 10),length(timeidx))
xlabelpos<-makelabel(length(uk20timeidx))
xlabel<-uk20timeidx[xlabelpos]%%100

plotf_covid19uk20 <-ggplot()+
  geom_ribbon(aes(x = uk20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#dceef2", color = NA, 
              alpha = 0.8, data = uk20Covid19)+
  geom_ribbon(aes(x = uk20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#EFC2F1", color = NA, 
              alpha = 0.4, data = uk20NoCovid19)+ ##68cfa3
  geom_line(aes(x = uk20xseq, y = mean * scale, color = "SARS-CoV-2"), size = 1.5,data=uk20Covid19) +
  geom_line(aes(x = uk20xseq, y = mean * scale, color = "No SARS-CoV-2"), size = 1.5,data=uk20NoCovid19) +
  scale_color_manual(values = c(
    "No SARS-CoV-2" = "#9370DB", ##"#3CB371",#"#8A2BE2",
    "Mobility change alone" = "#eca146",
    "Mask-wearing alone" = "#FF4500", #"#8A2BE2",#"#FC4E07",
    "SARS-CoV-2" = "#00B2EE"
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
plotf_covid19uk20

# USA
# season 19-20
# load data
NoCovid19<-read.xlsx("Source Data/plot_covid19_sep year_v4/usa.xlsx",  sheetName = "nocovid19")
Covid19<-read.xlsx("Source Data/plot_covid19_sep year_v4/usa.xlsx",  sheetName = "covid19")

usa19NoCovid19<-NoCovid19%>% filter(time>=201940&time<=202039)%>%
  mutate(mean = replace(mean, time <= 201951, NA))%>%
  mutate(scenario = "No SARS-CoV-2")

usa19Covid19<-Covid19%>% filter(time>=201940&time<=202039)%>%
  mutate(scenario = "SARS-CoV-2")

## TODO: Yan, pls use the coding below to fix the order of the lengend ##
# plot_data <- NULL
# plot_data <- plot_data %>%
#   rbind(NoCovid19,Move,Mask,Covid19) %>%
#   select(time, mean, lower, upper, scenario)
# plot_data$scenario <- factor(plot_data$scenario, levels=c("SARS-CoV-2", "Mobility change alone", "Mask-wearing alone","No SARS-CoV-2"))




scale = 100
ylimits = 50

usa19timeidx<-usa19Covid19$time
usa19xseq<-seq(1,length(usa19timeidx))
#xlabelpos<-c(seq(1, length(timeidx), by = 10),length(timeidx))
xlabelpos<-makelabel(length(usa19timeidx))
xlabel<-usa19timeidx[xlabelpos]%%100

plotf_covid19usa19 <-ggplot()+
  geom_ribbon(aes(x = usa19xseq, ymax = upper * scale,ymin = lower*scale), fill = "#dceef2", color = NA, 
              alpha = 0.8, data = usa19Covid19)+
  geom_ribbon(aes(x = usa19xseq, ymax = upper * scale,ymin = lower*scale), fill = "#EFC2F1", color = NA, 
              alpha = 0.4, data = usa19NoCovid19)+ ##68cfa3
  geom_line(aes(x = usa19xseq, y = mean * scale, color = "SARS-CoV-2"), size = 1.5,data=usa19Covid19) +
  geom_line(aes(x = usa19xseq, y = mean * scale, color = "No SARS-CoV-2"), size = 1.5,data=usa19NoCovid19) +
  scale_color_manual(values = c(
    "No SARS-CoV-2" = "#9370DB", ##"#3CB371",#"#8A2BE2",
    "Mobility change alone" = "#eca146",
    "Mask-wearing alone" = "#FF4500", #"#8A2BE2",#"#FC4E07",
    "SARS-CoV-2" = "#00B2EE"
  ),
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "2019 - 2020 season, the U.S.", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
  labs(x="Week", y = "Percent Positive (%)") +
  scale_x_continuous(breaks=xlabelpos, label=xlabel)+
  scale_y_continuous(limits = c(0, ylimits), breaks = seq(0, ylimits, by = 0.1* scale)) +
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 1, xend = 52, y = -Inf, yend = -Inf), color = "darkgray") +
  geom_segment(aes(y = 0, yend = ylimits, x = -Inf, xend = -Inf), color = "darkgray") +
  theme(
    legend.position = c(0.87, 0.95),
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
plotf_covid19usa19

# season 20-21
# load data
NoCovid19<-read.xlsx("Source Data/plot_covid19_sep year_v4/usa.xlsx",  sheetName = "nocovid19")
Covid19<-read.xlsx("Source Data/plot_covid19_sep year_v4/usa.xlsx",  sheetName = "covid19")

usa20NoCovid19<-NoCovid19%>% filter(time>=202040&time<=202139)%>%
  mutate(scenario = "No SARS-CoV-2")

usa20Covid19<-Covid19%>% filter(time>=202040&time<=202139)%>%
  mutate(scenario = "SARS-CoV-2")

## TODO: Yan, pls use the coding below to fix the order of the lengend ##
# plot_data <- NULL
# plot_data <- plot_data %>%
#   rbind(NoCovid19,Move,Mask,Covid19) %>%
#   select(time, mean, lower, upper, scenario)
# plot_data$scenario <- factor(plot_data$scenario, levels=c("SARS-CoV-2", "Mobility change alone", "Mask-wearing alone","No SARS-CoV-2"))




scale = 100
ylimits = 50

usa20timeidx<-usa20Covid19$time
usa20xseq<-seq(1,length(usa20timeidx))
#xlabelpos<-c(seq(1, length(timeidx), by = 10),length(timeidx))
xlabelpos<-makelabel(length(usa20timeidx))
xlabel<-usa20timeidx[xlabelpos]%%100

plotf_covid19usa20 <-ggplot()+
  geom_ribbon(aes(x = usa20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#dceef2", color = NA, 
              alpha = 0.8, data = usa20Covid19)+
  geom_ribbon(aes(x = usa20xseq, ymax = upper * scale,ymin = lower*scale), fill = "#EFC2F1", color = NA, 
              alpha = 0.4, data = usa20NoCovid19)+ ##68cfa3
  geom_line(aes(x = usa20xseq, y = mean * scale, color = "SARS-CoV-2"), size = 1.5,data=usa20Covid19) +
  geom_line(aes(x = usa20xseq, y = mean * scale, color = "No SARS-CoV-2"), size = 1.5,data=usa20NoCovid19) +
  scale_color_manual(values = c(
    "No SARS-CoV-2" = "#9370DB", ##"#3CB371",#"#8A2BE2",
    "Mobility change alone" = "#eca146",
    "Mask-wearing alone" = "#FF4500", #"#8A2BE2",#"#FC4E07",
    "SARS-CoV-2" = "#00B2EE"
  ),
  name = "Treatment") +
  scale_shape_manual(values = c(0, 1, 2, 4), 
                     name = "Treatment")+
  annotate("text", label = "2020 - 2021 season, the U.S.", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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
plotf_covid19usa20




# combine above 8 plots into one figure
prow <- plot_grid(plotf_covid19cn19 + labs(x = ""),
                  NULL,
                  plotf_covid19cs19 + theme(legend.position = "none") + labs(x = "", y = ""),
                  NULL,
                  plotf_covid19uk19 + theme(legend.position = "none") + labs(x = "", y = ""),
                  NULL,
                  plotf_covid19usa19 + theme(legend.position = "none") + labs(x = "", y = ""),
                  NULL,
                  plotf_covid19cn20 + theme(legend.position = "none"),
                  NULL,
                  plotf_covid19cs20 + theme(legend.position = "none") + labs(y = ""),
                  NULL,
                  plotf_covid19uk20 + theme(legend.position = "none") + labs(y = ""), 
                  NULL,
                  plotf_covid19usa20 + theme(legend.position = "none") + labs(y = ""), 
                  rel_widths = c(1, -0.05, 1, -0.05, 1, -0.05, 1,-0.05, 1, -0.05, 1,-0.05, 1, -0.05, 1), 
                  label_x = c(0.1, 0, 0.1, 0, 0.1, 0, 0.1, 0, 0.1, 0, 0.1,0, 0.1, 0, 0.1), 
                  nrow = 2, labels = c("a", "", "b", "", "c", "", "d", "", "e", "", "f","","g","","h"))
prow

#legend <- get_legend(plotf_mask_cn19)

finalplot <- plot_grid( NULL,NULL,prow,NULL, nrow = 2, 
                        rel_heights = c(0.02,1),rel_widths = c(1,0.02))
finalplot


outfile <- glue("output/virus_2019_2021.tif")
tiff(outfile, width = 20, height = 12, unit = "in", res = 300, compression = "lzw")
print(finalplot)
dev.off()

