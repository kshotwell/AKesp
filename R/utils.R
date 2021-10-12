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
                         tag_pool = letters,
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

#' Label indicator status on ggplot
#'
#' This function labels a ggplot with recent indicator status. Modified from `egg::tag_facet()`
#' @param p A faceted ggplot.
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

label_status <- function(p,
                         tag_pool = letters,
                         x = -Inf,
                         y = Inf,
                         hjust = -30,
                         vjust = 1.5,
                         fontface = 2,
                         family = "",
                         ...) {
  gb <- ggplot2::ggplot_build(p)
  lay <- gb$layout$layout

  names <- lay$names

  color <- c(rep("yes", 6), rep("no", 7))

  tags <- cbind(lay,
                label = color,
                x = x,
                y = y,
                color = color
  )

  p + ggplot2::geom_text(
    data = tags,
    ggplot2::aes_string(
      x = "x",
      y = "y",
      label = "label",
      color = "color"
    ),
    ...,
    hjust = hjust,
    vjust = vjust,
    fontface = fontface,
    family = family,
    inherit.aes = FALSE
  )
}

