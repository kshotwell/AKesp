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

esp_cor_matrix <- function(data, name, out, ...) {
  data <- data %>%
    dplyr::select(.data$YEAR, .data$REPORT_CARD_TITLE, .data$DATA_VALUE) %>%
    tidyr::pivot_wider(
      id_cols = .data$YEAR,
      names_from = .data$REPORT_CARD_TITLE,
      values_from = .data$DATA_VALUE
    )

  traffic1_cor <- round(
    stats::cor(data, use = "complete.obs"),
    1
  )
  p.mat <- ggcorrplot::cor_pmat(data)

  traffic1_cor_plot <- ggcorrplot::ggcorrplot(
    traffic1_cor,
    hc.order = TRUE,
    type = "lower",
    lab = TRUE
  )
  traffic1_cor_plot2 <- ggcorrplot::ggcorrplot(
    traffic1_cor,
    hc.order = TRUE,
    type = "lower",
    p.mat = p.mat,
    insig = "blank"
  )

  plt <- ggpubr::ggarrange(traffic1_cor_plot, traffic1_cor_plot2, ncol = 1) +
    ggplot2::theme(axis.text = ggplot2::element_text(size = 5))

  if (out == "save") {
    ggplot2::ggsave(plt, filename = name, ...)
  } else if (out == "ggplot") {
    print(plt)
  } else {
    stop("Please specify output format")
  }
}

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

