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
post_tweet(status = "This is a teset tweet")
