options(scipen = 999)

# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-12-14')

library(tidyverse)
library(tidytext)

lyrics <- tuesdata$lyrics
related_artists <- tuesdata$related_artists
studio_album_tracks <- tuesdata$studio_album_tracks
for_observable_plot <- studio_album_tracks %>%
  select(-c(
    artist_name, 
    artist_id, 
    album_id,
    album_release_date,
    key,
    mode,
    tempo,
    track_id,
    time_signature,
    duration_ms,
    key_name,
    mode_name,
    key_mode)
    ) %>%
  mutate(
    album_year = str_c(album_name, " (", album_release_year, ")"),
    danceability = danceability - 0.5,
    energy = energy - 0.5,
    speechiness = speechiness - 0.5,
    acousticness = acousticness - 0.5,
    instrumentalness = instrumentalness - 0.5,
    liveness = liveness - 0.5,
    valence = valence - 0.5
  )
write_csv(studio_album_tracks, "./studio_album_tracks.csv")
rm(tuesdata)

# Sentiment Analysis

forever <- lyrics %>% 
  select(c(album_name, song_name, track_number, line)) %>%
  filter(album_name == "Forever") %>%
  group_by(album_name, song_name, track_number) %>%
  mutate(
    linenumber = row_number()
    ) %>%
  ungroup() %>%
  unnest_tokens(word, line, drop = FALSE) %>%
  anti_join(stop_words) %>%
  inner_join(get_sentiments("bing")) %>%
  count(album_name, index = linenumber %/% 11, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)

spice <- lyrics %>% 
  select(c(album_name, song_name, track_number, line)) %>%
  filter(album_name == "Spice") %>%
  group_by(album_name, song_name, track_number) %>%
  mutate(
    linenumber = row_number()
  ) %>%
  ungroup() %>%
  unnest_tokens(word, line, drop = FALSE) %>%
  anti_join(stop_words) %>%
  inner_join(get_sentiments("bing")) %>%
  count(album_name, index = linenumber %/% 10, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)

spiceworld <- lyrics %>% 
  select(c(album_name, song_name, track_number, line)) %>%
  filter(album_name == "Spiceworld") %>%
  group_by(album_name, song_name, track_number) %>%
  mutate(
    linenumber = row_number()
  ) %>%
  ungroup() %>%
  unnest_tokens(word, line, drop = FALSE) %>%
  anti_join(stop_words) %>%
  inner_join(get_sentiments("bing")) %>%
  count(album_name, index = linenumber %/% 10, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)
all_albums <- rbind(forever, spice, spiceworld)
all_albums %>% ggplot(aes(index, sentiment, fill = album_name)) + geom_col(show.legend = FALSE) + facet_wrap(~album_name, ncol = 1, scales = "free_x")

# NRC


studio_album_tracks %>% 
  ggplot(aes(x = track_number, y = loudness, color = album_name)) +
  geom_line()

