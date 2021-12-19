# https://github.com/rfordatascience/tidytuesday/blob/master/data/2021/2021-04-27/readme.md
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-04-27')
tuesdata <- tidytuesdayR::tt_load(2021, week = 18)

departures.csv <- tuesdata$departures.csv

# Or read in the data manually

departures <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-04-27/departures.csv')
