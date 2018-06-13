library(dbplyr)
library(DBI)
library(RSQLite)

species_o <- read_csv("data/species.csv")

surveys_o <- read_csv("data/surveys.csv")

plots_o <- read_csv("data/plots.csv")


my_db_file <- "data/portal-database_DC.sqlite"
my_db <- src_sqlite(my_db_file, create = TRUE)

# add tables
copy_to(my_db, surveys_o, "surveys")
copy_to(my_db, plots_o, "plots")
copy_to(my_db, species_o, "species")
my_db


# now we finish this part but you can follow the steps on the previous 