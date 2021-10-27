
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
  data$CATEGORY <- factor(data$CATEGORY, c(
    "Physical", "Lower Trophic",
    "Upper Trophic", "Fishery Performance",
    "Economic", "Community"
  ))

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
    dplyr::select(
      .data$CATEGORY, .data$YEAR, .data$name, .data$DATA_VALUE,
      .data$avg, .data$stdev, .data$SIGN, .data$INDICATOR_TYPE,
      .data$INTENDED_ESP_NAME, .data$REPORT_CARD_TITLE
    ) %>%
    dplyr::ungroup()

  dat <- join_order(dat)

  status <- c()
  color <- c()

  # assign status and color based on SIGN
  # color of cell = SIGN
  # words in cell = status
  for (i in seq_len(nrow(dat))) {
    if (is.na(dat$DATA_VALUE[i])) {
      status[i] <- "NA"
      color[i] <- "gray80"

      # colors by sign/value combo
    } else if (dat$DATA_VALUE[i] > (dat$avg[i] + dat$stdev[i])) {
        status[i] <- "high"
        if (is.na(dat$SIGN[i])) {
          color[i] <- "white"
        } else if (dat$SIGN[i] == 1) {
          color[i] <- "cornflowerblue"
        } else if (dat$SIGN[i] == -1) {
          color[i] <- "brown1"
        }
      } else if (dat$DATA_VALUE[i] < (dat$avg[i] - dat$stdev[i])) {
        status[i] <- "low"
        if (is.na(dat$SIGN[i])) {
          color[i] <- "white"
        } else if (dat$SIGN[i] == -1) {
          color[i] <- "cornflowerblue"
        } else if (dat$SIGN[i] == 1) {
          color[i] <- "brown1"
        }
      } else {
        status[i] <- "neutral"
        color[i] <- "white"
      }
    }

  dat$status <- status
  dat$color <- color

  tbl_dat <- dat %>%
    dplyr::select(.data$CATEGORY, .data$name, .data$YEAR, .data$status) %>%
    tidyr::pivot_wider(
      id_cols = c(.data$CATEGORY, .data$name),
      names_from = .data$YEAR,
      values_from = .data$status,
      names_sort = TRUE
    ) %>%
    dplyr::rename(
      Indicator = .data$name,
      "Indicator category" = .data$CATEGORY
    )

  color_dat <- dat %>%
    dplyr::select(
      .data$CATEGORY, .data$name, .data$YEAR, .data$status,
      .data$SIGN, .data$color
    )

  color_dat <- color_dat %>%
    tidyr::pivot_wider(
      id_cols = c(.data$CATEGORY, .data$name),
      names_from = .data$YEAR,
      values_from = .data$color,
      values_fill = "grey80",
      names_sort = TRUE
    ) %>%
    dplyr::rename(Indicator = .data$name)

  colnames(tbl_dat)[3:ncol(tbl_dat)] <- paste(
    colnames(tbl_dat)[3:ncol(tbl_dat)], "Status"
  )

  flextable::set_flextable_defaults(na_str = "NA")

  ft <- flextable::flextable(tbl_dat) %>%
    flextable::theme_vanilla() %>%
    flextable::set_caption(caption = cap) %>%
    flextable::autofit() %>%
    flextable::align(
      align = "center",
      j = 3:ncol(tbl_dat)
    )

  for (j in 3:ncol(tbl_dat)) {
    for (i in seq_len(nrow(tbl_dat))) {
      ft <- flextable::bg(ft,
        i = i,
        j = j,
        bg = as.character(color_dat[i, j])
      )
    }
  }

  for(i in 1:nrow(tbl_dat)) {
    for(j in 1:ncol(tbl_dat)) {
      if(color_dat[i,j] == "brown1") {
        ft <- flextable::bold(ft, i = i, j = j)
      }
      if(color_dat[i,j] == "cornflowerblue") {
        ft <- flextable::italic(ft, i = i, j = j)
      }
    }
  }

  ft <- ft %>%
    flextable::merge_v(j = 1)

  return(ft)
}

# `%>%` <- magrittr::`%>%`
# esp_traffic_tab_long(bbrkc_long, year = 2016:2020)
