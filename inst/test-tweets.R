library(tidyverse)
library(googlesheets4)
library(rtweet)
library(rrutweets)

auth_googlesheets()

rru_tweets_sheet <- "https://docs.google.com/spreadsheets/d/10ec07SNOSOmpzcSVgdcfm4Mg-3N_Y7gZVvv9oycM-og/edit?usp=sharing"

rru_test_tweets <- read_sheet(rru_tweets_sheet,
                              sheet = "Test Tweets")

tweet <- rru_test_tweets %>%
  slice(1) %>%
  pull(tweet_text)

token <-
  create_token(
    app = "rrutweets",
    consumer_key = Sys.getenv("TWITTER_API_KEY"),
    consumer_secret = Sys.getenv("TWITTER_SECRET_KEY"),
    access_token = Sys.getenv("TWITTER_ACCESS_TOKEN"),
    access_secret = Sys.getenv("TWITTER_SECRET_TOKEN"),
    set_renv = FALSE
  )

post_tweet(status = "This is a new test tweet",
           token = token)
