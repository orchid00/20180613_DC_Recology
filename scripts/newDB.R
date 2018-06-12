species <- read_csv("data/species.csv")

surveys <- read_csv("data/surveys.csv")

plots <- read_csv("data/plots.csv")


my_db_file <- "data/portal-database_DC.sqlite"
my_db <- src_sqlite(my_db_file, create = TRUE)

# add tables
copy_to(my_db, surveys)
copy_to(my_db, plots)
my_db
