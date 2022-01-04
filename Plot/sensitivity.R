################################################################################
#### Plot Supplementary Fig. 7 ####
rm(list = ls())

library(tidyverse)
library(glue)
library(xlsx)
library(cowplot)
library(scales)

# setwd("~/DynamicVaccineAllocationMod-main")
# dout <- "Source code/output"
dout<-""


# load data

opt_infec.gr.vc.range1cn <- read.xlsx("Source Data/sensitivity/sensitivity.xlsx", 
                                   sheetName = "cnm")

opt_infec.gr.vc.range1cn <- opt_infec.gr.vc.range1cn %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))


onemask_cn <- ggplot(data = opt_infec.gr.vc.range1cn) + 
  geom_bar(aes(var, vc1.max * 100+10), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 * 100+10), position = "identity", stat = "identity", fill = "#21468b") + 
  geom_bar(aes(var, vc1.min * 100+10), position = "identity", stat = "identity", fill = "white") + 
  geom_hline(yintercept = opt_infec.gr.vc.range1cn$vc1[1] * 100+10, color = "darkgray") + 
  
  labs(x = "", y = "Reduction in Percent Positivity", 
       title = "Mask-wear intervention ") +
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator"
                              )) + 
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, by = 10), 
                     labels = seq(-10, 40, by = 10), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf, y = -10, yend = 40, color = "darkgray") + 
  coord_flip() + 
  theme(
    legend.position = c(0.95, 0.8),
    legend.title = element_blank(),
    legend.text = element_text(size = 11, color = "black"),
    plot.title = element_text(hjust = 0.5),
    axis.text = element_text(size = 13, color = "black"),
    axis.ticks = element_line(color = "darkgray"), 
    axis.title = element_text(size = 13, color = "black"),
  )
onemask_cn


opt_infec.gr.vc.range2cn <- read.xlsx("Source Data/sensitivity/sensitivity.xlsx", 
                                   sheetName = "cnd")

opt_infec.gr.vc.range2cn <- opt_infec.gr.vc.range2cn %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



onedomestic_cn <- ggplot(data = opt_infec.gr.vc.range2cn) + 
  geom_bar(aes(var, vc1.max * 100+10), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 * 100+10), position = "identity", stat = "identity", fill = "#21468b") + 
  geom_bar(aes(var, vc1.min * 100+10), position = "identity", stat = "identity", fill = "white") + 
  geom_hline(yintercept = opt_infec.gr.vc.range2cn$vc1[1] * 100+10, color = "darkgray") + 
  labs(x = "", y = "Reduction in Percent Positivity", 
       title = "Domestic mobility") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator")) + 
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, by = 10), 
                     labels = seq(-10, 40, by = 10), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf, y = -10, yend = 40, color = "darkgray") + 
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
onedomestic_cn


opt_infec.gr.vc.range3cn <- read.xlsx("Source Data/sensitivity/sensitivity.xlsx", 
                                   sheetName = "cni")

opt_infec.gr.vc.range3cn <- opt_infec.gr.vc.range3cn %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



oneinter_cn <- ggplot(data = opt_infec.gr.vc.range3cn) + 
  geom_bar(aes(var, vc1.max * 100+10), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 * 100+10), position = "identity", stat = "identity", fill = "#21468b") + 
  geom_bar(aes(var, vc1.min * 100+10), position = "identity", stat = "identity", fill = "white") + 
  geom_hline(yintercept = opt_infec.gr.vc.range3cn$vc1[1] * 100+10, color = "darkgray") + 
  labs(x = "", y = "Reduction in Percent Positivity", 
       title = "International mobility") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator")) + 
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, by = 10), 
                     labels = seq(-10, 40, by = 10), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf, y = -10, yend = 40, color = "darkgray") + 
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
oneinter_cn


opt_infec.gr.vc.range4cn <- read.xlsx("Source Data/sensitivity/sensitivity.xlsx", 
                                   sheetName = "cnl")

opt_infec.gr.vc.range4cn <- opt_infec.gr.vc.range4cn %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



