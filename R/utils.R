#' Recursively flatten a nested dataframe from Kobo.

#'
#' This function is for internal use in the package only.
#' It takes a nested dataframe and recursively flattens the
#' nested tables. It will ignore columns with names defined by the 'ignore'
#' parameter.
#'
#' @param x Dataframe to flatten
#' @param ignore Regular expression to match columsn to ignore
#' @export
#' @return A flattened dataframe


kobor_flatten <- function(x, ignore = "^_") {
  listcol <- names(x)[purrr::map_lgl(x, ~ purrr::is_list(.x)) &
                        !stringr::str_detect(names(x), ignore)]

  if(!is.null(listcol)){
    x <- tidyr::unnest(x, cols = listcol, keep_empty = TRUE)
  }

  if (any(purrr::map_lgl(x, ~ purrr::is_list(.x)) &
          !stringr::str_detect(names(x), ignore))) {
    kobor::kobor_flatten(x)
  } else {
    x
  }
}
