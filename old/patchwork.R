# with patchwork ----
library(patchwork)

# `%>%` <- magrittr::`%>%`
#
# dat <- AKesp::get_esp_data("Alaska Sablefish")
# dat2 <- dat %>%
#   dplyr::filter(CATEGORY == "Upper Trophic")

one_pager_p <- function(data = dat2,
                        overall_data = dat,
                        years = 2017:2021,
                        head_text = "some text",
                        foot_text = "more text",
                        bayes_path = here::here("bayes.png"),
                        header_path = here::here("header.png"),
                        output_name = "one-pager-patchwork.pdf") {

  # indicator figure ----
  fig <- AKesp::esp_traffic_long(
    data = data,
    paginate = FALSE,
    out = "one_pager",
    silent = TRUE,
    ncolumn = 2,
    label = FALSE,
    status = FALSE
  ) +
    ggplot2::theme(
      axis.text = ggplot2::element_text(size = 8),
      strip.text = ggplot2::element_text(size = 8)
    ) +
    ggplot2::xlab(ggplot2::element_blank())

  # score figure ----
  score_fig <- AKesp::esp_overall_score(
    data = overall_data,
    species = "",
    region = "",
    out = "one_pager"
  ) +
    ggplot2::ggtitle(ggplot2::element_blank()) +
    ggplot2::theme(
      text = ggplot2::element_text(size = 8),
      plot.title = ggplot2::element_text(size = 8),

      plot.margin = grid::unit(c(0, 0, 0, 0), units = "points"),

      legend.box.margin = ggplot2::margin(0, 0, 0, 0, unit = "pt"),
      legend.box.spacing = grid::unit(c(0, 0, 0, 0), units = "points"),

      legend.spacing = grid::unit(c(0, 0, 0, 0), units = "points"),
      legend.margin = ggplot2::margin(0, 0, 0, 0, unit = "pt"),
      legend.text =
        ggplot2::element_text(
          margin =
            ggplot2::margin(0, 0, 0, 0, unit = "pt")
        ),
      legend.key.height = grid::unit(c(8, 8, 8, 8), units = "points")
    ) +
    ggplot2::ylab("Overall score")

  # make a table ----
  tab <- AKesp::esp_traffic_tab_long(data,
                                     year = years,
                                     cap = ""
  ) %>%
    flextable::fit_to_width(max_width = 8)

  ggtab <- ggplot2::ggplot() +
    ggplot2::theme_void() +
    ggplot2::annotation_custom(grid::rasterGrob(flextable::as_raster(tab)),
                               xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf
    ) +
    ggplot2::ggtitle("Traffic light table") +
    ggplot2::theme(
      plot.title =
        ggplot2::element_text(hjust = 0.5)
    )

  # bayes ----
  bay <- png::readPNG(bayes_path)

  bayes <- ggplot2::ggplot() +
    ggplot2::theme_void() +
    ggplot2::theme(aspect.ratio = 1) +
    ggpubr::background_image(bay) +
    ggplot2::ggtitle("Importance") +
    ggplot2::theme(
      plot.title =
        ggplot2::element_text(hjust = 0.5)
    )

  # header ----
  head <- png::readPNG(header_path)

  header <- ggplot2::ggplot() +
    ggplot2::theme_void() +
    #  ggplot2::theme(aspect.ratio = 1 / 4) +
    ggpubr::background_image(head)

  # put it all together
  summary_pg <-
    (header /
       grid::textGrob(head_text) /
       (
         (fig |
            (
              (score_fig / bayes) + plot_layout(heights = c(3, 5))
            )) + plot_layout(
              widths = c(2, 1),
              heights = c(1, 1),
              guides = "keep"
            )
       ) /
       ggtab /
       grid::textGrob(foot_text)) +
    plot_layout(heights = c(2, 0.5, 5.5, 2.5, 0.5))

  ggplot2::ggsave(output_name,
                  width = 8.5,
                  height = 11
  )
}

# one_pager_p()

# seems like legend isn't accounted for in relative widths...
# don't know why there is so much empty vertical space around the overall score plot