maskl_cn <- ggplot(data = opt_infec.gr.vc.range4cn) + 
  geom_bar(aes(var, vc1.max ), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 ), position = "identity", stat = "identity", fill = "#21468b") + 
  geom_bar(aes(var, vc1.min ), position = "identity", stat = "identity", fill = "white") + 
  geom_hline(yintercept = opt_infec.gr.vc.range4cn$vc1[1], color = "darkgray") + 
  labs(x = "", y = "Number of weeks", 
       title = "Lag of mask-wearing") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator")) + 
  scale_y_continuous(limits = c(-10, 40), breaks = seq(-10, 40, by = 10), 
                     labels = c("",seq(0, 40, by = 10)), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf, y = -10, yend = 40, color = "darkgray") + 
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
maskl_cn



# load data
opt_infec.gr.vc.range1cs <- read.xlsx("Source Data/sensitivity/sensitivity.xlsx", 
                                      sheetName = "csm")

opt_infec.gr.vc.range1cs <- opt_infec.gr.vc.range1cs %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



onemask_cs <- ggplot(data = opt_infec.gr.vc.range1cs) + 
  geom_bar(aes(var, vc1.max * 100+10), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 * 100+10), position = "identity", stat = "identity", fill = "#21468b") + 
  geom_bar(aes(var, vc1.min * 100+10), position = "identity", stat = "identity", fill = "white") + 
  geom_hline(yintercept = opt_infec.gr.vc.range1cs$vc1[1] * 100+10, color = "darkgray") + 
  labs(x = "", y = "Reduction in Percent Positivity", 
       title = "Mask-wear intervention") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator")) + 
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, by = 10), 
                     labels = seq(-10, 40, by = 10), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf, y = -10, yend = 40, color = "darkgray") + 
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
onemask_cs


opt_infec.gr.vc.range2cs <- read.xlsx("Source Data/sensitivity/sensitivity.xlsx", 
                                      sheetName = "csd")

opt_infec.gr.vc.range2cs <- opt_infec.gr.vc.range2cs %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



onedomestic_cs <- ggplot(data = opt_infec.gr.vc.range2cs) + 
  geom_bar(aes(var, vc1.max * 100+10), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 * 100+10), position = "identity", stat = "identity", fill = "#21468b") + 
  geom_bar(aes(var, vc1.min * 100+10), position = "identity", stat = "identity", fill = "white") + 
  geom_hline(yintercept = opt_infec.gr.vc.range2cs$vc1[1] * 100+10, color = "darkgray") + 
  labs(x = "", y = "Reduction in Percent Positivity", 
       title = "Domestic mobility") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator")) + 
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, by = 10), 
                     labels = seq(-10, 40, by = 10), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf, y = -10, yend = 40, color = "darkgray") + 
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
onedomestic_cs


opt_infec.gr.vc.range3cs <- read.xlsx("Source Data/sensitivity/sensitivity.xlsx", 
                                      sheetName = "csi")

opt_infec.gr.vc.range3cs <- opt_infec.gr.vc.range3cs %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



oneinter_cs <- ggplot(data = opt_infec.gr.vc.range3cs) + 
  geom_bar(aes(var, vc1.max * 100+10), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 * 100+10), position = "identity", stat = "identity", fill = "#21468b") + 
  geom_bar(aes(var, vc1.min * 100+10), position = "identity", stat = "identity", fill = "white") + 
  geom_hline(yintercept = opt_infec.gr.vc.range3cs$vc1[1] * 100+10, color = "darkgray") + 
  labs(x = "", y = "Reduction in Percent Positivity", 
       title = "International mobility") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator")) + 
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, by = 10), 
                     labels = seq(-10, 40, by = 10), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf, y = -10, yend = 40, color = "darkgray") + 
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
oneinter_cs


opt_infec.gr.vc.range4cs <- read.xlsx("Source Data/sensitivity/sensitivity.xlsx", 
                                      sheetName = "csl")

