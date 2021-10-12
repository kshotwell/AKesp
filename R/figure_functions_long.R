
#' Plot correlation matrices
#'
#' This function creates correlation matrices for ESP indicators.
#' @param data The ESP indicator data. LONG format.
#' @param name The file name for the image. Will be saved relative to the working directory. Only needed if saving the plot.
#' @param out Whether the function should save the plot, or return a ggplot object. One of c("ggplot", "save")
#' @param ... Passed to `ggplot2::ggsave`
#' @return An image file or a ggplot
#' @importFrom rlang .data
#' @importFrom magrittr %>%
#' @export

esp_cor_matrix_long <- function(data, name, out, ...) {
  data <- data %>%
    dplyr::select(YEAR, INDICATOR_NAME, DATA_VALUE) %>%
    tidyr::pivot_wider(id_cols = YEAR, names_from = INDICATOR_NAME, values_from = DATA_VALUE)

  traffic1_cor <- round(
    stats::cor(data,
      use = "complete.obs"
    ),
    1
  )
  p.mat <- ggcorrplot::cor_pmat(data)

  traffic1_cor_plot <- ggcorrplot::ggcorrplot(traffic1_cor,
    hc.order = TRUE,
    type = "lower",
    lab = TRUE
  )
  traffic1_cor_plot2 <- ggcorrplot::ggcorrplot(traffic1_cor,
    hc.order = TRUE,
    type = "lower",
    p.mat = p.mat,
    insig = "blank"
  )

  plt <- ggpubr::ggarrange(traffic1_cor_plot,
    traffic1_cor_plot2,
    ncol = 1
  ) +
    ggplot2::theme(axis.text = ggplot2::element_text(size = 5))

  if (out == "save") {
    ggplot2::ggsave(plt, filename = name, ...)
  } else if (out == "ggplot") {
    print(plt)
  } else {
    stop("Please specify output format")
  }
}

# esp_cor_matrix_long(AKesp::bbrkc_long, out = "save", name = "test.png",
#                    width = 15, height = 20, dpi = 72)

#' Plot indicator histograms
#'
#' This function plots ESP indicator histograms
#' @param data The ESP indicator data. LONG format.
#' @param name The file name for the image. Will be saved relative to the working directory. Only needed if saving the plot.
#' @param out Whether the function should save the plot, or return a ggplot object. One of c("ggplot", "save")
#' @param ... Passed to `ggplot2::ggsave`
#' @return An image file or a ggplot
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @export

esp_hist_long <- function(data, name, out, ...) {
  dat <- data %>%
    dplyr::mutate(name = INDICATOR_NAME %>%
      stringr::str_replace_all("_", " ") %>%
      stringr::str_wrap(width = 30))

  plt <- ggplot2::ggplot(dat) +
    ggplot2::geom_histogram(ggplot2::aes(
      x = .data$DATA_VALUE,
      y = ggplot2::after_stat(density)
    ),
    color = "black",
    fill = "white",
    na.rm = TRUE
    ) +
    ggplot2::geom_density(ggplot2::aes(
      x = .data$DATA_VALUE,
      y = ggplot2::after_stat(density)
    ),
    alpha = 0.2, fill = "yellow"
    ) +
    ggplot2::facet_wrap(~name, ncol = 3, scales = "free") +
    ggplot2::theme_bw(base_size = 12)

  if (out == "save") {
    ggplot2::ggsave(plt, filename = name, ...)
  } else if (out == "ggplot") {
    print(plt) %>%
      suppressMessages()
  } else {
    stop("Please specify output format")
  }
}

# esp_hist_long(AKesp::bbrkc_long, out = "ggplot")

# check for normalcy/zeros - none of these look normal

#' Plot indicator traffic light figure
#'
#' This function plots ESP indicator traffic light figures
#' @param data The ESP indicator data. Should have a column for Year and a column for each indicator.
#' @param name The file name for the image. Will be saved relative to the working directory.
#' @param out Whether the function should save the plot, or return a ggplot object. One of c("ggplot", "save")
#' @param paginate Whether to paginate the plots with `ggforce::facet_wrap_paginate`
#' @param label Whether to label the facets
#' @param ... Passed to `ggplot2::ggsave`
#' @return An image file
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @export

