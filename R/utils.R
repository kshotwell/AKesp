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

  select_cols <- c("INDICATOR_NAME", "REPORT_CARD_TITLE", "CONTACT",
                   "STATUS_TRENDS", "FACTORS", "IMPLICATIONS",
                   "INDICATOR_TYPE", "CATEGORY", "INDICATOR_ORDER")

  dat <- data %>%
    dplyr::select(
      dplyr::any_of(select_cols)
    ) %>%
    dplyr::distinct() %>%
    dplyr::filter(.data$INDICATOR_TYPE == indicator_type) %>%
    dplyr::arrange(INDICATOR_ORDER)

  # add NA if col not present
  # there is a better way to do this with `apply` or a function
  if(!"STATUS_TRENDS" %in% colnames(dat)) {
    dat$STATUS_TRENDS <- NA
  }
  if(!"FACTORS" %in% colnames(dat)) {
    dat$FACTORS <- NA
  }

  num_index <- 1
  total_text <- NULL

  if (indicator_type == "Ecosystem") {
    if("Physical" %in% unique(dat$CATEGORY)){
      cats <- c("Physical", "Lower Trophic", "Upper Trophic")
    } else {
      cats <- c("Larval", "Juvenile", "Adult")
    }
  } else if (indicator_type == "Socioeconomic") {
    cats <- c("Fishery Performance", "Economic", "Community")
  }

  for (j in cats) {
    text <- paste0("#### ", num_index, ". ", j, " Indicators  {-}")

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
          .data$FACTORS,
          .data$IMPLICATIONS
        ) %>%
        dplyr::distinct() %>%
        dplyr::filter(.data$REPORT_CARD_TITLE == k) %>%
        dplyr::mutate_all(~dplyr::case_when(is.na(.x) | .x == " " | .x == "NA" | .x == "" ~ "**Information not present in database**",
                                       TRUE ~ .x))

      text <- paste0(
        "\n\n",
        letters[letter_index], ". ", dat2$INDICATOR_NAME, ": ", k,
        "\n", "    + Contact: ", dat2$CONTACT,
        "\n", "    + Status and trends: ", dat2$STATUS_TRENDS,
        "\n", "    + Factors influencing trends: ", dat2$FACTORS,
        "\n", "    + Implications: ", dat2$IMPLICATIONS,
        "\n"
      )

      total_text <- paste(total_text, text, sep = "\n\n")

      letter_index <- letter_index + 1
    }
  }
  return(total_text)
}

