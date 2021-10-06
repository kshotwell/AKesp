#' Pull ESP data
#'
#' This function pulls ESP data on a specific stock from the AKFIN web service.
#' @param stock The name of the stock to pull data for. Use `AKesp::esp_stock_options()` to view current options.
#' @return A tibble
#' @importFrom magrittr %>%
#' @export

get_esp_data <- function(stock) {
  base_url <- "https://apex.psmfc.org/akfin/data_marts/akmp/esp_indicators?intended_esp="
  stock_url <- stock %>%
    stringr::str_replace_all(" ", "%20")

  url <- paste0(base_url, stock_url)

  data <- httr::content(httr::GET(url),
    type = "application/json"
  ) %>%
    dplyr::bind_rows()

  return(data)
}

# get_esp_data("Alaska Sablefish")

#' View AKFIN ESP stock options
#'
#' This function shows which stocks have data available on the AKFIN web service. It does not take any parameters.
#' @return A tibble
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @export

esp_stock_options <- function() {
  url <- "https://apex.psmfc.org/akfin/data_marts/akmp/esp_indicators?"
  data <- httr::content(httr::GET(url),
    type = "application/json"
  ) %>%
    dplyr::bind_rows() %>%
    dplyr::select("INTENDED_ESP") %>%
    dplyr::distinct() %>%
    dplyr::rename("Stocks" = "INTENDED_ESP") %>%
    dplyr::filter(.data$Stocks != "Multiple ESPs")

  return(data)
}

# esp_stock_options()
