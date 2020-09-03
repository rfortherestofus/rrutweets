
# Load Packages -----------------------------------------------------------

library(rtweet)
library(tidyverse)
library(googlesheets4)
library(devtools)
load_all()

# May 29 2020 -------------------------------------------------------------

# Get PDFs of course slides

# pdf_to_gif("/Users/davidkeyes/Documents/Work/R for the Rest of Us/courses/going-deeper/slides/slides-data-visualization.pdf",
#            "inst/tweets/images",
#            "going-deeper-data-viz")
#
# pdf_to_gif("/Users/davidkeyes/Documents/Work/R for the Rest of Us/courses/going-deeper/slides/slides-data-wrangling-and-analysis.pdf",
#            "inst/tweets/images",
#            "going-deeper-data-wrangling")
#
# pdf_to_gif("/Users/davidkeyes/Documents/Work/R for the Rest of Us/courses/going-deeper/slides/slides-rmarkdown.pdf",
#            "inst/tweets/images",
#            "going-deeper-rmarkdown")

# post_tweet(status = "testing posting\nan image",
#            media = "inst/tweets/images/going-deeper-rmarkdown.gif")


# Going Deeper Tweet Threads -----------------------------------------------

# Data Wrangling Overview

# tweets <- read_sheet("https://docs.google.com/spreadsheets/d/10ec07SNOSOmpzcSVgdcfm4Mg-3N_Y7gZVvv9oycM-og/edit#gid=0") %>%
#   mutate(tweet_number = row_number(),
#          sheet = "Data Wrangling")

# Data Wrangling Resources

# tweets <- read_sheet("https://docs.google.com/spreadsheets/d/10ec07SNOSOmpzcSVgdcfm4Mg-3N_Y7gZVvv9oycM-og/edit#gid=0",
#                      sheet = "Data Wrangling Resources") %>%
#   mutate(tweet_number = row_number())


# Data Viz ----------------------------------------------------------------

# Data viz overview

# tweets <- read_sheet("https://docs.google.com/spreadsheets/d/10ec07SNOSOmpzcSVgdcfm4Mg-3N_Y7gZVvv9oycM-og/edit#gid=0",
#                      sheet = "Data Viz") %>%
#   mutate(tweet_number = row_number()) %>%
#   mutate(tweet_media = str_replace(tweet_media, "images/", "inst/tweets/images/"))

# Data viz resources

tweets <- read_sheet("https://docs.google.com/spreadsheets/d/10ec07SNOSOmpzcSVgdcfm4Mg-3N_Y7gZVvv9oycM-og/edit#gid=0",
                     sheet = "Data Viz Resources") %>%
  mutate(tweet_number = row_number()) %>%
  mutate(tweet_media = str_replace(tweet_media, "images/", "inst/tweets/images/"))

# Post tweets -------------------------------------------------------------

pwalk(list(tweets$tweet_content,
           tweets$tweet_media,
           tweets$tweet_number),
      tweet_thread)

beepr::beep()
