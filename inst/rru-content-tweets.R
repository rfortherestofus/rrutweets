# Load Packages -----------------------------------------------------------

library(tidyverse)
library(googlesheets4)
library(rtweet)
library(lubridate)
library(rrutweets)

# Authentication ----------------------------------------------------------

authenticate_googlesheets()
authenticate_twitter()

rru_tweet("RRU Content Tweets")
