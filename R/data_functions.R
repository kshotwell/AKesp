#' Pull ESP data
#'
#' This function pulls ESP data on a specific stock from the AKFIN web service.
#' @param stock The name of the stock to pull data for. Use `AKesp::esp_stock_options()` to view current options. Leave as NULL to get all data.
#' @return A tibble
#' @importFrom magrittr %>%
#' @export

get_esp_data <- function(stock = NULL) {
  base_url <- "https://apex.psmfc.org/akfin/data_marts/akmp/esp_indicators?"

  url <- ifelse(is.null(stock),
                base_url,
                paste0(base_url,
                       "intended_esp=",
                       stock %>%
                         stringr::str_replace_all(" ", "%20")))

  data <- httr::content(httr::GET(url),
    type = "application/json"
  ) %>%
    dplyr::bind_rows()

  # temporary fix that should be updated???
  data <- data %>%
    dplyr::rename(DATA_VALUE = INDICATOR_VALUE)

  return(data)
}

#get_esp_data("GOA Pollock")

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
      (.data$GATE2_YEAR == "NA" | is.na(.data$GATE2_YEAR)),
      (.data$REMOVED_YEAR == "NA" | is.na(.data$REMOVED_YEAR))
    ) %>%
    # dplyr::select(
    #   .data$INDICATOR_NAME, .data$CATEGORY, .data$INDICATOR_TYPE,
    #   .data$YEAR, .data$DATA_VALUE, .data$SIGN, .data$WEIGHT,
    #   .data$INTENDED_ESP_NAME, .data$REPORT_CARD_TITLE, .data$UNITS,
    #   .data$INDICATOR_ORDER
    # ) %>%
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

#' Check ESP data columns
#'
#' This function checks that the ESP data has the expected columns.
#' If any columns are missing, they are filled with NAs.
#' @param data The ESP data
#' @param fill Whether to add missing columns and fill with NAs
#' @return A tibble
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @export

check_data <- function(data, fill = TRUE) {
  expected_colnames <- c("YEAR", "INDICATOR_NAME", "DATA_VALUE",
                         "DATA_SOURCE_NAME", "DATABASE_NAME", "PRODUCT",
                         "PRODUCT_DESCRIPTION", "INDICATOR_TYPE", "CATEGORY",
                         "CONTACT", "FREQUENCY", "REGION", "TIME_START",
                         "TIME_END", "AKFIN", "ESR", "REFERENCE", "PRELIMINARY",
                         "REPORT_CARD_TITLE", "INTENDED_ESP_NAME",
                         "SUBMISSION_YEAR", "GATE1_YEAR", "GATE2_YEAR",
                         "REMOVED_YEAR", "SIGN", "WEIGHT", "STATUS_TRENDS",
                         "INFLUENTIAL_FACTORS", "UNITS", "INDICATOR_ORDER")

  data_colnames <- colnames(data)

  match <- length(expected_colnames) == length(data_colnames) &
    (sum(sort(expected_colnames) == sort(data_colnames)) == length(expected_colnames))

  if(match){
    message("all expected columns present in data")
  } else if(fill) {
    missing_cols <- expected_colnames[which(! expected_colnames %in% data_colnames)]
    for(i in missing_cols) {
      data[,i] <- NA
      message("missing columns -- filled with NAs")
    }
  } else {
    message("missing columns -- not filling!")
  }
return(data)
}

# dat2 <- check_data(dat)
