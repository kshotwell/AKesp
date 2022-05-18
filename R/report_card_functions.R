
#' Create an indicator list
#'
#' This function creates an indicator list from the data.
#' @param data The indicator data
#' @param indicator_type One of `c("Ecosystem", "Socioeconomic")`
#' @export

list_indicators <- function(data, indicator_type) {
  dat <- data %>%
    dplyr::select(
      .data$INDICATOR_NAME,
      .data$REPORT_CARD_TITLE,
      .data$CONTACT,
      .data$STATUS_TRENDS,
      .data$INFLUENTIAL_FACTORS,
      .data$INDICATOR_TYPE,
      .data$CATEGORY
    ) %>%
    dplyr::distinct() %>%
    dplyr::filter(.data$INDICATOR_TYPE == indicator_type)

  num_index <- 1
  total_text <- NULL

  if (indicator_type == "Ecosystem") {
    cats <- c("Physical", "Lower Trophic", "Upper Trophic")
  } else if (indicator_type == "Socioeconomic") {
    cats <- c("Fishery Performance", "Economic", "Community")
  }

  for (j in cats) {
    text <- paste0(num_index, ".) ", j, " Indicators")

    total_text <- paste(total_text, text, sep = "\n\n")

    letter_index <- 1
    num_index <- num_index + 1

    dat1 <- dat %>%
      dplyr::filter(.data$CATEGORY == j)

    for (k in unique(dat1$REPORT_CARD_TITLE)) {
      dat2 <- dat1 %>%
        dplyr::select(
          .data$INDICATOR_NAME,
          .data$REPORT_CARD_TITLE,
          .data$CONTACT,
          .data$STATUS_TRENDS,
          .data$INFLUENTIAL_FACTORS
        ) %>%
        dplyr::distinct() %>%
        dplyr::filter(.data$REPORT_CARD_TITLE == k)

      text <- paste0(
        letters[letter_index], ".) ", dat2$INDICATOR_NAME, ": ", k,
        " (contact: ", dat2$CONTACT, ")",
        "\n\n", "Status and trends: ", dat2$STATUS_TRENDS,
        "\n\n", "Influential factors: ", dat2$INFLUENTIAL_FACTORS
      )

      total_text <- paste(total_text, text, sep = "\n\n")

      letter_index <- letter_index + 1
    }
  }
  return(total_text)
}


#' Create an ESP report card
#'
#' This function creates an ESP report card from a template. If left empty, an example report will be created.
#' @param ... Passed to `rmarkdown::render`. Set rmarkdown parameter values with `..., params = list(...), ...`. Available parameters and their defaults are specified below.
#' Available parameters and their defaults:
#' num: 1
#' authors: "Kalei Shotwell, Abby Tyrell"
#' year: 2021
#' contributors: "Kalei Shotwell, Abby Tyrell"
#' fish: "Myfish"
#' region: "Myarea"
#' stock_image: system.file('images/noaa.jpg', package = 'AKesp')
#' esp_data: AKesp::get_esp_data("Alaska Sablefish")
#' con_model_path: system.file("images/noaa.jpg", package = "AKesp")
#' bayes_path: system.file("images/noaa.jpg", package = "AKesp")
#' ncolumn: 1
#' min_year: NULL
#' @export

render_rpt_card <- function(...) {
  rmarkdown::render(
    system.file("esp-report-card-template.Rmd",
      package = "AKesp"
    ),
    ...
  )
}

# render_rpt_card(output_file = here::here("test.docx"),
#                 params = list(
#                   esp_data = dat,
#                 fish = "Sablefish",
#                 region = "Alaska",
#                 stock_image = here::here("inst/images/noaa.jpg"),
#                 con_model_path = here::here("inst/images/noaa.jpg"),
#                 bayes_path = here::here("inst/images/noaa.jpg")))
