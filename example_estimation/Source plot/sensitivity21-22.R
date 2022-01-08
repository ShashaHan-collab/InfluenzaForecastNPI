rm(list = ls())
setwd("~/InfluenzaForecastNPI-main/example_estimation/")
library(tidyverse)
library(glue)
library(xlsx)
library(cowplot)
library(scales)

# setwd("~/DynamicVaccineAllocationMod-main")
# dout <- "Source code/output"
dout<-""


# load data
opt_infec.gr.vc.range1cn <- read.xlsx("Source Data/sensitivity21-22/sensitivity2122.xlsx", 
                                   sheetName = "cnm")

opt_infec.gr.vc.range1cn <- opt_infec.gr.vc.range1cn %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



mask_cn <- ggplot(data = opt_infec.gr.vc.range1cn) + 
  geom_bar(aes(var, vc1.max * 100+10), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 * 100+10), position = "identity", stat = "identity", fill = "#21468b") + 
  geom_bar(aes(var, vc1.min * 100+10), position = "identity", stat = "identity", fill = "white") + 
  geom_hline(yintercept = opt_infec.gr.vc.range1cn$vc1[1] * 100+10, color = "darkgray") + 
  labs(x = "", y = "Reduction in Percent Positivity", 
       title = "Mask-wearing alone") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator"
                              )) + 
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, by = 10), 
                     labels = seq(-10, 40, by = 10), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf, y = 0, yend = 50, color = "darkgray") + 
  coord_flip() + 
  theme(
    legend.position = c(0.95, 0.8),
    legend.title = element_blank(),
    legend.text = element_text(size = 11, color = "black"),
    plot.title = element_text(hjust = 0.5),
    axis.text = element_text(size = 13, color = "black"),
    axis.ticks = element_line(color = "darkgray"), 
    axis.title = element_text(size = 13, color = "black")
  )
mask_cn


opt_infec.gr.vc.range2cn <- read.xlsx("Source Data/sensitivity21-22/sensitivity2122.xlsx", 
                                   sheetName = "cni")

opt_infec.gr.vc.range2cn <- opt_infec.gr.vc.range2cn %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



inbound_cn <- ggplot(data = opt_infec.gr.vc.range2cn) + 
  geom_bar(aes(var, vc1.max * 100+10), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 * 100+10), position = "identity", stat = "identity", fill = "#21468b") +
  geom_bar(aes(var, vc1.min * 100+10), position = "identity", stat = "identity", fill = "white") +
  geom_hline(yintercept = opt_infec.gr.vc.range2cn$vc1[1] * 100+10, color = "darkgray") + 
  labs(x = "", y = "Reduction in Percent Positivity", 
       title = "International mobility alone") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator")) + 
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, by = 10), 
                     labels = seq(-10, 40, by = 10), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf,  y = 0, yend = 50, color = "darkgray") + 
  coord_flip() + 
  theme(
    legend.position = c(0.95, 0.8),
    legend.title = element_blank(),
    legend.text = element_text(size = 11, color = "black"),
    plot.title = element_text(hjust = 0.5),
    axis.text = element_text(size = 13, color = "black"),
    axis.ticks = element_line(color = "darkgray"), 
    axis.title = element_text(size = 13, color = "black")
  )
inbound_cn


opt_infec.gr.vc.range3cn <- read.xlsx("Source Data/sensitivity21-22/sensitivity2122.xlsx", 
                                   sheetName = "cnd")

opt_infec.gr.vc.range3cn <- opt_infec.gr.vc.range3cn %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



domestic_cn <- ggplot(data = opt_infec.gr.vc.range3cn) + 
  geom_bar(aes(var, vc1.max * 100+10), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 * 100+10), position = "identity", stat = "identity", fill = "#21468b") + 
  geom_bar(aes(var, vc1.min * 100+10), position = "identity", stat = "identity", fill = "white") + 
  geom_hline(yintercept = opt_infec.gr.vc.range3cn$vc1[1] * 100+10, color = "darkgray") + 
  labs(x = "", y = "Reduction in Percent Positivity", 
       title = "Domestic mobility alone") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator")) + 
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, by = 10), 
                     labels = seq(-10, 40, by = 10), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf,  y = 0, yend = 50, color = "darkgray") + 
  coord_flip() + 
  theme(
    legend.position = c(0.95, 0.8),
    legend.title = element_blank(),
    legend.text = element_text(size = 11, color = "black"),
    plot.title = element_text(hjust = 0.5),
    axis.text = element_text(size = 13, color = "black"),
    axis.ticks = element_line(color = "darkgray"), 
    axis.title = element_text(size = 13, color = "black")
  )
domestic_cn



# load data
opt_infec.gr.vc.range1cs <- read.xlsx("Source Data/sensitivity21-22/sensitivity2122.xlsx", 
                                      sheetName = "csm")

