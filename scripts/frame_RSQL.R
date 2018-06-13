# Installing new packages ----
#install.packages("dbplyr")
#install.packages("RSQLite") 

# Load the libraries ----
library(dplyr)
library(dbplyr)
library(DBI)
library(RSQLite)

# download data ----
# download.file(url = "https://ndownloader.figshare.com/files/2292171",
#              destfile = "data/portal_mammals.sqlite", mode = "wb")

?download.file
# Create a connection to the sqlite database ----
# Ask the question
??dbConnect() #  To create a connection to an existing DB 
DBConnection <- DBI::dbConnect(RSQLite::SQLite(), 
                               "data/portal_mammals.sqlite")
# to see how our DBConnection object looks like
str(DBConnection)

# looking into by DBConnection
??src_dbi
dbplyr::src_dbi(DBConnection)


# interacting with tables
?tbl

dplyr::tbl(DBConnection, "surveys")
dplyr::tbl(DBConnection, "species")
dplyr::tbl(DBConnection, "plots")

# Assign it to an object
surveys <- dplyr::tbl(DBConnection, "surveys")

head(surveys)
nrow(surveys)


surveys %>% 
    filter(year == 2002, weight > 220)

?show_query

show_query(surveys %>% 
               filter(year == 2002, weight > 220))

# Write a dplyr mutate on surveys to add a column called weight_kg
surveys %>% 
    mutate(weight_kg = weight / 1000)

show_query(surveys %>% 
               mutate(weight_kg = weight / 1000))

 
surveys2002 <- surveys %>% 
    filter(year == 2002) %>% 
    as.data.frame() 

library(ggplot2)  
ggplot(data = surveys2002, aes(weight, colour = "red")) +
    stat_density(geom = "line", size = 2, position = "identity") +
    theme_classic() +
    theme(legend.position = "none")

# Exercise 
# make one chunk of code to do the subset and the plot

surveys %>%
    filter(year == 2002) %>%
    as.data.frame() %>%
    ggplot(aes(weight, colour = "red")) +
    stat_density(geom = "line", size = 2, position = "identity") +
    theme_classic() +
    theme(legend.position = "none")


# Save the surveys2002 into a csv file in your data folder
library(readr)
?write_csv
write_csv(surveys2002, path = "data/surveys2002.csv")


# Create connection to the sqlite database ----
# The RSQLite package allows R to interface with SQLite databases
# Important this SQLite function does not load the data into the R session





?dbConnect

DBconnection <- DBI::dbConnect(RSQLite::SQLite(), 
                               "data/portal_mammals.sqlite")

# How do we check this DBconnection ? ----
str(DBconnection)

# take a look at the database collection ----
src_dbi(DBconnection)
# let's work with SQL syntax using tbl to create a table ----
tbl(DBconnection, "surveys")

# Challenge 1  ------------------------------------------------------------

# 1. Get table species
# 2. Get table plots

# Challenge 2 -------------------------------------------------------------

# Continue the query select 
# 
# SELECT year, species_id, plot_id, weight 
# FROM surveys



