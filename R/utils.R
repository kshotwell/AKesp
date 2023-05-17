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
      .data$CATEGORY,
      .data$INDICATOR_ORDER
    ) %>%
    dplyr::distinct() %>%
    dplyr::filter(.data$INDICATOR_TYPE == indicator_type) %>%
    dplyr::arrange(INDICATOR_ORDER)

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

