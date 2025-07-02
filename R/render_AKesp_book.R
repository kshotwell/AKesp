
#' Shortcut to render the bookdown SOP - DEPRECATED
#'
#' This function renders the bookdown SOP from the files in the `book` folder.
#' @export

render_AKesp_book <- function() {
  # have to change working directory for bookdown
  setwd(here::here("book"))
  bookdown::render_book(input = ".",
                        config_file = "_bookdown.yml"
  )

  # change back to root project directory
  setwd(here::here())
}


