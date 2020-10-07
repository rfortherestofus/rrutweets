# Load Packages -----------------------------------------------------------

library(tidyverse)
library(googlesheets4)
library(rtweet)
library(lubridate)


# Airtable ----------------------------------------------------------------

library(httr)
library(jsonlite)
library(airtabler)

airtable_api_key <- Sys.getenv("AIRTABLE_API_KEY")

temp <- airtable(base = "wsp5wOh2LZUytD97g",
                 tables = "RRU Tweets") %>%
  as_tibble()

air_select("wsp5wOh2LZUytD97g", "RRU Tweets")

temp <- fromJSON(str_glue("https://api.airtable.com/v0/appM1W2qEtMbiF2J1/RRU%20Content%20Tweets?maxRecords=3&view=Grid%20view?api_key={airtable_api_key}"))$fields %>%
  as_tibble()

# Authentication ----------------------------------------------------------

if (rlang::is_interactive() == TRUE) {

gs4_auth(
  email = "david@rfortherestofus.com",
  path = "/Users/davidkeyes/.R/gargle/r-for-the-rest-of-us-misc-c3cd7d281458.json",
  scopes = "https://www.googleapis.com/auth/spreadsheets",
  cache = gargle::gargle_oauth_cache(),
  use_oob = gargle::gargle_oob_default(),
  token = NULL
)

} else {
  googlesheets4::gs4_auth(email = Sys.getenv("GOOGLE_MAIL"), path = "rrutweets-sheet.json")
}

twitter_token <-
  create_token(
    app = "rrutweets",
    consumer_key = Sys.getenv("TWITTER_API_KEY"),
    consumer_secret = Sys.getenv("TWITTER_SECRET_KEY"),
    access_token = Sys.getenv("TWITTER_ACCESS_TOKEN"),
    access_secret = Sys.getenv("TWITTER_SECRET_TOKEN")
  )

# Get Tweets --------------------------------------------------------------

# rru_tweets_sheet <- Sys.getenv("SHEET_PATH")
#
# tweets <- read_sheet(rru_tweets_sheet,
#                      sheet = "Test Tweets") %>%
#   mutate(tweet_length = str_length(tweet_text)) %>%
#   filter(tweet_length < 280) %>%
#   filter(is.na(date_posted)) %>%
#   mutate(n = row_number()) %>%
#   mutate(date_posted = case_when(n == 1 ~ now()))
#
# tweet <- tweets %>%
#   filter(!is.na(date_posted)) %>%
#   pull(tweet_text)

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