opt_infec.gr.vc.range4cs <- opt_infec.gr.vc.range4cs %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



maskl_cs <- ggplot(data = opt_infec.gr.vc.range4cs) + 
  geom_bar(aes(var, vc1.max ), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 ), position = "identity", stat = "identity", fill = "#21468b") + 
  geom_bar(aes(var, vc1.min ), position = "identity", stat = "identity", fill = "white") + 
  geom_hline(yintercept = opt_infec.gr.vc.range4cs$vc1[1], color = "darkgray") + 
  labs(x = "", y = "Number of weeks", 
       title = "Lag of mask-wearing") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator")) + 
  scale_y_continuous(limits = c(-10, 40), breaks = seq(-10, 40, by = 10), 
                     labels = c("",seq(0, 40, by = 10)), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf, y = -10, yend = 40, color = "darkgray") + 
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
maskl_cs



# load data
opt_infec.gr.vc.range1uk <- read.xlsx("Source Data/sensitivity/sensitivity.xlsx", 
                                      sheetName = "ukm")

opt_infec.gr.vc.range1uk <- opt_infec.gr.vc.range1uk %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



onemask_uk <- ggplot(data = opt_infec.gr.vc.range1uk) + 
  geom_bar(aes(var, vc1.max * 100+10), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 * 100+10), position = "identity", stat = "identity", fill = "#21468b") + 
  geom_bar(aes(var, vc1.min * 100+10), position = "identity", stat = "identity", fill = "white") + 
  geom_hline(yintercept = opt_infec.gr.vc.range1uk$vc1[1] * 100+10, color = "darkgray") + 
  labs(x = "", y = "Reduction in Percent Positivity", 
       title = "Mask-wear intervention") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator")) + 
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, by = 10), 
                     labels = seq(-10, 40, by = 10), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf, y = -10, yend = 40, color = "darkgray") + 
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
onemask_uk


opt_infec.gr.vc.range2uk <- read.xlsx("Source Data/sensitivity/sensitivity.xlsx", 
                                      sheetName = "ukd")

opt_infec.gr.vc.range2uk <- opt_infec.gr.vc.range2uk %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



onedomestic_uk <- ggplot(data = opt_infec.gr.vc.range2uk) + 
  geom_bar(aes(var, vc1.max * 100+10), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 * 100+10), position = "identity", stat = "identity", fill = "#21468b") + 
  geom_bar(aes(var, vc1.min * 100+10), position = "identity", stat = "identity", fill = "white") + 
  geom_hline(yintercept = opt_infec.gr.vc.range2uk$vc1[1] * 100+10, color = "darkgray") + 
  labs(x = "", y = "Reduction in Percent Positivity", 
       title = "Domestic mobility") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator")) + 
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, by = 10), 
                     labels = seq(-10, 40, by = 10), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf, y = -10, yend = 40, color = "darkgray") + 
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
onedomestic_uk


opt_infec.gr.vc.range3uk <- read.xlsx("Source Data/sensitivity/sensitivity.xlsx", 
                                      sheetName = "uki")

opt_infec.gr.vc.range3uk <- opt_infec.gr.vc.range3uk %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



oneinter_uk <- ggplot(data = opt_infec.gr.vc.range3uk) + 
  geom_bar(aes(var, vc1.max * 100+10), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 * 100+10), position = "identity", stat = "identity", fill = "#21468b") + 
  geom_bar(aes(var, vc1.min * 100+10), position = "identity", stat = "identity", fill = "white") + 
  geom_hline(yintercept = opt_infec.gr.vc.range3uk$vc1[1] * 100+10, color = "darkgray") + 
  labs(x = "", y = "Reduction in Percent Positivity", 
       title = "International mobility") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator")) + 
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, by = 10), 
                     labels = seq(-10, 40, by = 10), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf, y = -10, yend = 40, color = "darkgray") + 
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
oneinter_uk


opt_infec.gr.vc.range4uk <- read.xlsx("Source Data/sensitivity/sensitivity.xlsx", 
                                      sheetName = "ukl")

