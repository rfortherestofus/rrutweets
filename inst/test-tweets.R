# library(tidyverse)
# library(googlesheets4)

#
# rru_tweets_sheet <- "https://docs.google.com/spreadsheets/d/10ec07SNOSOmpzcSVgdcfm4Mg-3N_Y7gZVvv9oycM-og/edit#gid=91245060"
#
# rru_test_tweets <- read_sheet(rru_tweets_sheet,
#                               sheet = "Test Tweets")
#
# # rru_content_tweets %>%
# #   write_sheet(rru_tweets_sheet,
# #               sheet = "RRU Content Tweets")
#
#
# tweet <- rru_test_tweets %>%
#   slice(1) %>%
#   pull(tweet_text)
#


library(rtweet)

token <-
  create_token(
    app = "rrutweets",
    consumer_key = Sys.getenv("TW_API_KEY"),
    consumer_secret = Sys.getenv("TW_SECRET_KEY"),
    access_token = Sys.getenv("TW_ACCESS_TOKEN"),
    access_secret = Sys.getenv("TW_SECRET_TOKEN"),
    set_renv = FALSE
  )

post_tweet(status = "This is a new test tweet",
           token = token)