opt_infec.gr.vc.range1cs <- opt_infec.gr.vc.range1cs %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



mask_cs <- ggplot(data = opt_infec.gr.vc.range1cs) + 
  geom_bar(aes(var, vc1.max * 100+10), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 * 100+10), position = "identity", stat = "identity", fill = "#21468b") + 
  geom_bar(aes(var, vc1.min * 100+10), position = "identity", stat = "identity", fill = "white") + 
  geom_hline(yintercept = opt_infec.gr.vc.range1cs$vc1[1] * 100+10, color = "darkgray") + 
  labs(x = "", y = "Reduction in Percent Positivity", 
       title = "Mask-wearing alone") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator"
  )) + 
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, by = 10), 
                     labels = seq(-10, 40, by = 10), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf, y = 0, yend = 50, color = "darkgray") + 
  coord_flip() + 
  theme(
    legend.position = c(0.95, 0.8),
    legend.title = element_blank(),
    legend.text = element_text(size = 11, color = "black"),
    plot.title = element_text(hjust = 0.5),
    axis.text = element_text(size = 13, color = "black"),
    axis.ticks = element_line(color = "darkgray"), 
    axis.title = element_text(size = 13, color = "black")
  )
mask_cs


opt_infec.gr.vc.range2cs <- read.xlsx("Source Data/sensitivity21-22/sensitivity2122.xlsx", 
                                      sheetName = "csi")

opt_infec.gr.vc.range2cs <- opt_infec.gr.vc.range2cs %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



inbound_cs <- ggplot(data = opt_infec.gr.vc.range2cs) + 
  geom_bar(aes(var, vc1.max * 100+10), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 * 100+10), position = "identity", stat = "identity", fill = "#21468b") +
  geom_bar(aes(var, vc1.min * 100+10), position = "identity", stat = "identity", fill = "white") +
  geom_hline(yintercept = opt_infec.gr.vc.range2cs$vc1[1] * 100+10, color = "darkgray") + 
  labs(x = "", y = "Reduction in Percent Positivity", 
       title = "International mobility alone") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator")) + 
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, by = 10), 
                     labels = seq(-10, 40, by = 10), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf,  y = 0, yend = 50, color = "darkgray") + 
  coord_flip() + 
  theme(
    legend.position = c(0.95, 0.8),
    legend.title = element_blank(),
    legend.text = element_text(size = 11, color = "black"),
    plot.title = element_text(hjust = 0.5),
    axis.text = element_text(size = 13, color = "black"),
    axis.ticks = element_line(color = "darkgray"), 
    axis.title = element_text(size = 13, color = "black")
  )
inbound_cs


opt_infec.gr.vc.range3cs <- read.xlsx("Source Data/sensitivity21-22/sensitivity2122.xlsx", 
                                      sheetName = "csd")

opt_infec.gr.vc.range3cs <- opt_infec.gr.vc.range3cs %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



domestic_cs <- ggplot(data = opt_infec.gr.vc.range3cs) + 
  geom_bar(aes(var, vc1.max * 100+10), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 * 100+10), position = "identity", stat = "identity", fill = "#21468b") + 
  geom_bar(aes(var, vc1.min * 100+10), position = "identity", stat = "identity", fill = "white") + 
  geom_hline(yintercept = opt_infec.gr.vc.range3cs$vc1[1] * 100+10, color = "darkgray") + 
  labs(x = "", y = "Reduction in Percent Positivity", 
       title = "Domestic mobility alone") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator")) + 
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, by = 10), 
                     labels = seq(-10, 40, by = 10), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf,  y = 0, yend = 50, color = "darkgray") + 
  coord_flip() + 
  theme(
    legend.position = c(0.95, 0.8),
    legend.title = element_blank(),
    legend.text = element_text(size = 11, color = "black"),
    plot.title = element_text(hjust = 0.5),
    axis.text = element_text(size = 13, color = "black"),
    axis.ticks = element_line(color = "darkgray"), 
    axis.title = element_text(size = 13, color = "black")
  )
domestic_cs


# load data
opt_infec.gr.vc.range1uk <- read.xlsx("Source Data/sensitivity21-22/sensitivity2122.xlsx", 
                                      sheetName = "ukm")

opt_infec.gr.vc.range1uk <- opt_infec.gr.vc.range1uk %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



