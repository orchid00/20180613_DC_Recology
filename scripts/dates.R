library(tidyverse)
library(lubridate)


my_date <- ymd("2015-01-01")
str(my_date)

my_date <- ymd(paste("2015", "1", "1", sep = "-")) 
str(my_date)

ymd(paste(surveys$year, surveys$month, surveys$day, sep = "-")
    )
