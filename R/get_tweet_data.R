#' Get tweet data and post to Google Sheet
#'
#' @return Posts data on Google Sheet
#' @export
#'
#' @examples
get_tweet_data <- function() {

  authenticate_twitter()
  authenticate_googlesheets()

  tweets <- rtweet::search_tweets(q = "rfortherest",
                                  include_rts = FALSE,
                                  n = 1000,
                                  retryonratelimit = TRUE) %>%
    dplyr::filter(screen_name == "rfortherest") %>%
    dplyr::select(text, favorite_count, retweet_count) %>%
    purrr::set_names("tweet", "likes", "retweets") %>%
    dplyr::arrange(desc(retweets))

  rru_tweets_sheet <- Sys.getenv("SHEET_PATH")

  tweets %>%
    googlesheets4::write_sheet(rru_tweets_sheet,
                               sheet = "Tweet Performance")
}
