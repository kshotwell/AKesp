#' Label ggplot facets
#'
#' This function labels gggplot facets with letters. Modified from `egg::tag_facet()`
#' @param p A faceted ggplot.
#' @param open Opening character
#' @param close Closing character
#' @param tag_pool Character vector of labels
#' @param x x position within panel
#' @param y y position within panel
#' @param hjust hjust
#' @param vjust vjust
#' @param fontface fontface
#' @param family font family
#' @param ... passed to `ggplot2::geom_text`
#' @return A ggplot
#' @export

label_facets <- function(p,
                         open = "(",
                         close = ")",
                         tag_pool = c(letters, paste0(letters, letters)),
                         x = -Inf,
                         y = Inf,
                         hjust = -0.5,
                         vjust = 1.5,
                         fontface = 2,
                         family = "",
                         ...) {
  gb <- ggplot2::ggplot_build(p)
  lay <- gb$layout$layout
  tags <- cbind(lay,
    label = paste0(
      open,
      tag_pool[lay$PANEL],
      close
    ),
    x = x,
    y = y
  )

  p + ggplot2::geom_text(
    data = tags,
    ggplot2::aes_string(
      x = "x",
      y = "y",
      label = "label"
    ),
    ...,
    hjust = hjust,
    vjust = vjust,
    fontface = fontface,
    family = family,
    inherit.aes = FALSE
  )
}

#' Prep indicator data
#'
#' This function prepares indicator data. Adds SCORE column.
#' @param data The data (pulled from AKFIN)
#' @param recent Boolean. Whether to calculate the score only for the most recent year.
#' @return A tibble
#' @export
#'

prep_ind_data <- function(data, recent = TRUE, label_width = 50) {
  maxyear <- max(data$YEAR)
  minyear <- maxyear - 1

  dat <- data %>%
    dplyr::filter(!is.na(.data$GATE2_YEAR),
                  !is.na(.data$REMOVED_YEAR)) %>%
    dplyr::select(
      INDICATOR_NAME, CATEGORY, INDICATOR_TYPE,
      YEAR, DATA_VALUE, SIGN, WEIGHT
    ) %>%
    dplyr::group_by(INDICATOR_NAME) %>%
    dplyr::mutate(
      name = INDICATOR_NAME %>%
        stringr::str_replace_all("_", " ") %>%
        stringr::str_wrap(width = label_width),
      quant10 = stats::quantile(.data$DATA_VALUE,
        probs = 0.1,
        na.rm = TRUE
      ),
      mean = mean(.data$DATA_VALUE,
        na.rm = TRUE
      ),
      sd = sd(.data$DATA_VALUE,
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
