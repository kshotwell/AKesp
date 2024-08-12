#' Create ESP one-pager
#'
#' This function creates a one-pager summary of ESP data.
#' @param timeseries_indicators The names of the indicators you want to show in time series
#' @param overall_data The data to use in creating the overall score figure
#' @param key_text The key takeaways (.txt file)
#' @param foot_text The text to display at the bottom of the one-pager
#' @param concept_path The file path to the conceptual model figure (must be a png)
#' @param header_path The file path to the image to use as the header (must be a png)
#' @param output_name The file name of the output. Include the file extension (can be any file extension that is compatible with `ggsave`)
#' @return A saved one-pager file
#' @export
#'

one_pager2 <- function(timeseries_indicators,
                      overall_data,
                      key_text = system.file("txt_default", package = "AKesp"),
                      foot_text = "Links to AKFIN and other stuff, disclaimers, contact info",
                      concept_path = system.file("images/bayes.png", package = "AKesp"),
                      header_path = system.file("images/header.png", package = "AKesp"),
                      output_name = "one-pager.pdf") {
  # indicator figure ----
  fig <- overall_data %>%
    dplyr::filter(INDICATOR_NAME %in% timeseries_indicators) %>%
    AKesp::esp_traffic(
    paginate = FALSE,
    out = "one_pager",
    silent = TRUE,
    ncolumn = 1,
    label = FALSE,
    status = FALSE,
    f_units = TRUE,
    y_units = FALSE
  ) +
    ggplot2::ggtitle("Indicators") +
    ggplot2::theme_bw(base_size = 8) +
    ggplot2::theme(
      plot.title =
        ggplot2::element_text(
          size = 10,
          hjust = 0.5
        )
    ) +
    ggplot2::xlab(ggplot2::element_blank())

  # score figure ----
  score_fig <- AKesp::esp_overall_score(
    data = overall_data,
    species = "",
    region = "",
    out = "one_pager"
  ) +
    ggplot2::ggtitle("Overall score") +
    ggplot2::theme(
      text = ggplot2::element_text(size = 8),
      plot.title = ggplot2::element_text(
        size = 10,
        hjust = 0.5
      ),

      aspect.ratio = 0.5,

      plot.margin = grid::unit(c(0, 8, 0, 0), units = "points"),

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
    ggplot2::ylab(ggplot2::element_blank())


  # conceptual model ----
  con <- png::readPNG(concept_path)

  concept <- ggplot2::ggplot() +
    ggplot2::theme_void() +
    ggplot2::theme(aspect.ratio = 1) +
    ggpubr::background_image(con) +
    ggplot2::theme(
      plot.title =
        ggplot2::element_text(
          size = 10,
          hjust = 0.5
        )
    )

  # key text ----
  key_txt <- ggplot2::ggplot() +
    ggplot2::theme_void() +
    ggplot2::annotate("text", x = 1, y = 1, label = readLines(key_text)) +
    ggplot2::theme(text = ggplot2::element_text(size = 8))

  # top row: overall score and key text ----
  top_figs <- ggpubr::ggarrange(
    score_fig,
    key_txt,
    nrow = 1,
    widths = c(1, 2)
  )

  # bottom row: conceptual model and indicator time series ----
  bottom_figs <- ggpubr::ggarrange(
    concept,
    fig,
    nrow = 1,
    widths = c(2, 1)
  )

  # all figs ----
  figs <- ggpubr::ggarrange(
    top_figs,
    bottom_figs,
    ncol = 1,
    heights = c(1, 1)
  )

  # header ----
  head <- png::readPNG(header_path)

  header <- ggplot2::ggplot() +
    ggplot2::theme_void() +
    ggplot2::theme(aspect.ratio = 1 / 4) +
    ggpubr::background_image(head)

  # text footer ----
  txt <- ggplot2::ggplot() +
    ggplot2::theme_void() +
    ggplot2::annotate("text", x = 1, y = 1, label = foot_text) +
    ggplot2::theme(text = ggplot2::element_text(size = 8))

  # put it all together ----
  summary_pg <- ggpubr::ggarrange(header,
                                  figs,
                                  txt,
                                  nrow = 3,
                                  heights = c(1, 2, 2)
  )
  ggplot2::ggsave(output_name,
                  width = 8.5,
                  height = 11
  )
}

one_pager2(overall_data = dat,
           timeseries_indicators = sample(unique(dat$INDICATOR_NAME), 3),
           output_name = paste0("one_pager_", Sys.Date(), ".pdf"))

