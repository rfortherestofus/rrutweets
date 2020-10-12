# Load Packages -----------------------------------------------------------

library(tidyverse)
library(googlesheets4)
library(rtweet)
library(lubridate)
library(rrutweets)

# Authentication ----------------------------------------------------------

authenticate_googlesheets()
authenticate_twitter()

# Post Tweet --------------------------------------------------------------

post_tweet(status = "Test",
           token = twitter_token)

temp <- get_followers(user = "rfortherest",
                      n = 10000)
