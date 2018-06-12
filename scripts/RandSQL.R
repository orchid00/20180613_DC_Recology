# R and SQL Intro ----

# So far, we have dealt with small datasets that
# easily fit into your computer’s memory. But what
# about datasets that are too large for your computer 
# to handle as a whole?
# 
# 
# In this case, storing the data outside of R and 
# organizing it in a database is helpful. Connecting 
# to the database allows you to retrieve only the
# chunks needed for the current analysis.
# 
# There are many packages that will interact between R and
# different databases, such as: RSQLite, RMySQL
# 
# For more information you can see http://db.rstudio.com/
# 
# With dplyr we can do great selections, but we CAN NOT UPDATE 
# the database
#
# Here we will demonstrate how to interact with a database using 
# dplyr, using both the dplyr’s verb syntax and the SQL syntax.



# Installing packages ----
# install.packages("dbplyr")
# install.packages("RSQLite") # Embeds the 'SQLite' database engine in R and 
# provides an interface compliant with the 'DBI' package
# https://cran.r-project.org/web/packages/RSQLite/index.html
# Load the libraries ----
library(dbplyr)
library(DBI)
library(RSQLite)

# Download data and saving it ----
if (!dir.exists("data"))
    dir.create("data", showWarnings = FALSE)

download.file(url = "https://ndownloader.figshare.com/files/2292171",
              destfile = "data/portal_mammals.sqlite", mode = "wb")
# Create connection to the sqlite database ----
# The RSQLite package allows R to interface with SQLite databases. 
mammals <- DBI::dbConnect(RSQLite::SQLite(), "data/portal_mammals.sqlite")
# Important this SQLite function does not load the data into the R session
# It is like an open window to your SQLite database
# check 
str(mammals) # is a class SQLiteConnection



# Take a look at the database mammals ----
# ?src_dbi #  from dbplyr is an interface to use the connection and read
# the information from the database 
src_dbi(mammals)
# let's work with SQL syntax using tbl to create a table ----
src_dbi(mammals)
tbl(mammals, sql("SELECT year, species_id, plot_id, weight 
                  FROM surveys
                 ORDER BY weight DESC"))
# what have we done here?
# Yes! we can use all of the queries that we wrote on the SQL lesson
# dbplyr syntax ----
# About sections https://support.rstudio.com/hc/en-us/articles/200484568-Code-Folding-and-Sections
surveys <- tbl(mammals, "surveys")
surveys %>% 
    select(year, species_id, plot_id, weight)

# some functions from R will work in our view of the table
head(surveys)
nrow(surveys)
# So R doesn't know the number of rows
# Public secret, hidden truth ----
# Behind the scenes, dplyr:
# translates your R code into SQL
# submits it to the database
# translates the database’s response into an R data frame
# how is that working?
show_query(head(surveys))

# does this work with other dplyr chunks?
filter(surveys, year > 1995)
show_query(filter(surveys, year > 1995))
# dplyr does the SQL query for you
# 
# Challenge using dplyr
# 1. Select the species_id, sex and weight from surveys
# where weight is lower than 5
subset_weightgt5 <- 
surveys %>% 
    select(species_id, sex, weight) %>% 
    filter(weight > 5) %>% 
    arrange(weight)
# wait ... with more rows

plots <- tbl(mammals, "plots")
plots %>%
    filter(plot_id == 1) %>%
    inner_join(surveys) %>%
  collect()

format_csv(plots)
write_csv(plots, file.path("data", "surveys_exported.csv"))

