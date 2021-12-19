# https://github.com/rfordatascience/tidytuesday/blob/master/data/2021/2021-09-07/readme.md
options(scipen = 999)
library(tidyverse)
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

#tuesdata <- tidytuesdayR::tt_load('2021-09-07')
#tuesdata <- tidytuesdayR::tt_load(2021, week = 37)

#results <- tuesdata$results

# Or read in the data manually

drivers <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-07/drivers.csv')
lap_times <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-07/lap_times.csv')
races <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-07/races.csv')
results <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-07/results.csv')

# Lap Times
lap_times <- lap_times %>%
  select(-driverId)
races <- races %>%
  select(-c(round, circuitId, time, url))

races_lap_times <- merge(lap_times, races, by = "raceId", all.x = TRUE)

fastest_laps <- results %>%
  select(c(raceId, driverId, fastestLap, fastestLapTime, fastestLapSpeed))
drivers <- drivers %>%
  select(-c(driverRef, number, code, url))

fastest_laps <- merge(fastest_laps, drivers, by = "driverId", all.x = TRUE)
fastest_laps <- merge(fastest_laps, races, by = "raceId", all.x = TRUE)

rm(lap_times, races, results, drivers)

write_csv(fastest_laps, "F1_fastest_laps.csv")
write_csv(races_lap_times, "F1_races_lap_times.csv")
