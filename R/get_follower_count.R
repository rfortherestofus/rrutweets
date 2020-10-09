#
# authenticate_twitter()
#
# rtweet::get_followers(user = "rfortherest",
#                       n = 1000)
#
# rtweet::get_mentions()
#
# %>%
#   nrow() %>%
#   tibble::tibble() %>%
#   purrr::set_names("followers") %>%
#   dplyr::mutate(date = lubridate::today)
#
# rtweet::post_tweet(status = "test")
