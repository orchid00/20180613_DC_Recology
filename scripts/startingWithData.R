# load package tidiverse
library(tidyverse)

download.file("https://ndownloader.figshare.com/files/2292169",
              "data/portal_data_joined.csv")

surveysdb <- read_csv("data/portal_data_joined.csv")

glimpse(surveysdb)
str(surveysdb)
