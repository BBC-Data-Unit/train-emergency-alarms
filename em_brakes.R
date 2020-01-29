library(tidyverse)
library(janitor)
library(readxl)

pacman::p_load('dplyr', 'tidyr', 'gapminder',
               'ggplot2',  'ggalt',
               'forcats', 'R.utils', 'png', 
               'grid', 'ggpubr', 'scales',
               'bbplot2')

#remove old files

rm(data1,data2,RDG_data)

#import data

library(readr)

RDG_data <- read_csv("RDG data.csv", col_types = cols(Text = col_character()))

RDG_data_Copy <- read_csv("RDG data - Copy.csv", 
                          col_types = cols(Text = col_character()))

#clean names

RDG_data <- clean_names(RDG_data)

RDG_data_Copy <- clean_names(RDG_data_Copy)

#charts1

data1 <- ggplot(data = RDG_data,
                            aes(x = year,
                                y = delay_minutes))+
  geom_bar(stat = "identity",
           position = "identity",
           fill = bbc_pal("blue"))+
  geom_hline(yintercept = 0, size = 1, colour="#333333") +
  bbc_style() +
  labs(title="Rail delays due to alarm systems",
       subtitle = "Minutes delay in the year to August caused by use of passenger \ncommunication cord, door egress or emergency alarms")+
  scale_y_continuous(breaks = c(0, 50000, 100000, 150000, 200000),
                     labels = c("", "", "", "",""))+
  theme(panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_blank())

data1

data2 <- data1 +
  geom_label(aes(x = year, y = delay_minutes, label = paste0(text)),
             hjust = 0.5,
             vjust = 1,
             colour = "white",
             fill = NA,
             label.size = NA,
             family="Helvetica",
             size = 6)

data2

#save out

finalise_plot(plot_name = data2,
              source = "Source: Rail Delivery Group",
              width_pixels = 640,
              height_pixels = 550,
              save_filepath = "RDG_data-nc.png")

#charts2

data3 <- ggplot(data = RDG_data_Copy,
                aes(x = year,
                    y = incidents))+
  geom_bar(stat = "identity",
           position = "identity",
           fill = bbc_pal("red"))+
  geom_hline(yintercept = 0, size = 1, colour="#333333") +
  bbc_style() +
  labs(title="Alarm activations on trains",
       subtitle = "Incidents in the year to August caused by use of passenger \ncommunication cord, door egress or emergency alarms")+
  scale_y_continuous(breaks = c(0, 50000, 100000, 150000, 200000),
                     labels = c("", "", "", "",""))+
  theme(panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_blank())

data3

data4 <- data3 +
  geom_label(aes(x = year, y = incidents, label = paste0(text)),
             hjust = 0.5,
             vjust = 1,
             colour = "white",
             fill = NA,
             label.size = NA,
             family="Helvetica",
             size = 6)

data4

#save out

finalise_plot(plot_name = data4,
              source = "Source: Rail Delivery Group",
              width_pixels = 640,
              height_pixels = 550,
              save_filepath = "RDG_data_copy-nc.png")