mask_uk <- ggplot(data = opt_infec.gr.vc.range1uk) + 
  geom_bar(aes(var, vc1.max * 100+10), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 * 100+10), position = "identity", stat = "identity", fill = "#21468b") + 
  geom_bar(aes(var, vc1.min * 100+10), position = "identity", stat = "identity", fill = "white") + 
  geom_hline(yintercept = opt_infec.gr.vc.range1uk$vc1[1] * 100+10, color = "darkgray") + 
  labs(x = "", y = "Reduction in Percent Positivity", 
       title = "Mask-wearing alone") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator"
  )) + 
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, by = 10), 
                     labels = seq(-10, 40, by = 10), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf, y = 0, yend = 50, color = "darkgray") + 
  coord_flip() + 
  theme(
    legend.position = c(0.95, 0.8),
    legend.title = element_blank(),
    legend.text = element_text(size = 11, color = "black"),
    plot.title = element_text(hjust = 0.5),
    axis.text = element_text(size = 13, color = "black"),
    axis.ticks = element_line(color = "darkgray"), 
    axis.title = element_text(size = 13, color = "black")
  )
mask_uk


opt_infec.gr.vc.range2uk <- read.xlsx("Source Data/sensitivity21-22/sensitivity2122.xlsx", 
                                      sheetName = "uki")

opt_infec.gr.vc.range2uk <- opt_infec.gr.vc.range2uk %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



inbound_uk <- ggplot(data = opt_infec.gr.vc.range2uk) + 
  geom_bar(aes(var, vc1.max * 100+10), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 * 100+10), position = "identity", stat = "identity", fill = "#21468b") +
  geom_bar(aes(var, vc1.min * 100+10), position = "identity", stat = "identity", fill = "white") +
  geom_hline(yintercept = opt_infec.gr.vc.range2uk$vc1[1] * 100+10, color = "darkgray") + 
  labs(x = "", y = "Reduction in Percent Positivity", 
       title = "International mobility alone") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator")) + 
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, by = 10), 
                     labels = seq(-10, 40, by = 10), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf,  y = 0, yend = 50, color = "darkgray") + 
  coord_flip() + 
  theme(
    legend.position = c(0.95, 0.8),
    legend.title = element_blank(),
    legend.text = element_text(size = 11, color = "black"),
    plot.title = element_text(hjust = 0.5),
    axis.text = element_text(size = 13, color = "black"),
    axis.ticks = element_line(color = "darkgray"), 
    axis.title = element_text(size = 13, color = "black")
  )
inbound_uk


opt_infec.gr.vc.range3uk <- read.xlsx("Source Data/sensitivity21-22/sensitivity2122.xlsx", 
                                      sheetName = "ukd")

opt_infec.gr.vc.range3uk <- opt_infec.gr.vc.range3uk %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



domestic_uk <- ggplot(data = opt_infec.gr.vc.range3uk) + 
  geom_bar(aes(var, vc1.max * 100+10), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 * 100+10), position = "identity", stat = "identity", fill = "#21468b") + 
  geom_bar(aes(var, vc1.min * 100+10), position = "identity", stat = "identity", fill = "white") + 
  geom_hline(yintercept = opt_infec.gr.vc.range3uk$vc1[1] * 100+10, color = "darkgray") + 
  labs(x = "", y = "Reduction in Percent Positivity", 
       title = "Domestic mobility alone") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator")) + 
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, by = 10), 
                     labels = seq(-10, 40, by = 10), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf,  y = 0, yend = 50, color = "darkgray") + 
  coord_flip() + 
  theme(
    legend.position = c(0.95, 0.8),
    legend.title = element_blank(),
    legend.text = element_text(size = 11, color = "black"),
    plot.title = element_text(hjust = 0.5),
    axis.text = element_text(size = 13, color = "black"),
    axis.ticks = element_line(color = "darkgray"), 
    axis.title = element_text(size = 13, color = "black")
  )
domestic_uk



# load data
opt_infec.gr.vc.range1usa <- read.xlsx("Source Data/sensitivity21-22/sensitivity2122.xlsx", 
                                       sheetName = "usam")

opt_infec.gr.vc.range1usa <- opt_infec.gr.vc.range1usa %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



mask_usa <- ggplot(data = opt_infec.gr.vc.range1usa) + 
  geom_bar(aes(var, vc1.max * 100+10), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 * 100+10), position = "identity", stat = "identity", fill = "#21468b") + 
  geom_bar(aes(var, vc1.min * 100+10), position = "identity", stat = "identity", fill = "white") + 
  geom_hline(yintercept = opt_infec.gr.vc.range1usa$vc1[1] * 100+10, color = "darkgray") + 
  labs(x = "", y = "Reduction in Percent Positivity", 
       title = "Mask-wearing alone") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator"
  )) + 
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, by = 10), 
                     labels = seq(-10, 40, by = 10), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf, y = 0, yend = 50, color = "darkgray") + 
  coord_flip() + 
  theme(
    legend.position = c(0.95, 0.8),
    legend.title = element_blank(),
    legend.text = element_text(size = 11, color = "black"),
    plot.title = element_text(hjust = 0.5),
    axis.text = element_text(size = 13, color = "black"),
    axis.ticks = element_line(color = "darkgray"), 
    axis.title = element_text(size = 13, color = "black")
  )
