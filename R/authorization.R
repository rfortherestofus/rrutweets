# Source: https://github.com/JosiahParry/rsc-gsheets

#' Authorize Google Sheets
#'
#' @return
#' @export
#'
#' @examples
auth_googlesheets <- function()  {
  # designate project-specific cache
  options(gargle_oauth_cache = ".secrets")

  # check the value of the option, if you like
  # gargle::gargle_oauth_cache()

  googlesheets4::gs4_auth()

  # see your token file in the cache, if you like
  # list.files(".secrets/")

  # deauth
  googlesheets4::gs4_deauth()

  # sheets reauth with specified token and email address
  googlesheets4::gs4_auth(
    cache = ".secrets",
    email = "david@rfortherestofus.com"
  )
}
