`%>%` <- magrittr::`%>%`

# query data
dat <- AKesp::get_esp_data("Alaska Sablefish")
head(dat)

dat2 <- dat %>%
  dplyr::filter(CATEGORY == "Upper Trophic")

# indicator figure
fig <- AKesp::esp_traffic_long(
  data = dat2,
  paginate = FALSE,
  out = "one_pager",
  silent = TRUE,
  ncolumn = 2,
  label = FALSE,
  status = FALSE
)

# score figure
score_fig <- AKesp::esp_overall_score(data = dat,
                                      species = "Sablefish",
                                      region = "Alaska",
                                      out = "one_pager") +
  ggplot2::ggtitle("Overall score")

# make a table
tab <- AKesp::esp_traffic_tab_long(dat2,
                                   year = 2017:2021,
                                   cap = "")

ggtab <- ggplot2::ggplot() +
  ggplot2::theme_void() +
  ggplot2::annotation_custom(grid::rasterGrob(flextable::as_raster(tab)),
                             xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=Inf)

# bayes
bay <- png::readPNG(here::here("bayes.png"),
                     native = FALSE)

bayes <- ggplot2::ggplot() +
  ggplot2::theme_void() +
  ggplot2::theme(aspect.ratio = 1) +
  ggpubr::background_image(bay)

# right hand figures - score and bayes
right_figs <- ggpubr::ggarrange(
                          score_fig +
                            ggplot2::theme_bw(base_size = 10) +
                            ggplot2::theme(legend.position = "bottom",
                                           legend.title = ggplot2::element_blank(),
                                           legend.margin = ggplot2::margin(),
                                           legend.box.margin = ggplot2::margin(),
                                           legend.box.spacing = grid::unit(0, "cm"),
                                           legend.text = ggplot2::element_text(margin = ggplot2::margin()),
                                           plot.title =
                                             ggplot2::element_text(hjust = 0.5)),
                          bayes +
                            ggplot2::ggtitle("Importance") +
                            ggplot2::theme(plot.title =
                                             ggplot2::element_text(hjust = 0.5)),
                          nrow = 2)

# all figs
figs <- ggpubr::ggarrange(fig +
                            ggplot2::ggtitle("Indicators") +
                            ggplot2::theme_bw(base_size = 10) +
                            ggplot2::theme(plot.title =
                                             ggplot2::element_text(hjust = 0.5)),
                          right_figs,
                          ncol = 2,
                          widths = c(2, 1))

# header
head <- png::readPNG(here::here("header.png"),
                     native = FALSE)

header <- ggplot2::ggplot() +
  ggplot2::theme_void() +
  ggplot2::theme(aspect.ratio = 1/4) +
  ggpubr::background_image(head)

# text header
h_txt <- ggplot2::ggplot() +
  ggplot2::theme_void() +
  ggplot2::annotate("text", x = 1, y = 1, label = "some text here")

# text summary
txt <- ggplot2::ggplot() +
  ggplot2::theme_void() +
  ggplot2::annotate("text", x = 1, y = 1, label = "more text here")

# put it all together
summary_pg <- ggpubr::ggarrange(header,
                                h_txt,
                                figs,
                                ggtab +
                                  ggplot2::ggtitle("Traffic light table") +
                                  ggplot2::theme(plot.title =
                                                   ggplot2::element_text(hjust = 0.5)),
                                txt,
                                nrow = 5,
                                heights = c(2, 0.5, 5.5, 2.5, 0.5))
ggplot2::ggsave("test.png",
                width = 8.5,
                height = 11)
summary_pg

one_pager <- function(data,
                      overall_data,
                      years = 2017:2021,
                      head_text = "some text",
                      foot_text = "more text",
                      bayes_path = here::here("bayes.png"),
                      header_path = here::here("header.png")
) {
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
  score_fig <- AKesp::esp_overall_score(data = overall_data,
                                        species = "",
                                        region = "",
                                        out = "one_pager") +
    ggplot2::ggtitle("Overall score")

  # make a table
  tab <- AKesp::esp_traffic_tab_long(data,
                                     year = years,
                                     cap = "")

  ggtab <- ggplot2::ggplot() +
    ggplot2::theme_void() +
    ggplot2::annotation_custom(grid::rasterGrob(flextable::as_raster(tab)),
                               xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=Inf)

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
      ggplot2::theme(legend.position = "bottom",
                     legend.title = ggplot2::element_blank(),
                     legend.margin = ggplot2::margin(),
                     legend.box.margin = ggplot2::margin(),
                     legend.box.spacing = grid::unit(1, "points"),
                     legend.text = ggplot2::element_text(margin = ggplot2::margin()),
                     plot.title =
                       ggplot2::element_text(hjust = 0.5)),
    bayes +
      ggplot2::ggtitle("Importance") +
      ggplot2::theme(plot.title =
                       ggplot2::element_text(hjust = 0.5)),
    nrow = 2)

  # all figs
  figs <- ggpubr::ggarrange(fig +
                              ggplot2::ggtitle("Indicators") +
                              ggplot2::theme_bw(base_size = 10) +
                              ggplot2::theme(plot.title =
                                               ggplot2::element_text(hjust = 0.5)),
                            right_figs,
                            ncol = 2,
                            widths = c(2, 1))

  # header
  head <- png::readPNG(header_path)

  header <- ggplot2::ggplot() +
    ggplot2::theme_void() +
    ggplot2::theme(aspect.ratio = 1/4) +
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
                                    ggplot2::theme(plot.title =
                                                     ggplot2::element_text(hjust = 0.5)),
                                  txt,
                                  nrow = 5,
                                  heights = c(2, 0.5, 5.5, 2.5, 0.5))
  ggplot2::ggsave("test.pdf",
                  width = 8.5,
                  height = 11)
}

one_pager(data = dat2, overall_data = dat)
