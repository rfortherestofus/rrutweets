#' Generate Twitter token
#'
#' @return A data frame twitter_token that can be used to authenticate with Twitter
#' @export
#'
#' @examples
authenticate_twitter <- function() {

twitter_token <<-
  rtweet::create_token(
    app = "rrutweets",
    consumer_key = Sys.getenv("TWITTER_API_KEY"),
    consumer_secret = Sys.getenv("TWITTER_SECRET_KEY"),
    access_token = Sys.getenv("TWITTER_ACCESS_TOKEN"),
    access_secret = Sys.getenv("TWITTER_SECRET_TOKEN")
  )

}


#' Authenticate in order to use Google Sheets
#'
#' @return
#' @export
#'
#' @examples
authenticate_googlesheets <- function() {
if (rlang::is_interactive() == TRUE) {

  googlesheets4::gs4_auth(
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
}
