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
makelabel <- function(len) {
  xseq<-seq(1,len,by=10)
  xseq[length(xseq)]<-len
  return(xseq)
}

# northern china
# season 19-20
# load data
NoCovid19<-read.xlsx("Source Data/plot_covid19_hubei/hb.xlsx",  sheetName = "nocovid19")
Covid19<-read.xlsx("Source Data/plot_covid19_hubei/hb.xlsx",  sheetName = "covid19")

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
  annotate("text", label = "2019 - 2020 season, Hubei, China", x = 25, y =  0.49 * scale, color = "#8B658B",fontface = 'bold')+
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




outfile <- glue("Source plot/output/virus_2019_2020_hubei.tif")
tiff(outfile, width = 7, height = 6, unit = "in", res = 300, compression = "lzw")
print(plotf_covid19cn19)
dev.off()