mask_usa


opt_infec.gr.vc.range2usa <- read.xlsx("Source Data/sensitivity21-22/sensitivity2122.xlsx", 
                                       sheetName = "usai")

opt_infec.gr.vc.range2usa <- opt_infec.gr.vc.range2usa %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



inbound_usa <- ggplot(data = opt_infec.gr.vc.range2usa) + 
  geom_bar(aes(var, vc1.max * 100+10), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 * 100+10), position = "identity", stat = "identity", fill = "#21468b") +
  geom_bar(aes(var, vc1.min * 100+10), position = "identity", stat = "identity", fill = "white") +
  geom_hline(yintercept = opt_infec.gr.vc.range2usa$vc1[1] * 100+10, color = "darkgray") + 
  labs(x = "", y = "Reduction in Percent Positivity", 
       title = "International mobility alone") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator")) + 
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, by = 10), 
                     labels = seq(-10, 40, by = 10), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf,  y = 0, yend = 50, color = "darkgray") + 
  coord_flip() + 
  theme(
    legend.position = c(0.95, 0.8),
    legend.title = element_blank(),
    legend.text = element_text(size = 11, color = "black"),
    plot.title = element_text(hjust = 0.5),
    axis.text = element_text(size = 13, color = "black"),
    axis.ticks = element_line(color = "darkgray"), 
    axis.title = element_text(size = 13, color = "black")
  )
inbound_usa


opt_infec.gr.vc.range3usa <- read.xlsx("Source Data/sensitivity21-22/sensitivity2122.xlsx", 
                                       sheetName = "usad")

opt_infec.gr.vc.range3usa <- opt_infec.gr.vc.range3usa %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



domestic_usa <- ggplot(data = opt_infec.gr.vc.range3usa) + 
  geom_bar(aes(var, vc1.max * 100+10), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 * 100+10), position = "identity", stat = "identity", fill = "#21468b") + 
  geom_bar(aes(var, vc1.min * 100+10), position = "identity", stat = "identity", fill = "white") + 
  geom_hline(yintercept = opt_infec.gr.vc.range3usa$vc1[1] * 100+10, color = "darkgray") + 
  labs(x = "", y = "Reduction in Percent Positivity", 
       title = "Domestic mobility alone") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator")) + 
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, by = 10), 
                     labels = seq(-10, 40, by = 10), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf,  y = 0, yend = 50, color = "darkgray") + 
  coord_flip() + 
  theme(
    legend.position = c(0.95, 0.8),
    legend.title = element_blank(),
    legend.text = element_text(size = 11, color = "black"),
    plot.title = element_text(hjust = 0.5),
    axis.text = element_text(size = 13, color = "black"),
    axis.ticks = element_line(color = "darkgray"), 
    axis.title = element_text(size = 13, color = "black")
  )
domestic_usa



title_cn <- ggdraw() + draw_label("Northern China", fontface='bold',hjust = -0.2, size=13)
title_cs <- ggdraw() + draw_label("Southern China", fontface='bold',hjust = 0.4, size=13)
title_uk <- ggdraw() + draw_label("England", fontface='bold',hjust = 0.3, size=13)
title_usa <- ggdraw() + draw_label("The U.S.", fontface='bold',hjust = 0.4, size=13)

# combine above 10 plots into 2 rows
fig.com <- plot_grid(title_cn,
                     title_cs,
                     title_uk,
                     title_usa,
                     mask_cn,  
                     mask_cs +  theme(axis.text.y = element_blank()) ,
                     mask_uk +   theme(axis.text.y = element_blank()),
                     mask_usa +   theme(axis.text.y = element_blank()) ,
                     inbound_cn , 
                     inbound_cs +  theme(axis.text.y = element_blank()),
                     inbound_uk+ theme(axis.text.y = element_blank()),
                     inbound_usa+   theme(axis.text.y = element_blank()),
                     domestic_cn , 
                     domestic_cs+  theme(axis.text.y = element_blank()), 
                     domestic_uk+  theme(axis.text.y = element_blank()), 
                     domestic_usa +  theme(axis.text.y = element_blank()), 
                     nrow = 4, axis = "l", 
                     rel_widths = c(2.0, 1.3, 1.3, 1.3), 
                     rel_heights  = c(0.1, 1, 1, 1),
                     label_x = c(0.33, 0, 0, 0,0.33, 0, 0, 0, 0.33, 0, 0, 0, 0.33, 0,0,0), 
                     labels = c("", "", "", "","a1", "a2", "a3", "a4", "b1", "b2", "b3", "b4","c1", "c2", "c3", "c4" ))
fig.com

outfile <- glue("Source plot/output/sensitivity21-22.tif")
tiff(outfile, width = 14, height = 9, unit = "in", res = 300, compression = "lzw")
print(fig.com)
dev.off()