esp_hist <- function(data, name, out, ...) {
  dat <- data %>%
    dplyr::mutate(
      name = .data$INDICATOR_NAME %>%
        stringr::str_replace_all("_", " ") %>%
        stringr::str_wrap(width = 30)
    )

  plt <- ggplot2::ggplot(dat) +
    ggplot2::geom_histogram(
      ggplot2::aes(
        x = .data$DATA_VALUE,
        y = ggplot2::after_stat(density)
      ),
      color = "black",
      fill = "white",
      na.rm = TRUE
    ) +
    ggplot2::geom_density(
      ggplot2::aes(
        x = .data$DATA_VALUE,
        y = ggplot2::after_stat(density)
      ),
      alpha = 0.2,
      fill = "yellow"
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

# check for normalcy/zeros - none of these look normal

#' Plot a figure of overall ESP scores
#'
#' This function plots a visual of overall ESP scores over time.
#' @param data The ESP indicator data (LONG format).
#' @param species The species name
#' @param region The stock region
#' @param out Whether the function should save the plot, or return a ggplot object. One of c("ggplot", "save")
#' @param name The file name for the image. Will be saved relative to the working directory. Only needed if saving the plot.
#' @param ... Passed to `ggplot2::ggsave`
#' @return An image file
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @export

esp_overall_score <- function(
  data,
  species,
  region,
  out = "ggplot",
  name,
  ...
) {
  dat <- data %>%
    prep_ind_data() %>%
    dplyr::filter(.data$YEAR >= 2000) %>%
    dplyr::group_by(.data$CATEGORY, .data$YEAR) %>%
    dplyr::mutate(
      score = as.numeric(.data$score),
      mean_score = mean(.data$score, na.rm = TRUE)
    ) %>%
    dplyr::select(
      .data$YEAR,
      .data$INDICATOR_NAME,
      .data$CATEGORY,
      .data$INDICATOR_TYPE,
      .data$score,
      .data$mean_score
    ) %>%
    dplyr::distinct()

  dat$CATEGORY <- factor(
    dat$CATEGORY,
    levels = c(
      "Physical",
      "Larval_YOY",
      "Lower Trophic",
      "Juvenile",
      "Upper Trophic",
      "Adult",
      "Fishery Informed",
      "Economic",
      "Community"
    )
  )

  ymax <- max(abs(dat$mean_score))

  title <- paste("Overall Stage 1 Score for", region, species) %>%
    stringr::str_wrap(width = 40)

  plt <- ggplot2::ggplot(
    dat,
    ggplot2::aes(
      x = .data$YEAR,
      y = .data$mean_score,
      color = .data$CATEGORY,
      shape = .data$CATEGORY
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
      legend.position = "bottom",
      legend.direction = "vertical",
      plot.title = ggplot2::element_text(size = 14)
    ) +
    ggplot2::guides(color = ggplot2::guide_legend(ncol = 2)) +
    ggplot2::ggtitle(label = title) +
    ggplot2::ylim(-ymax, ymax) +
    ggplot2::facet_grid(rows = ggplot2::vars(.data$INDICATOR_TYPE))

  if (out == "save") {
    ggplot2::ggsave(plt, filename = name, ...)
  } else if (out == "ggplot") {
    print(plt)
    cat("\n\n")
  } else if (out == "one_pager") {
    return(plt)
  } else {
    stop("Please specify output format")
  }
}

#' Plot a figure of combo ESP scores
#'
#' This function is a alternative combo plot of the overall ESP scores over time.
#' @param data The ESP indicator data (LONG format).
#' @param species The species name
#' @param region The stock region
#' @param out Whether the function should save the plot, or return a ggplot object. One of c("ggplot", "save")
#' @param name The file name for the image. Will be saved relative to the working directory. Only needed if saving the plot.
#' @param ... Passed to `ggplot2::ggsave`
#' @return An image file
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @export

esp_combo_score <- function(data, species, region, out = "ggplot", name, ...) {
  dat <- data %>%
    prep_ind_data() %>%
    dplyr::filter(.data$YEAR >= 2000) %>%
    dplyr::group_by(.data$CATEGORY, .data$YEAR) %>%
    dplyr::mutate(
      score = as.numeric(.data$score),
      mean_score = mean(.data$score, na.rm = TRUE)
    ) %>%
    dplyr::group_by(.data$INDICATOR_TYPE, .data$YEAR) %>%
    dplyr::mutate(
      type_mean_score = mean(.data$score, na.rm = TRUE)
    ) %>%
    dplyr::select(
      .data$YEAR,
      .data$INDICATOR_NAME,
      .data$CATEGORY,
      .data$INDICATOR_TYPE,
      .data$score,
      .data$mean_score,
      .data$type_mean_score,
    ) %>%
    dplyr::distinct()

  dat$CATEGORY <- factor(
    dat$CATEGORY,
    levels = c(
      "Physical",
      "Larval_YOY",
      "Lower Trophic",
      "Juvenile",
      "Upper Trophic",
      "Adult",
      "Fishery Informed",
      "Economic",
      "Community"
    )
  )

  ymax <- max(abs(dat$mean_score))

  title <- paste("Combo Type Stage 1 Score for", region, species) %>%
    stringr::str_wrap(width = 40)

  plt <- ggplot2::ggplot(dat, ggplot2::aes(x = .data$YEAR)) +
    ggplot2::geom_line(
      ggplot2::aes(y = .data$type_mean_score, color = .data$INDICATOR_TYPE),
      linewidth = 1.5
    ) +
    ggplot2::geom_point(
      ggplot2::aes(
        y = .data$type_mean_score,
        color = .data$INDICATOR_TYPE,
        shape = .data$INDICATOR_TYPE
      ),
      show.legend = FALSE,
      size = 2
    ) +
    ggplot2::geom_line(ggplot2::aes(
      y = .data$mean_score,
      color = .data$CATEGORY
    )) +
    ggplot2::geom_point(
      ggplot2::aes(
        y = .data$mean_score,
        color = .data$CATEGORY,
        shape = .data$CATEGORY
      ),
      show.legend = FALSE
    ) +
    ggplot2::geom_line(
      ggplot2::aes(
        y = .data$type_mean_score,
        color = .data$INDICATOR_TYPE
      ),
      linewidth = 1.5
    ) +
    ggplot2::geom_point(
      ggplot2::aes(
        y = .data$type_mean_score,
        color = .data$INDICATOR_TYPE,
        shape = .data$INDICATOR_TYPE
      ),
      size = 2,
      show.legend = FALSE
    ) +
    ggplot2::geom_line(ggplot2::aes(
      y = .data$mean_score,
      color = .data$CATEGORY
    )) +
    ggplot2::geom_point(
      ggplot2::aes(
        y = .data$mean_score,
        color = .data$CATEGORY,
        shape = .data$CATEGORY
      ),
      show.legend = FALSE
    ) +
    ggplot2::geom_hline(
      yintercept = 0,
      lty = "dashed"
    ) +
    ggplot2::ylab("Score") +
    ggplot2::xlab(ggplot2::element_blank()) +
    ggplot2::theme_bw(base_size = 16) +
    ggplot2::theme(
      legend.title = ggplot2::element_blank(),
      legend.position = "bottom",
      legend.direction = "vertical",
      plot.title = ggplot2::element_text(size = 14)
    ) +
    ggplot2::guides(color = ggplot2::guide_legend(ncol = 2)) +
    ggplot2::ggtitle(label = title) +
    ggplot2::ylim(-ymax, ymax) +
    ggplot2::facet_grid(rows = ggplot2::vars(.data$INDICATOR_TYPE)) +
    ggplot2::scale_color_manual(
      values = c(
        "Physical" = "green",
        "Larval_YOY" = "green",
        "Lower Trophic" = "blue",
        "Juvenile" = "blue",
        "Upper Trophic" = "purple",
        "Adult" = "purple",
        "Ecosystem" = "black",
        "Fishery Informed" = "green",
        "Economic" = "blue",
        "Community" = "purple",
        "Socioeconomic" = "black"
      ),
      labels = c(
        "Physical" = "Physical",
        "Larval_YOY" = "Larval to YOY",
        "Lower Trophic" = "Lower Trophic",
        "Juvenile" = "Juvenile",
        "Upper Trophic" = "Upper Trophic",
        "Adult" = "Adult",
        "Ecosystem" = "Overall Ecosystem",
        "Fishery Informed" = "Fishery Informed",
        "Economic" = "Economic",
        "Community" = "Community",
        "Socioeconomic" = "Overall Socioeconomic"
      ),
      breaks = c(
        "Physical",
        "Larval_YOY",
        "Lower Trophic",
        "Juvenile",
        "Upper Trophic",
        "Adult",
        "Ecosystem",
        "Fishery Informed",
        "Economic",
        "Community",
        "Socioeconomic"
      )
    )

  if (out == "save") {
    ggplot2::ggsave(plt, filename = name, ...)
  } else if (out == "ggplot") {
    print(plt)
    cat("\n\n")
  } else if (out == "one_pager") {
    return(plt)
  } else {
    stop("Please specify output format")
  }
}

# esp_overall_score(AKesp::bbrkc_long, species = "BBRKC")

# create_dummy_figs <- function(chunk_names){
#   for(i in chunk_names){
#     res <- knitr::knit_child(
#       text = paste0("```{r,", i, "-dummy, fig.width = 1, fig.height = 1, fig.cap = 'dummy figure'}
#       knitr::include_graphics(path = system.file('images/noaa.jpg', package = 'AKesp'))
#       ```"),
#       quiet = TRUE)
#     cat(res, sep = "\n\n")
#   }
# }

#' Plot a time series figure for inclusion in the ESP report card indicator table
#'
#' This function plots  a time series figure for inclusion in the ESP report card indicator table.
#' @param data The ESP indicator data -- data for a single indicator time series.
#' @param ylab The y-axis label
#' @param xlims The x-axis limits
#' @param new_breaks The x-axis breaks
#' @param type The type of indicator, either "Ecosystem" or "Socioeconomic". Defaults to "Ecosystem".
#' @return A ggplot
#' @importFrom rlang .data
#' @export

rpt_card_timeseries <- function(
  data,
  ylab,
  xlims,
  new_breaks,
  type = "Ecosystem"
) {
  max_year <- data |>
    dplyr::select(.data$YEAR, .data$DATA_VALUE) |>
    tidyr::drop_na() |>
    dplyr::arrange(.data$YEAR) |>
    dplyr::last()

  plt <- data |>
    AKesp::prep_ind_data() |>
    ggplot2::ggplot(ggplot2::aes(
      x = .data$YEAR,
      y = .data$DATA_VALUE
    ))

  if (type == "Ecosystem") {
    data_sign <- unique(data$SIGN)
    if (length(data_sign) != 1) {
      # can add ability to handle this later, if it's useful
      stop(
        "It looks like you are trying to plot multiple indicators that have different SIGNS. Please break up indicators before passing to plotting function."
      )
    }

    top_color <- dplyr::case_when(
      data_sign == 1 ~ "#6B87B9",
      data_sign == -1 ~ "#DF5C47"
      # data_sign == 1 ~ "grey",
      # data_sign == -1 ~ "grey"
    )

    bottom_color <- dplyr::case_when(
      data_sign == -1 ~ "#6B87B9",
      data_sign == 1 ~ "#DF5C47"
      # data_sign == -1 ~ "grey",
      # data_sign == 1 ~ "grey"
    )
    plt <- plt +
      ggplot2::geom_rect(
        ggplot2::aes(
          ymin = .data$mean + .data$sd,
          ymax = Inf,
          xmin = -Inf,
          xmax = Inf
        ),
        #alpha = 0.05,
        fill = top_color
      ) +
      ggplot2::geom_rect(
        ggplot2::aes(
          ymin = -Inf,
          ymax = .data$mean - .data$sd,
          xmin = -Inf,
          xmax = Inf
        ),
        #alpha = 0.05,
        fill = bottom_color
      )
  }

  plt <- plt +
    ggplot2::geom_point(size = 1.5) +
    ggplot2::geom_line() +
    ggplot2::geom_hline(
      ggplot2::aes(yintercept = .data$mean),
      linetype = 4,
      lwd = 1
    ) +
    ggplot2::geom_hline(
      ggplot2::aes(yintercept = .data$mean - .data$sd),
      linetype = 3,
      lwd = 1
    ) +
    ggplot2::geom_hline(
      ggplot2::aes(yintercept = .data$mean + .data$sd),
      linetype = 3,
      lwd = 1
    ) +
    ggplot2::annotate(
      "text",
      x = max_year$YEAR,
      y = max_year$DATA_VALUE,
      label = max_year$YEAR,
      size = 4,
      vjust = -1
    ) +
    ggplot2::ylab(ylab) +
    ggplot2::theme_bw(base_size = 12) +
    ggplot2::scale_x_continuous(
      breaks = new_breaks,
      limits = xlims
    ) +
    ggplot2::theme(
      panel.grid = ggplot2::element_blank(),
      axis.text = ggplot2::element_text(size = 12),
      axis.text.x = ggplot2::element_text(
        angle = 30,
        hjust = 1
      ),
      axis.title.x = ggplot2::element_blank(),
      plot.background = ggplot2::element_rect(color = "black")
    )

  return(plt)
}
