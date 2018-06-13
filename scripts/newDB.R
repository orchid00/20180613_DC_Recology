# Load packages -----------------------------------------------------------
library(dbplyr)
library(DBI)
library(RSQLite)


# load csv files ----------------------------------------------------------

species_o <- read_csv("data/species.csv")
surveys_o <- read_csv("data/surveys.csv")
plots_o <- read_csv("data/plots.csv")

# create a database file in SQLite ----------------------------------------

my_db_file <- "data/portal-database_DC.sqlite"
my_db <- src_sqlite(path = my_db_file, create = TRUE)

my_db


# Add tables to the database ----------------------------------------------

copy_to(my_db, surveys_o, "surveys")
copy_to(my_db, plots_o, "plots")
copy_to(my_db, species_o, "species")
my_db


# working with your newly created database --------------------------------

# From here follow the steps from the previous part
surveys_view <- tbl(my_db, "surveys")

surveys_view %>% 
    select(record_id, hindfoot_length) %>% 
    filter(record_id > 6)


# new section -------------------------------------------------------------


