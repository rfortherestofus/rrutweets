library(rtweet)
library(tidyverse)
library(janitor)
library(lubridate)
library(googlesheets4)
library(rrutweets)

authenticate_twitter()
authenticate_googlesheets()




new_tweets <- search_tweets(q = "rfortherest",
                            include_rts = FALSE,
                            n = 1000,
                            retryonratelimit = TRUE) %>%
  filter(screen_name == "rfortherest") %>%
  select(text, favorite_count, retweet_count) %>%
  set_names("tweet", "likes", "retweets")



old_tweets <- read_csv(system.file("twitter-export.csv",
                                   package = "rrutweets")) %>%
  clean_names() %>%
  select(tweet_full_text,
         tweet_favorite_count,
         tweet_retweet_count) %>%
  set_names("tweet", "likes", "retweets")

rru_tweets_sheet <- Sys.getenv("SHEET_PATH")

bind_rows(new_tweets, old_tweets) %>%
  write_sheet(rru_tweets_sheet,
              sheet = "Tweet Performance")
