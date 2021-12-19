# https://github.com/rfordatascience/tidytuesday/blob/master/data/2021/2021-03-02/readme.md
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-03-02')
tuesdata <- tidytuesdayR::tt_load(2021, week = 10)

youtube <- tuesdata$youtube

# Or read in the data manually

youtube <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-02/youtube.csv')
