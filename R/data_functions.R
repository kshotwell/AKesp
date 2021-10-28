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
    dplyr::select(.data$INTENDED_ESP_NAME) %>%
    dplyr::distinct() %>%
    dplyr::rename("Stocks" = "INTENDED_ESP_NAME") %>%
    dplyr::filter(.data$Stocks != "Multiple ESPs")

  return(data)
}

# esp_stock_options()


#' Prep indicator data
#'
#' This function prepares indicator data. Adds SCORE column.
#' @param data The data (pulled from AKFIN)
#' @param recent Boolean. Whether to calculate the score only for the most recent year.
#' @param label_width Width of facet labels (number of characters). Defaults to 50.
#' @return A tibble
#' @export
#'

prep_ind_data <- function(data, recent = TRUE, label_width = 50) {
  maxyear <- max(data$YEAR)
  minyear <- maxyear - 1

  dat <- data %>%
    dplyr::filter(
      # is.na(.data$GATE2_YEAR),
      # is.na(.data$REMOVED_YEAR)
      .data$GATE2_YEAR == "NA",
      .data$REMOVED_YEAR == "NA"
    ) %>%
    dplyr::select(
      .data$INDICATOR_NAME, .data$CATEGORY, .data$INDICATOR_TYPE,
      .data$YEAR, .data$DATA_VALUE, .data$SIGN, .data$WEIGHT,
      .data$INTENDED_ESP_NAME, .data$REPORT_CARD_TITLE
    ) %>%
    dplyr::group_by(.data$INDICATOR_NAME) %>%
    dplyr::mutate(
      name = .data$INDICATOR_NAME %>%
        stringr::str_replace_all("_", " ") %>%
        stringr::str_wrap(width = label_width),
      quant10 = stats::quantile(.data$DATA_VALUE,
        probs = 0.1,
        na.rm = TRUE
      ),
      mean = mean(.data$DATA_VALUE,
        na.rm = TRUE
      ),
      sd = stats::sd(.data$DATA_VALUE,
        na.rm = TRUE
      ),
      quant90 = stats::quantile(.data$DATA_VALUE,
        probs = 0.9,
        na.rm = TRUE
      ),
      recent = (.data$YEAR == maxyear | .data$YEAR == minyear),
      label = ifelse(
        # if(recent){.data$YEAR == maxyear} else {
        is.na(.data$DATA_VALUE) == FALSE
        # }
        ,
        ifelse(.data$DATA_VALUE < (.data$mean + .data$sd),
          ifelse(.data$DATA_VALUE > (.data$mean - .data$sd),
            "neutral", "low"
          ),
          "high"
        ),
        NA
      ),
      label_num = ifelse(.data$label == "low", -1,
        ifelse(.data$label == "high", 1, 0)
      ),
      score = as.character(.data$label_num * .data$SIGN * .data$WEIGHT)
    ) %>%
    dplyr::ungroup()

  return(dat)
}

#' Join order information to ESP data
#'
#' This function joins order information to ESP data.
#' @param data The ESP data
#' @return A tibble
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @export

join_order <- function(data) {
  order_key <- AKesp::indicator_order %>%
    dplyr::select(.data$REPORT_CARD_TITLE, .data$Intended.ESP, .data$ORDER2) %>%
    dplyr::rename(INTENDED_ESP_NAME = .data$Intended.ESP)

  data <- data %>%
    dplyr::left_join(order_key,
      by = c("INTENDED_ESP_NAME", "REPORT_CARD_TITLE")
    ) %>%
    dplyr::arrange(.data$ORDER2)

  data$name <- factor(data$name, levels = unique(data$name))
  return(data)
}
