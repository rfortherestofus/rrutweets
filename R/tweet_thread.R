#' Title
#'
#' @param tweet_content
#' @param tweet_media
#' @param tweet_number
#'
#' @return
#' @export
#'
#' @examples
tweet_thread <- function(tweet_content, tweet_media, tweet_number) {

  latest_tweet_id <- rtweet::search_tweets(q = "rfortherest",
                                           include_rts = FALSE) %>%
    dplyr::filter(screen_name == "rfortherest") %>%
    dplyr::slice(1) %>%
    dplyr::pull(status_id)

  if (tweet_number == 1) {

    # if (is.na(tweet_media)) {

      rtweet::post_tweet(status = tweet_content)

    # } else {

      # rtweet::post_tweet(status = tweet_content,
      #                    media = tweet_media)

    # }

  } else {

    # if (is.na(tweet_media)) {

      rtweet::post_tweet(status = tweet_content,
                         in_reply_to_status_id = latest_tweet_id)

    # } else {

      # rtweet::post_tweet(status = tweet_content,
      #                    media = tweet_media,
      #                    in_reply_to_status_id = latest_tweet_id)
    # }

  }

  Sys.sleep(30)

}



