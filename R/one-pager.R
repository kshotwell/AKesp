#' Create ESP one-pager
#'
#' This function creates a one-pager summary of ESP data.
#' @param data The data you want displayed in traffic light figures/table (pulled from AKFIN)
#' @param overall_data The data to use in creating the overall score figure
#' @param years The years to display in the traffic light table
#' @param head_text The text to display at the top of the one-pager
#' @param foot_text The text to display at the bottom of the one-pager
#' @param bayes_path The file path to the Bayesian Adaptive Sampling figure (must be a png)
#' @param header_path The file path to the image to use as the header (must be a png)
#' @param output_name The file name of the output. Include the file extension (can be any file extension that is compatible with `ggsave`)
#' @return A saved one-pager file
#' @export
#'

one_pager <- function(data,
                      overall_data,
                      years = 2017:2021,
                      head_text = "some text",
                      foot_text = "more text",
                      bayes_path = here::here("bayes.png"),
                      header_path = here::here("header.png"),
                      output_name = "one-pager.pdf") {
  # indicator figure
  fig <- AKesp::esp_traffic_long(
    data = data,
    paginate = FALSE,
    out = "one_pager",
    silent = TRUE,
    ncolumn = 2,
    label = FALSE,
    status = FALSE
  )

  # score figure
  score_fig <- AKesp::esp_overall_score(
    data = overall_data,
    species = "",
    region = "",
    out = "one_pager"
  ) +
    ggplot2::ggtitle("Overall score")

  # make a table
  tab <- AKesp::esp_traffic_tab_long(data,
    year = years,
    cap = ""
  ) %>%
    flextable::fit_to_width(max_width = 8)

  ggtab <- ggplot2::ggplot() +
    ggplot2::theme_void() +
    ggplot2::annotation_custom(grid::rasterGrob(flextable::as_raster(tab)),
      xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf
    )

  # bayes
  bay <- png::readPNG(bayes_path)

  bayes <- ggplot2::ggplot() +
    ggplot2::theme_void() +
    ggplot2::theme(aspect.ratio = 1) +
    ggpubr::background_image(bay)

  # right hand figures - score and bayes
  right_figs <- ggpubr::ggarrange(
    score_fig +
      ggplot2::theme_bw(base_size = 10) +
      ggplot2::theme(
        legend.position = "bottom",
        legend.title = ggplot2::element_blank(),
        legend.margin = ggplot2::margin(),
        legend.box.margin = ggplot2::margin(),
        legend.box.spacing = grid::unit(1, "points"),
        legend.text = ggplot2::element_text(margin = ggplot2::margin()),
        plot.title =
          ggplot2::element_text(hjust = 0.5)
      ),
    bayes +
      ggplot2::ggtitle("Importance") +
      ggplot2::theme(
        plot.title =
          ggplot2::element_text(hjust = 0.5)
      ),
    nrow = 2
  )

  # all figs
  figs <- ggpubr::ggarrange(fig +
    ggplot2::ggtitle("Indicators") +
    ggplot2::theme_bw(base_size = 10) +
    ggplot2::theme(
      plot.title =
        ggplot2::element_text(hjust = 0.5)
    ),
  right_figs,
  ncol = 2,
  widths = c(2, 1)
  )

  # header
  head <- png::readPNG(header_path)

  header <- ggplot2::ggplot() +
    ggplot2::theme_void() +
    ggplot2::theme(aspect.ratio = 1 / 4) +
    ggpubr::background_image(head)

  # text header
  h_txt <- ggplot2::ggplot() +
    ggplot2::theme_void() +
    ggplot2::annotate("text", x = 1, y = 1, label = head_text)

  # text summary
  txt <- ggplot2::ggplot() +
    ggplot2::theme_void() +
    ggplot2::annotate("text", x = 1, y = 1, label = foot_text)

  # put it all together
  summary_pg <- ggpubr::ggarrange(header,
    h_txt,
    figs,
    ggtab +
      ggplot2::ggtitle("Traffic light table") +
      ggplot2::theme(
        plot.title =
          ggplot2::element_text(hjust = 0.5)
      ),
    txt,
    nrow = 5,
    heights = c(2, 0.5, 5.5, 2.5, 0.5)
  )
  ggplot2::ggsave(output_name,
    width = 8.5,
    height = 11
  )
}

# one_pager(data = dat2, overall_data = dat)
