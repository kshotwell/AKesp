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
