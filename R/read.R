#' Read list of assets from Kobo toolbox
#'
#' Connects to Kobo toolbox and downloads details of all
#' assets (forms). The  uid's are useful as they provide
#' the idnetifier for downloading individual asset/form data.
#' Note: We strongly advise against storing your Kobo password in a script.
#'
#' @param username Your Kobo username
#' @param password Your Kobo password
#'
#' @return A dataframe of asset (form) details.
#'
#' @export

kobor_assets <- function(username, password) {
  httr::GET(
    "https://kf.kobotoolbox.org/api/v2/assets/",
    httr::authenticate(username, password),
    httr::progress()
  ) %>%
    httr::content("text", encoding = "UTF-8") %>%
    jsonlite::fromJSON() %>%
    purrr::pluck("results") %>%
    dplyr::select(-"summary", -"settings") %>%
    purrr::keep(~ class(.x) != "list")
}


#' Download an asset's (form) data from Kobo toolbox.
#'
#' Connects to Kobo toolbox and downloads data.
#' Needs the id of the asset (form). You can obtain this using kobo_assets()
#' It's the uid that you use to identify the form.
#' Note: We strongly advise against storing your Kobo password in a script.
#'
#' @param asset The id for the data you wish to download
#' @param username Your Kobo username
#' @param password Your Kobo password
#'
#' @return The downloaded data in flattened format.
#'
#' @export

kobor_read <- function(asset, username, password) {
  url <- paste0(
    "https://kf.kobotoolbox.org/api/v2/assets/",
    asset,
    "/data/?format=json"
  )

  # get data and process...
  httr::GET(
    url,
    httr::authenticate(username, password),
    httr::progress()
  ) %>%
    httr::content("text", encoding = "UTF-8") %>%
    jsonlite::fromJSON() %>%
    purrr::pluck("results") %>%
    kobor_flatten() %>%
    kobor_flatten() %>%
    purrr::keep(~ !purrr::is_list(.x))
}
