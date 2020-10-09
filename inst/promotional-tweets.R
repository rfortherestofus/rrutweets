# Load Packages -----------------------------------------------------------

library(tidyverse)
library(googlesheets4)
library(rtweet)
library(lubridate)

# Authentication ----------------------------------------------------------

authenticate_googlesheets()
authenticate_twitter()

# Get Tweets --------------------------------------------------------------

rru_tweets_sheet <- Sys.getenv("SHEET_PATH")

tweets <- read_sheet(rru_tweets_sheet,
                     sheet = "RRU Promotional Tweets") %>%

  # Calculate length and only keep those below 280
  mutate(tweet_length = str_length(tweet_text)) %>%
  filter(tweet_length < 280) %>%

  # Only get tweets that haven't been posted
  filter(is.na(date_posted)) %>%

  # Give each row a row number
  mutate(n = row_number()) %>%

  # Only assign a date posted to a single random row
  mutate(date_posted = case_when(

    n == sample(1:nrow(.), 1) ~ now()
    ))


# Pull the tweet text from the row
tweet <- tweets %>%
  filter(!is.na(date_posted)) %>%
  pull(tweet_text)

# Post Tweet --------------------------------------------------------------

tweet <- "Know how to do t-tests in SPSS but still struggling with them in #rstats?\n\n

                      This course will be your guide!\n\n

                      Pre-launch pricing before September 30.\n\n

                      https://rfortherestofus.com/courses/inferential-statistics/"

tweet <- "Test tweet"

post_tweet(status = tweet,
           token = twitter_token)

# Put Tweets Back on Google Sheet -----------------------------------------

# get_last_tweet_url <- function() {
#
#   Sys.sleep(10)
#
#   rtweet::search_tweets(q = "rfortherest",
#                         include_rts = FALSE,
#                         token = twitter_token) %>%
#     dplyr::filter(screen_name == "rfortherest") %>%
#     dplyr::slice(1) %>%
#     dplyr::pull(status_url)
# }
#
# tweets %>%
#   write_sheet(rru_tweets_sheet,
#               sheet = "Test Tweets")
