#' Create indicator traffic light table - LONG data
#'
#' This function creates an ESP indicator traffic light table
#' @param data The ESP indicator data (long form)
#' @param year The year(s) to use for the traffic light analysis. Either a single number or a numeric vector.
#' @return A flextable
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @export

esp_traffic_tab_long <- function(data, year) {
  dat <- data %>%
    dplyr::group_by(.data$INDICATOR_NAME) %>%
    dplyr::mutate(
      name = .data$INDICATOR_NAME %>%
        stringr::str_replace_all("_", " "),
      this_year = (.data$YEAR %in% year),
      avg = mean(.data$DATA_VALUE,
                 na.rm = TRUE
      ),
      stdev = stats::sd(.data$DATA_VALUE,
                        na.rm = TRUE
      )
    )  %>%
    dplyr::filter(.data$this_year == TRUE) %>%
    dplyr::select(.data$YEAR, .data$name, .data$DATA_VALUE, .data$avg, .data$stdev, .data$SIGN, .data$SCORE)

  status <- c()
  color <- c()

  for (i in seq_len(nrow(dat))) {
    if (is.na(dat$DATA_VALUE[i])) {
      status[i] <- "missing"
      color[i] <- "gray80"
    } else if (dat$DATA_VALUE[i] > (dat$avg[i] + dat$stdev[i])) {
      status[i] <- "high"
      color[i] <- NA
    } else if (dat$DATA_VALUE[i] < (dat$avg[i] - dat$stdev[i])) {
      status[i] <- "low"
      color[i] <- NA
    } else {
      status[i] <- "neutral"
      color[i] <- "white"
    }
  }

  dat$status <- status
  dat$color <- color

  # color of cell = SIGN
  # words in cell = status

  tbl_dat <- dat %>%
    dplyr::select(.data$name, .data$YEAR, .data$status) %>%
    tidyr::pivot_wider(
      id_cols = .data$name,
      names_from = .data$YEAR,
      values_from = .data$status
    ) %>%
    dplyr::rename(Indicator = .data$name)

  color_dat <- dat %>%
    dplyr::select(.data$name, .data$YEAR, .data$status, .data$SIGN, .data$color)

  for(i in 1:nrow(color_dat)){
    if(color_dat$status[i] == "low" & color_dat$SIGN[i] == -1) {
      color_dat$color[i] <- "cornflowerblue"
    }
    if(color_dat$status[i] == "high" & color_dat$SIGN[i] == 1) {
      color_dat$color[i] <- "cornflowerblue"
    }
    if(color_dat$status[i] == "high" & color_dat$SIGN[i] == -1) {
      color_dat$color[i] <- "brown1"
    }
    if(color_dat$status[i] == "low" & color_dat$SIGN[i] == 1) {
      color_dat$color[i] <- "brown1"
    }
  }

  color_dat <- color_dat %>% tidyr::pivot_wider(
    id_cols = .data$name,
    names_from = .data$YEAR,
    values_from = .data$color
  ) %>%
    dplyr::rename(Indicator = .data$name)

  colnames(tbl_dat)[2:ncol(tbl_dat)] <- paste(colnames(tbl_dat)[2:ncol(tbl_dat)], "Status")

  ft <- flextable::flextable(tbl_dat) %>%
    flextable::theme_vanilla() %>%
    flextable::set_caption(caption = "Traffic light scoring") %>%
    flextable::autofit() %>%
    flextable::align(align = "center", j = 2:ncol(tbl_dat)) %>%
    flextable::bg(bg = "white")

  for (j in 2:ncol(tbl_dat)) {
    for (i in seq_len(nrow(tbl_dat))) {
      ft <-flextable::bg(ft, i = i, j = j, bg = as.character(color_dat[i,j]))
    }
  }

  return(ft)
}

`%>%` <- magrittr::`%>%`
# bbrkc_long = the long form indicator spreadsheet
tab <- esp_traffic_tab_long(bbrkc_long, year = 2016:2020)
tab

flextable::save_as_image(tab, path = "crab-table.png")
