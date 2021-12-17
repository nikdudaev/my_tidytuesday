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
rm(tuesdata)

studio_album_tracks %>% ggplot(aes(x = danceability, y = energy)) + geom_point()
studio_album_tracks %>% ggplot(aes(x = danceability, y = loudness)) + geom_point()
studio_album_tracks %>% ggplot(aes(x = danceability, y = speechiness)) + geom_point()
studio_album_tracks %>% ggplot(aes(x = danceability, y = valence)) + geom_point()

# Tokenizing lyrics
lyrics_tokenized <- unnest_tokens(lyrics, word, line, drop = FALSE)

# Removing Stop Words
tidy_lyrics <- lyrics_tokenized %>% anti_join(stop_words)

common_words <- tidy_lyrics %>% count(word, sort = TRUE)
common_words %>% filter(n > 50) %>% mutate(word = reorder(word, n)) %>% ggplot(aes(x = word, y = n)) + geom_col() + xlab(NULL) + coord_flip()

nrcjoy <- get_sentiments("nrc") %>% filter(sentiment == "joy")

tidy_lyrics %>%
  inner_join(nrcjoy) %>%
  count(word, sort = TRUE)

nrcsadness <- get_sentiments("nrc") %>% filter(sentiment == "sadness")

tidy_lyrics %>%
  inner_join(nrcsadness) %>%
  count(word, sort = TRUE)