opt_infec.gr.vc.range4uk <- opt_infec.gr.vc.range4uk %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



maskl_uk <- ggplot(data = opt_infec.gr.vc.range4uk) + 
  geom_bar(aes(var, vc1.max ), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 ), position = "identity", stat = "identity", fill = "#21468b") + 
  geom_bar(aes(var, vc1.min ), position = "identity", stat = "identity", fill = "white") + 
  geom_hline(yintercept = opt_infec.gr.vc.range4uk$vc1[1], color = "darkgray") + 
  labs(x = "", y = "Number of weeks", 
       title = "Lag of mask-wearing") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator")) + 
  scale_y_continuous(limits = c(-10, 40), breaks = seq(-10, 40, by = 10), 
                     labels = c("",seq(0, 40, by = 10)), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf, y = -10, yend = 40, color = "darkgray") + 
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
maskl_uk



# load data
opt_infec.gr.vc.range1usa <- read.xlsx("Source Data/sensitivity/sensitivity.xlsx", 
                                       sheetName = "usam")

opt_infec.gr.vc.range1usa <- opt_infec.gr.vc.range1usa %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



onemask_usa <- ggplot(data = opt_infec.gr.vc.range1usa) + 
  geom_bar(aes(var, vc1.max * 100+10), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 * 100+10), position = "identity", stat = "identity", fill = "#21468b") + 
  geom_bar(aes(var, vc1.min * 100+10), position = "identity", stat = "identity", fill = "white") + 
  geom_hline(yintercept = opt_infec.gr.vc.range1usa$vc1[1] * 100+10, color = "darkgray") + 
  labs(x = "", y = "Reduction in Percent Positivity", 
       title = "Mask-wear intervention") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator")) + 
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, by = 10), 
                     labels = seq(-10, 40, by = 10), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf, y = -10, yend = 40, color = "darkgray") + 
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
onemask_usa


opt_infec.gr.vc.range2usa <- read.xlsx("Source Data/sensitivity/sensitivity.xlsx", 
                                       sheetName = "usad")

opt_infec.gr.vc.range2usa <- opt_infec.gr.vc.range2usa %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



onedomestic_usa <- ggplot(data = opt_infec.gr.vc.range2usa) + 
  geom_bar(aes(var, vc1.max * 100+10), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 * 100+10), position = "identity", stat = "identity", fill = "#21468b") + 
  geom_bar(aes(var, vc1.min * 100+10), position = "identity", stat = "identity", fill = "white") + 
  geom_hline(yintercept = opt_infec.gr.vc.range2usa$vc1[1] * 100+10, color = "darkgray") + 
  labs(x = "", y = "Reduction in Percent Positivity", 
       title = "Domestic mobility") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator")) + 
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, by = 10), 
                     labels = seq(-10, 40, by = 10), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf, y = -10, yend = 40, color = "darkgray") + 
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
onedomestic_usa


opt_infec.gr.vc.range3usa <- read.xlsx("Source Data/sensitivity/sensitivity.xlsx", 
                                       sheetName = "usai")

opt_infec.gr.vc.range3usa <- opt_infec.gr.vc.range3usa %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



oneinter_usa <- ggplot(data = opt_infec.gr.vc.range3usa) + 
  geom_bar(aes(var, vc1.max * 100+10), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 * 100+10), position = "identity", stat = "identity", fill = "#21468b") + 
  geom_bar(aes(var, vc1.min * 100+10), position = "identity", stat = "identity", fill = "white") + 
  geom_hline(yintercept = opt_infec.gr.vc.range3usa$vc1[1] * 100+10, color = "darkgray") + 
  labs(x = "", y = "Reduction in Percent Positivity", 
       title = "International mobility") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator")) + 
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, by = 10), 
                     labels = seq(-10, 40, by = 10), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf, y = -10, yend = 40, color = "darkgray") + 
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
oneinter_usa


opt_infec.gr.vc.range4usa <- read.xlsx("Source Data/sensitivity/sensitivity.xlsx", 
                                       sheetName = "usal")

