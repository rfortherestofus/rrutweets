#' Get tweets from Google Sheets, post one, then put data back on Google Sheet
#'
#' @param sheet_name
#'
#' @return
#' @export
#'
#' @examples
rru_tweet <- function(sheet_name) {

  # Get Tweets

  rru_tweets_sheet <- Sys.getenv("SHEET_PATH")

  # Get all tweets from sheet

  tweets <- read_sheet(rru_tweets_sheet,
                       sheet = sheet_name) %>%

    # Calculate length and only keep those below 280
    mutate(tweet_length = str_length(tweet_text)) %>%
    filter(tweet_length < 280) %>%
    mutate(date_posted = as.Date(date_posted))

  # Separate out tweets already posted
  tweets_already_posted <- tweets %>%
    filter(!is.na(date_posted))

  # Separate out tweets not yet posted
  tweets_not_yet_posted <- tweets %>%
    filter(is.na(date_posted)) %>%
    mutate(row_id = row_number())

  # Calculate the number of tweets not yet posted
  tweets_not_yet_posted_number <- tweets_not_yet_posted %>%
    nrow()

  # Generate random number to get random tweet
  tweet_to_post_row_id <- sample(1:tweets_not_yet_posted_number, 1)

  # Assign today to a random tweet
  tweets_not_yet_posted_with_one_to_tweet <- tweets_not_yet_posted %>%
    mutate(date_posted = case_when(
      row_id == tweet_to_post_row_id ~ today()
    ))

  # Pull out today's tweet
  tweet <- tweets_not_yet_posted_with_one_to_tweet %>%
    filter(!is.na(date_posted)) %>%
    mutate(tweet_text = str_glue("{tweet_text} #rstats\n{url}")) %>%
    pull(tweet_text)

  # Post Tweet

  post_tweet(status = tweet,
             token = twitter_token)

  # Combine everything back together

  all_tweets <- bind_rows(tweets_already_posted, tweets_not_yet_posted_with_one_to_tweet)

  # Put Tweets Back on Google Sheet

  all_tweets %>%
    select(tweet_text:retweets) %>%
    write_sheet(rru_tweets_sheet,
                sheet = sheet_name)

}
