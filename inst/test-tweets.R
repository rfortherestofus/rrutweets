
# Load Packages -----------------------------------------------------------

library(tidyverse)
library(googlesheets4)
library(rtweet)
library(lubridate)


# Decryption --------------------------------------------------------------



# Authentication ----------------------------------------------------------

googlesheets4::gs4_auth(email = Sys.getenv("GOOGLE_MAIL"),
                        path = "secret/rrutweets-sheets.json")


twitter_token <-
  create_token(
    app = "rrutweets",
    consumer_key = Sys.getenv("TWITTER_API_KEY"),
    consumer_secret = Sys.getenv("TWITTER_SECRET_KEY"),
    access_token = Sys.getenv("TWITTER_ACCESS_TOKEN"),
    access_secret = Sys.getenv("TWITTER_SECRET_TOKEN")
  )

# Get Tweets --------------------------------------------------------------

rru_tweets_sheet <- Sys.getenv("SHEET_PATH")

tweets <- read_sheet(rru_tweets_sheet,
                     sheet = "Test Tweets") %>%
  mutate(tweet_length = str_length(tweet_text)) %>%
  filter(tweet_length < 280) %>%
  filter(is.na(date_posted)) %>%
  mutate(n = row_number()) %>%
  mutate(date_posted = case_when(
    n == 1 ~ now()
  ))

tweet <- tweets %>%
  filter(!is.na(date_posted)) %>%
  pull(tweet_text)

# Post Tweet --------------------------------------------------------------

post_tweet(status = tweet,
           token = twitter_token)

# Put Tweets Back on Google Sheet -----------------------------------------


get_last_tweet_url <- function() {
  rtweet::search_tweets(q = "rfortherest",
                        include_rts = FALSE,
                        token = twitter_token) %>%
    dplyr::filter(screen_name == "rfortherest") %>%
    dplyr::slice(1) %>%
    dplyr::pull(status_url)
}

Sys.sleep(10)

tweets %>%
  write_sheet(rru_tweets_sheet,
              sheet = "Test Tweets")