opt_infec.gr.vc.range4usa <- opt_infec.gr.vc.range4usa %>% 
  rename(vc1 = baseline, 
         vc1.max = maximum, 
         vc1.min = minimal) %>% 
  mutate(var = factor(var, levels = c("End of training window", "Lag of moving average", "Exclusion of seasonal indicator")))



maskl_usa <- ggplot(data = opt_infec.gr.vc.range4usa) + 
  geom_bar(aes(var, vc1.max ), position = "identity", stat = "identity", fill = "#ae1c28") + 
  geom_bar(aes(var, vc1 ), position = "identity", stat = "identity", fill = "#21468b") + 
  geom_bar(aes(var, vc1.min ), position = "identity", stat = "identity", fill = "white") + 
  geom_hline(yintercept = opt_infec.gr.vc.range4usa$vc1[1], color = "darkgray") + 
  labs(x = "", y = "Number of weeks", 
       title = "Lag of mask-wearing") + 
  scale_x_discrete(labels = c("End of\n training window", "Lag of\n moving average", "Inclusion of\n seasonal indicator")) + 
  scale_y_continuous(limits = c(-10, 40), breaks = seq(-10, 40, by = 10), 
                     labels = c("",seq(0, 40, by = 10)), position = "right") + 
  theme_classic() +
  theme(axis.line = element_blank()) +
  geom_segment(aes(x = 0.5, xend = 3.5, y = -Inf, yend = -Inf), color = "darkgray") + 
  geom_segment(x = Inf, xend = Inf, y = -10, yend = 40, color = "darkgray") + 
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
maskl_usa


# make title
title_cn <- ggdraw() + draw_label("Northern China", fontface='bold',hjust = -0.2, size=13)
title_cs <- ggdraw() + draw_label("Southern China", fontface='bold',hjust = 0.4, size=13)
title_uk <- ggdraw() + draw_label("England", fontface='bold',hjust = 0.3, size=13)
title_usa <- ggdraw() + draw_label("The U.S.", fontface='bold',hjust = 0.4, size=13)

# combine above 10 plots into 2 rows
fig.com <- plot_grid(title_cn,
                     title_cs,
                     title_uk,
                     title_usa,
                      onemask_cn,  
                     onemask_cs +  theme(axis.text.y = element_blank()) ,
                     onemask_uk +   theme(axis.text.y = element_blank()),
                     onemask_usa +   theme(axis.text.y = element_blank()) ,
                     onedomestic_cn , 
                     onedomestic_cs +  theme(axis.text.y = element_blank()),
                     onedomestic_uk+ theme(axis.text.y = element_blank()),
                     onedomestic_usa+   theme(axis.text.y = element_blank()),
                     oneinter_cn , 
                     oneinter_cs+  theme(axis.text.y = element_blank()), 
                     oneinter_uk+  theme(axis.text.y = element_blank()), 
                     oneinter_usa +  theme(axis.text.y = element_blank()), 
                     maskl_cn, 
                     maskl_cs+  theme(axis.text.y = element_blank()), 
                     maskl_uk+  theme(axis.text.y = element_blank()), 
                     maskl_usa+  theme(axis.text.y = element_blank()), 
                     nrow = 5, axis = "l", 
                     rel_widths = c(2.0, 1.3, 1.3, 1.3), 
                     rel_heights  = c(0.1, 1, 1, 1,1),
                     label_x = c(0.33, 0, 0, 0,0.33, 0, 0, 0, 0.33, 0, 0, 0, 0.33, 0,0,0, 0.33, 0,0,0), 
                     labels = c("", "", "", "","a1", "a2", "a3", "a4", "b1", "b2", "b3", "b4","c1", "c2", "c3", "c4","d1", "d2", "d3", "d4" ))
fig.com

outfile <- glue("output/sensitivity.tif")
tiff(outfile, width = 14, height = 14, unit = "in", res = 300, compression = "lzw")
print(fig.com)
dev.off()