esp_traffic_long <- function(data,
                             name,
                             out = "ggplot",
                             paginate = FALSE,
                             label = TRUE,
                             caption = "",
                             ...) {
  maxyear <- max(data$YEAR)
  minyear <- maxyear - 1

  dat <- data %>%
    dplyr::select(INDICATOR_NAME, YEAR, DATA_VALUE) %>%
    dplyr::group_by(INDICATOR_NAME) %>%
    dplyr::mutate(
      name = INDICATOR_NAME %>%
        stringr::str_replace_all("_", " ") %>%
        stringr::str_wrap(width = 40),
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
      label = ifelse(.data$YEAR == maxyear,
                     ifelse(.data$DATA_VALUE < (.data$mean + .data$sd),
                            ifelse(.data$DATA_VALUE > (.data$mean - .data$sd),
                                   "neutral", "low"),
                     "high"),
                     NA)
      ) %>%
    dplyr::ungroup()

  plt <- ggplot2::ggplot(
    dat,
    ggplot2::aes(
      x = .data$YEAR,
      y = .data$DATA_VALUE,
      group = name
    )
  ) +
    ggplot2::geom_rect(
      data = dat %>%
        dplyr::filter(.data$recent == TRUE),
      ggplot2::aes(
        xmin = min(.data$YEAR),
        xmax = max(.data$YEAR),
        ymin = .data$quant10,
        ymax = .data$quant90,
        group = name
      ),
      fill = "lightgreen"
    ) +
    ggplot2::geom_line(ggplot2::aes(
      x = .data$YEAR,
      y = .data$quant10
    ),
    color = "darkgreen",
    linetype = "solid"
    ) +
    ggplot2::geom_line(ggplot2::aes(
      x = .data$YEAR,
      y = .data$quant90
    ),
    color = "darkgreen",
    linetype = "solid"
    ) +
    ggplot2::geom_line(ggplot2::aes(
      x = .data$YEAR,
      y = .data$mean
    ),
    color = "darkgreen",
    linetype = "dotted"
    ) +
    ggplot2::geom_point() +
    ggplot2::geom_line(data = dat %>%
      tidyr::drop_na(.data$DATA_VALUE)) +
    #ggrepel::geom_label_repel(ggplot2::aes(label = .data$label),
    #                 box.padding   = 0.35,
    #                 point.padding = 0.5,
    #                 segment.color = NA) +
    ggplot2::geom_label(ggplot2::aes(label = .data$label,
                                     y = .data$mean,
                                     fill = .data$label),
                        nudge_x = 3,
                        show.legend = FALSE) +
    ggplot2::scale_fill_manual(values = c("brown1", "cornflowerblue", "beige")) +
    ggplot2::ylab("") +
    ggplot2::scale_y_continuous(labels = scales::comma) +
    ggplot2::theme_bw(base_size = 16)+
    ggplot2::xlim(c(min(dat$YEAR), max(dat$YEAR) + 4))

  finish_fig <- function() {
    if(label){
      plt <- plt %>%
        AKesp::label_facets(open = "", close = "")
    }

    if (out == "save") {
      ggplot2::ggsave(plt, filename = paste0(name, "_page", i, ".png"), ...)
    } else if (out == "ggplot") {
      print(plt)
      cat("\n\n")
      cat("#### Figure \\@ref(fig:traffic).", caption, "{-}")
      cat("\n\n")
    } else {
      stop("Please specify output format")
    }
  }

  if (paginate == TRUE) {

    nfacet <- length(unique(dat$name))

    n <- ceiling(nfacet / 5)
    last_n <- nfacet - (n - 1)*5

    for (i in 1:n) {
      plt <- plt +
        ggforce::facet_wrap_paginate(~name,
          ncol = 1,
          nrow = 5,
          scales = "free_y",
          page = i
        )

      finish_fig()
    }
  } else {
    plt <- plt +
      ggplot2::facet_wrap(~name,
        ncol = 1,
        scales = "free_y"
      )

    finish_fig()
  }
}

# esp_traffic_long(AKesp::bbrkc_long, out = "ggplot", paginate = TRUE)

#' Plot a metric panel figure
#'
#' This function plots an ESP metric panel
#' @param data The ESP metric panel data (suggest to use `AKesp::metric_panel`).
#' @param species The species name
#' @param region The stock region
#' @param approved Boolean. Whether to use only approved metrics (`approved = TRUE`)
#' @param order Boolean. Whether to order the metrics by value (`order = TRUE`). Else will be in standard order.
#' @param name The file name for the image. Will be saved relative to the working directory.
#' @param out Whether the function should save the plot, or return a ggplot object. One of c("ggplot", "save")
#' @param ... Passed to `ggplot2::ggsave`
#' @return An image file
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @export

