# load package tidiverse
#library(tidyverse)
library(ggplot2)
library(readr)

#download.file("https://ndownloader.figshare.com/files/11930600?private_link=fe0cd1848e06456e6f38",
              "data/surveys_complete.csv")

surveys_complete <- read_csv("data/surveys_complete.csv")

glimpse(surveys_complete)
#str(surveys_complete)


ggplot(data = surveys_complete, aes(x = species_id, y = weight, color = plot_id)) +
    geom_point()


