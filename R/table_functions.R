#' Create indicator traffic light table - WIDE data
#'
#' This function creates an ESP indicator traffic light table
#' @param data The ESP indicator data. Should have a column for Year and a column for each indicator.
#' @param year The year(s) to use for the traffic light analysis. Either a single number or a numeric vector.
#' @param cap The table caption.
#' @return A flextable
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @export

esp_traffic_tab <- function(data, year, cap = "Traffic light scoring") {
  dat <- data %>%
    tidyr::pivot_longer(cols = colnames(data)[2:ncol(data)]) %>%
    dplyr::group_by(.data$name) %>%
    dplyr::mutate(
      name = .data$name %>%
        stringr::str_replace_all("_", " "),
      this_year = (.data$Year %in% year),
      avg = mean(.data$value,
        na.rm = TRUE
      ),
      stdev = stats::sd(.data$value,
        na.rm = TRUE
      )
    ) %>%
    dplyr::filter(.data$this_year == TRUE)

  status <- c()
  for (i in seq_len(nrow(dat))) {
    if (is.na(dat$value[i])) {
      status[i] <- "missing"
    } else if (dat$value[i] > (dat$avg[i] + dat$stdev[i])) {
      status[i] <- "high"
    } else if (dat$value[i] < (dat$avg[i] - dat$stdev[i])) {
      status[i] <- "low"
    } else {
      status[i] <- "neutral"
    }
  }

  dat$status <- status

  dat <- dat %>%
    dplyr::select(.data$name, .data$Year, .data$status) %>%
    tidyr::pivot_wider(
      id_cols = .data$name,
      names_from = .data$Year,
      values_from = .data$status
    ) %>%
    dplyr::rename(Indicator = .data$name)

  colnames(dat)[2:ncol(dat)] <- paste(colnames(dat)[2:ncol(dat)], "Status")

  ft <- flextable::flextable(dat) %>%
    flextable::theme_vanilla() %>%
    flextable::set_caption(caption = cap) %>%
    flextable::autofit() %>%
    flextable::align(align = "center", j = 2:ncol(dat))

  for (j in 2:ncol(dat)) {
    for (i in seq_len(nrow(dat))) {
      if (dat[i, j] == "missing") {
        ft <- flextable::bg(ft, i = i, j = j, bg = "beige")
      }
      if (dat[i, j] == "high") {
        ft <- flextable::bg(ft, i = i, j = j, bg = "red")
      }
      if (dat[i, j] == "neutral") {
        ft <- flextable::bg(ft, i = i, j = j, bg = "white")
      }
      if (dat[i, j] == "low") {
        ft <- flextable::bg(ft, i = i, j = j, bg = "gray")
      }
    }
  }

  return(ft)
}

# `%>%` <- magrittr::`%>%`
# esp_traffic_tab(AKesp::sablefish, year = 1977:2020)

#' Create indicator traffic light table - LONG data
#'
#' This function creates an ESP indicator traffic light table
#' @param data The ESP indicator data. Should have a column for Year and a column for each indicator.
#' @param year The year(s) to use for the traffic light analysis. Either a single number or a numeric vector.
#' @param cap The table caption.
#' @return A flextable
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @export

esp_traffic_tab_long <- function(data, year, cap = "Traffic light scoring") {
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
    ) %>%
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

  for (i in 1:nrow(color_dat)) {
    if (color_dat$status[i] == "low" & color_dat$SIGN[i] == -1) {
      color_dat$color[i] <- "cornflowerblue"
    }
    if (color_dat$status[i] == "high" & color_dat$SIGN[i] == 1) {
      color_dat$color[i] <- "cornflowerblue"
    }
    if (color_dat$status[i] == "high" & color_dat$SIGN[i] == -1) {
      color_dat$color[i] <- "brown1"
    }
    if (color_dat$status[i] == "low" & color_dat$SIGN[i] == 1) {
      color_dat$color[i] <- "brown1"
    }
  }
  color_dat <- color_dat %>%
    tidyr::pivot_wider(
      id_cols = .data$name,
      names_from = .data$YEAR,
      values_from = .data$color
    ) %>%
    dplyr::rename(Indicator = .data$name)

  colnames(tbl_dat)[2:ncol(tbl_dat)] <- paste(colnames(tbl_dat)[2:ncol(tbl_dat)], "Status")

  ft <- flextable::flextable(tbl_dat) %>%
    flextable::theme_vanilla() %>%
    flextable::set_caption(caption = cap) %>%
    flextable::autofit() %>%
    flextable::align(align = "center", j = 2:ncol(tbl_dat))

  for (j in 2:ncol(tbl_dat)) {
    for (i in seq_len(nrow(tbl_dat))) {
      ft <- flextable::bg(ft, i = i, j = j, bg = as.character(color_dat[i, j]))
    }
  }

  return(ft)
}

# `%>%` <- magrittr::`%>%`
# esp_traffic_tab_long(bbrkc_long, year = 2016:2020)