esp_metrics <- function(data, species, region, approved = TRUE, order = FALSE, out, name, ...) {
  dat <- data %>%
    dplyr::filter(
      .data$Stock == species,
      .data$Region == region
    ) %>%
    dplyr::mutate(
      Rank0 = as.numeric(.data$Rank0),
      Rank = as.numeric(.data$Rank)
    )

  if (approved) {
    dat <- dat %>%
      dplyr::filter(.data$Use == "Yes")
  }

  if (order) {
    dat <- dat %>%
      dplyr::arrange(.data$Order2)
  } else {
    dat <- dat %>%
      dplyr::arrange(.data$Order1)
  }

  dat$Metric <- factor(dat$Metric, levels = unique(dat$Metric))

  labs <- factor(dat$Metric)
  n <- length(labs)

  plt <- ggplot2::ggplot(dat) +
    ggplot2::geom_ribbon(ggplot2::aes(
      ymax = 0.9,
      ymin = 0.8,
      x = seq(0, length(.data$Metric) + 1,
        length.out = length(.data$Metric)
      )
    ),
    color = "gray",
    fill = "gray"
    ) +
    ggplot2::geom_ribbon(ggplot2::aes(
      ymax = 1,
      ymin = 0.9,
      x = seq(0, length(.data$Metric) + 1,
        length.out = length(.data$Metric)
      )
    ),
    color = "black",
    fill = "black"
    ) +
    ggplot2::geom_col(ggplot2::aes(
      x = as.numeric(factor(.data$Metric)),
      y = .data$Rank,
      fill = .data$Quality
    ), ) +
    ggplot2::scale_fill_gradient(
      low = "green",
      high = "blue",
      na.value = "transparent",
      breaks = c(0, 2, 4),
      labels = c("No Data", "Medium", "Complete"),
      limits = c(0, 4)
    ) +
    ggplot2::scale_y_continuous(
      limits = c(0, 1),
      breaks = c(0, 0.5, 1),
      labels = c("Low", "Med", "High")
    ) +
    ggplot2::scale_x_continuous(
      limits = c(0, n + 1),
      breaks = 1:n,
      minor_breaks = NULL,
      expand = c(0, 0),
      n.breaks = n,
      labels = labs
    ) +
    ggplot2::coord_flip() +
    ggplot2::theme_bw(base_size = 14) +
    ggplot2::ggtitle("") +
    ggplot2::xlab("") +
    ggplot2::ylab("")

  if (out == "save") {
    ggplot2::ggsave(plt, filename = name, ...)
  } else if (out == "ggplot") {
    print(plt)
  } else {
    stop("Please specify output format")
  }
}

# esp_metrics(
#  data = AKesp::metric_panel, species = "Sablefish", region = "GOA",
#  approved = TRUE, order = FALSE, out = "ggplot"
# )

#' Plot a figure of overall ESP scores
#'
#' This function plots a visual of overall ESP scores over time.
#' @param data The ESP indicator data (LONG format).
#' @param species The species name
#' @param out Whether the function should save the plot, or return a ggplot object. One of c("ggplot", "save")
#' @param name The file name for the image. Will be saved relative to the working directory. Only needed if saving the plot.
#' @param ... Passed to `ggplot2::ggsave`
#' @return An image file
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @export

esp_overall_score <- function(data, species, out = "ggplot", name) {
  dat <- data %>%
    dplyr::group_by(.data$INDICATOR_TYPE, .data$YEAR) %>%
    dplyr::summarise(mean_score = mean(.data$SCORE, na.rm = TRUE))

  ymax <- max(abs(dat$mean_score))

  plt <- ggplot2::ggplot(
    dat,
    ggplot2::aes(
      x = .data$YEAR,
      y = .data$mean_score,
      color = .data$INDICATOR_TYPE
    )
  ) +
    ggplot2::geom_hline(
      yintercept = 0,
      lty = "dashed"
    ) +
    ggplot2::geom_line() +
    ggplot2::geom_point() +
    ggplot2::ylab("Score") +
    ggplot2::xlab(ggplot2::element_blank()) +
    ggplot2::theme_bw(base_size = 16) +
    ggplot2::theme(
      legend.title = ggplot2::element_blank(),
      legend.position = "bottom"
    ) +
    ggplot2::ggtitle(label = paste("Overall Stage 1 Score for", species)) +
    ggplot2::ylim(-ymax, ymax)

  if (out == "save") {
    ggplot2::ggsave(plt, filename = name, ...)
  } else if (out == "ggplot") {
    print(plt)
    cat("\n\n")
  } else {
    stop("Please specify output format")
  }
}

# esp_overall_score(AKesp::bbrkc_long, species = "BBRKC")
