
#' Plot correlation matrices
#'
#' This function creates correlation matrices for ESP indicators.
#' @param data The ESP indicator data. Should have a column for Year and a column for each indicator.
#' @param name The file name for the image. Will be saved relative to the working directory.
#' @param out Whether the function should save the plot, or return a ggplot object. One of c("ggplot", "save")
#' @param ... Passed to `ggplot2::ggsave`
#' @return An image file or a ggplot
#' @importFrom rlang .data
#' @export

esp_cor_matrix <- function(data, name, out, ...) {
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

# data <- read.csv(here::here("scripts/sablefish_indicators_2020_new_ma.csv"))
# esp_cor_matrix(data, name = "test.png", width = 15, height = 20, dpi = 72)

#' Plot indicator histograms
#'
#' This function plots ESP indicator hisograms
#' @param data The ESP indicator data. Should have a column for Year and a column for each indicator.
#' @param name The file name for the image. Will be saved relative to the working directory.
#' @param out Whether the function should save the plot, or return a ggplot object. One of c("ggplot", "save")
#' @param ... Passed to `ggplot2::ggsave`
#' @return An image file or a ggplot
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @export

esp_hist <- function(data, name, out, ...) {
  dat <- data %>%
    tidyr::pivot_longer(cols = colnames(data)[2:ncol(data)]) %>%
    dplyr::mutate(name = name %>%
      stringr::str_replace_all("_", " ") %>%
      stringr::str_wrap(width = 30))

  plt <- ggplot2::ggplot(dat) +
    ggplot2::geom_histogram(ggplot2::aes(
      x = .data$value,
      y = ggplot2::after_stat(density)
    ),
    color = "black",
    fill = "white",
    na.rm = TRUE
    ) +
    ggplot2::geom_density(ggplot2::aes(
      x = .data$value,
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

# `%>%` <- magrittr::`%>%`
# esp_hist(AKesp::sablefish, name = "test.png", out = "save", width = 10, height = 15, dpi = 72)

# check for normalcy/zeros - none of these look normal

#' Plot indicator traffic light figure
#'
#' This function plots ESP indicator traffic light figures
#' @param data The ESP indicator data. Should have a column for Year and a column for each indicator.
#' @param name The file name for the image. Will be saved relative to the working directory.
#' @param out Whether the function should save the plot, or return a ggplot object. One of c("ggplot", "save")
#' @param ... Passed to `ggplot2::ggsave`
#' @return An image file
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @export

esp_traffic <- function(data, name, out, ...) {
  maxyear <- max(data$Year)
  minyear <- maxyear - 1

  dat <- data %>%
    tidyr::pivot_longer(cols = colnames(data)[2:ncol(data)]) %>%
    dplyr::group_by(name) %>%
    dplyr::mutate(
      name = name %>%
        stringr::str_replace_all("_", " ") %>%
        stringr::str_wrap(width = 40),
      quant10 = stats::quantile(.data$value,
        probs = 0.1,
        na.rm = TRUE
      ),
      mean = mean(.data$value,
        na.rm = TRUE
      ),
      quant90 = stats::quantile(.data$value,
        probs = 0.9,
        na.rm = TRUE
      ),
      recent = (.data$Year == maxyear | .data$Year == minyear)
    )

  n <- ceiling(length(unique(dat$name)) / 5)

  for (i in 1:n) {
    plt <- ggplot2::ggplot(
      dat,
      ggplot2::aes(
        x = .data$Year,
        y = .data$value,
        group = name
      )
    ) +
      ggplot2::geom_rect(
        data = dat %>%
          dplyr::filter(.data$recent == TRUE),
        ggplot2::aes(
          xmin = min(.data$Year),
          xmax = max(.data$Year),
          ymin = .data$quant10,
          ymax = .data$quant90,
          group = name
        ),
        fill = "lightgreen"
      ) +
      ggplot2::geom_line(ggplot2::aes(
        x = .data$Year,
        y = .data$quant10
      ),
      color = "darkgreen",
      linetype = "solid"
      ) +
      ggplot2::geom_line(ggplot2::aes(
        x = .data$Year,
        y = .data$quant90
      ),
      color = "darkgreen",
      linetype = "solid"
      ) +
      ggplot2::geom_line(ggplot2::aes(
        x = .data$Year,
        y = .data$mean
      ),
      color = "darkgreen",
      linetype = "dotted"
      ) +
      ggplot2::geom_point() +
      ggplot2::geom_line(data = dat %>%
        tidyr::drop_na()) +
      ggforce::facet_wrap_paginate(~name,
        ncol = 1,
        nrow = 5,
        scales = "free",
        page = i
      ) +
      ggplot2::ylab("") +
      ggplot2::scale_y_continuous(labels = scales::comma) +
      ggplot2::theme_bw(base_size = 16)

    plt <- plt %>%
      AKesp::label_facets(open = "", close = "")

    if (out == "save") {
      ggplot2::ggsave(plt, filename = paste0(name, "_page", i, ".png"), ...)
    } else if (out == "ggplot") {
      print(plt)
    } else {
      stop("Please specify output format")
    }
  }
}

# esp_traffic(AKesp::sablefish, name = "test", out = "save", width = 6, height = 9, dpi = 72)

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

#' Create indicator traffic light table - WIDE data
#'
#' This function creates an ESP indicator traffic light table
#' @param data The ESP indicator data. Should have a column for Year and a column for each indicator.
#' @param year The year(s) to use for the traffic light analysis. Either a single number or a numeric vector.
#' @param cap The table caption.
#' @return A flextable
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @export

esp_traffic_tab <- function(data, year, cap = "Traffic light scoring") {
  dat <- data %>%
    tidyr::pivot_longer(cols = colnames(data)[2:ncol(data)]) %>%
    dplyr::group_by(.data$name) %>%
    dplyr::mutate(
      name = .data$name %>%
        stringr::str_replace_all("_", " "),
      this_year = (.data$Year %in% year),
      avg = mean(.data$value,
                 na.rm = TRUE
      ),
      stdev = stats::sd(.data$value,
                        na.rm = TRUE
      )
    ) %>%
    dplyr::filter(.data$this_year == TRUE)

  status <- c()
  for (i in seq_len(nrow(dat))) {
    if (is.na(dat$value[i])) {
      status[i] <- "missing"
    } else if (dat$value[i] > (dat$avg[i] + dat$stdev[i])) {
      status[i] <- "high"
    } else if (dat$value[i] < (dat$avg[i] - dat$stdev[i])) {
      status[i] <- "low"
    } else {
      status[i] <- "neutral"
    }
  }

  dat$status <- status

  dat <- dat %>%
    dplyr::select(.data$name, .data$Year, .data$status) %>%
    tidyr::pivot_wider(
      id_cols = .data$name,
      names_from = .data$Year,
      values_from = .data$status
    ) %>%
    dplyr::rename(Indicator = .data$name)

  colnames(dat)[2:ncol(dat)] <- paste(colnames(dat)[2:ncol(dat)], "Status")

  ft <- flextable::flextable(dat) %>%
    flextable::theme_vanilla() %>%
    flextable::set_caption(caption = cap) %>%
    flextable::autofit() %>%
    flextable::align(align = "center", j = 2:ncol(dat))

  for (j in 2:ncol(dat)) {
    for (i in seq_len(nrow(dat))) {
      if (dat[i, j] == "missing") {
        ft <- flextable::bg(ft, i = i, j = j, bg = "beige")
      }
      if (dat[i, j] == "high") {
        ft <- flextable::bg(ft, i = i, j = j, bg = "red")
      }
      if (dat[i, j] == "neutral") {
        ft <- flextable::bg(ft, i = i, j = j, bg = "white")
      }
      if (dat[i, j] == "low") {
        ft <- flextable::bg(ft, i = i, j = j, bg = "gray")
      }
    }
  }

  return(ft)
}
