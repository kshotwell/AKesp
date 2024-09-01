
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
    dplyr::select(.data$YEAR, .data$INDICATOR_NAME, .data$DATA_VALUE) %>%
    tidyr::pivot_wider(
      id_cols = .data$YEAR,
      names_from = .data$INDICATOR_NAME,
      values_from = .data$DATA_VALUE
    )

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
    dplyr::mutate(name = .data$INDICATOR_NAME %>%
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

# check for normalcy/zeros - none of these look normal

#' Plot indicator traffic light figure
#'
#' This function plots ESP indicator traffic light figures
#' @param data The ESP indicator data. Should have a column for Year and a column for each indicator.
#' @param name The file name for the image. Will be saved relative to the working directory.
#' @param out Whether the function should save the plot, print a ggplot object in markdown, or return a ggplot object to the working environment (for use with `one_pager()`). One of c("ggplot", "save", "one_pager")
#' @param paginate Whether to paginate the plots with `ggforce::facet_wrap_paginate`
#' @param label Whether to label the facets with a, b, c, etc.
#' @param status Whether to label the facets with the indicator status
#' @param caption A caption for the figure
#' @param ncolumn How many columns the figure should have (1 by default)
#' @param silent Whether to print the caption
#' @param min_year The minimum year to show on the plots. If left NULL (the default), the minimum year will be the first year of the dataset.
#' @param chunk_label The label name to look for to create the figure number. This is a work-around to deal with figure pagination.
#' @param f_units Whether to add units in the facet header
#' @param y_units Whether to add units to the y-axis
#' @param ... Passed to `ggplot2::ggsave`
#' @return An image file
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @export

esp_traffic <- function(data,
                             name,
                             out = "ggplot",
                             paginate = FALSE,
                             label = TRUE,
                             status = FALSE,
                             caption = "",
                             ncolumn = 1,
                             silent = FALSE,
                             min_year = NULL,
                             chunk_label = "traffic",
                             f_units = FALSE,
                             y_units = TRUE,
                        skip_lines = FALSE,
                             ...) {

  maxyear <- max(data$YEAR)
  minyear <- maxyear - 1

  if (ncolumn == 1) {
    dat <- prep_ind_data(data, label_width = 50)
  } else {
    dat <- prep_ind_data(data, label_width = 25)
  }

  dat <- dat %>%
    dplyr::arrange(INDICATOR_ORDER)
  dat$name <- factor(dat$name, levels = unique(dat$name))

  # add units on facet ----
  if(f_units & "UNITS" %in% colnames(dat)){
  dat <- dat %>%
    dplyr::mutate(name = paste0(.data$name, "\n", .data$UNITS))
  }

  # line data ----
  if(skip_lines){
    line_dat <- dat
  } else {
    line_dat <- dat %>%
      tidyr::drop_na(.data$DATA_VALUE)
  }

  # plot ----
  plt <- ggplot2::ggplot(
    dat,
    ggplot2::aes(
      x = .data$YEAR,
      y = .data$DATA_VALUE,
      group = name
    )
  ) +
    ggplot2::geom_hline(ggplot2::aes(
      yintercept = .data$mean + .data$sd,
      group = .data$name
    ),
    color = "darkgreen",
    linetype = "solid"
    ) +
    ggplot2::geom_hline(ggplot2::aes(
      yintercept = .data$mean - .data$sd,
      group = .data$name
    ),
    color = "darkgreen",
    linetype = "solid"
    ) +
    ggplot2::geom_hline(ggplot2::aes(
      yintercept = .data$mean,
      group = .data$name
    ),
    color = "darkgreen",
    linetype = "dotted"
    ) +
    ggplot2::geom_point() +
    ggplot2::geom_line(data = line_dat) +
    ggplot2::ylab("") +
    ggplot2::scale_y_continuous(labels = scales::comma) +
    ggplot2::theme_bw(base_size = 16) +
    ggplot2::theme(strip.text = ggplot2::element_text(size = 10))

  # add colored points based on score column (created by prep_ind_data fxn)
  plt <- plt +
    ggplot2::geom_point(data = dat %>%
                          dplyr::filter(score == 1,
                                        INDICATOR_TYPE == "Ecosystem"),
                        color = "cornflowerblue") +
    ggplot2::geom_point(data = dat %>%
                          dplyr::filter(score == -1,
                                        INDICATOR_TYPE == "Ecosystem"),
                        color = "brown1")

  # try to add units on y axis ----
  if(y_units & "UNITS" %in% colnames(dat)){
    key <- dat %>%
      dplyr::select(.data$name, .data$UNITS, .data$DATA_VALUE, .data$YEAR) %>%
      dplyr::mutate(min_year = min(.data$YEAR, na.rm = TRUE)) %>%
      dplyr::group_by(.data$name, .data$UNITS, .data$min_year) %>%
      dplyr::summarise(mean = mean(.data$DATA_VALUE, na.rm = TRUE))

    plt <- plt +
      ggplot2::geom_text(data = key,
                         inherit.aes = FALSE,
                         ggplot2::aes(x = min_year,
                                      y = mean,
                                      label = paste(stringr::str_wrap(.data$UNITS, 10),
                                                    "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")),
                         angle = 90,
                         lineheight = 0.75) +
      ggplot2::theme(plot.margin = ggplot2::unit(c(1, 1, 1, 6), "lines")) +
      ggplot2::coord_cartesian(clip = "off") +
      ggplot2::scale_y_continuous(labels = scales::label_scientific(),
                                  breaks = scales::breaks_pretty(n = 3))

    # ylabels <- key$UNITS
    # names(ylabels) <- key$name
      }

  # status ----

  if (status) {
    stat_dat <- dat %>%
      dplyr::filter(
        .data$YEAR == maxyear
      ) %>%
      dplyr::mutate(score = ifelse(INDICATOR_TYPE == "Socioeconomic",
                                   0, score))

    # status shapes/colors
    plt <- plt + ggplot2::geom_point(
      data = stat_dat,
      ggplot2::aes(
        x = .data$YEAR + 1,
        y = .data$mean,
        shape = as.factor(.data$label_num),
        fill = as.factor(.data$score)
      ),
      show.legend = FALSE,
      cex = 4
    ) +
      ggplot2::scale_shape_manual(values = c("-1" = 25, "0" = 21, "1" = 24)) +
      ggplot2::scale_fill_manual(values = c(
        "-1" = "brown1",
        "0" = "beige",
        "1" = "cornflowerblue"
      ))

    # also add + - for 508
    plt <- plt +
      ggnewscale::new_scale(new_aes = "shape") +
      ggplot2::geom_point(
        data = stat_dat,
        ggplot2::aes(
          x = .data$YEAR + 1.05,
          y = .data$mean,
          shape = as.factor(.data$score)
        ),
        show.legend = FALSE,
        cex = 4,
        inherit.aes = FALSE
      ) +
      ggplot2::scale_shape_manual(values = c("-1" = "-", "0" = NA, "1" = "+"))
  }

  if (status) {
    if (is.null(min_year)) {
      plt <- plt +
        ggplot2::xlim(c(min(dat$YEAR), max(dat$YEAR) + 1.5))
    } else {
      plt <- plt +
        ggplot2::xlim(c(min_year, max(dat$YEAR) + 1.5))
    }
  }

  if (!status) {
    if (is.null(min_year)) {
      plt <- plt +
        ggplot2::xlim(c(min(dat$YEAR), max(dat$YEAR) + 0.5))
    } else {
      plt <- plt +
        ggplot2::xlim(c(min_year, max(dat$YEAR) + 0.5))
    }
  }

  finish_fig <- function() {
    if (label) {
      plt <- plt %>%
        AKesp::label_facets(open = "", close = "")
    }

    if (out == "save") {
      ggplot2::ggsave(plt, filename = paste0(name, "_page", i, ".png"), ...)
    } else if (out == "ggplot") {
      print(plt)
      cat("\n\n")
      if (silent == FALSE) {
        cat("##### Figure \\@ref(fig:", chunk_label, "). ", caption, " {-}", sep = "")
      }
      cat("\n\n")
    } else if (out == "one_pager") {
      return(plt)
    }
    else {
      stop("Please specify output format")
    }
  }

  if (paginate == TRUE) {
    plt2 <- plt +
      ggforce::facet_wrap_paginate(
      ~name,
      # ggforce::facet_grid_paginate(
      #   rows = ggplot2::vars(name),
      #   cols = ggplot2::vars(UNITS),
        ncol = ncolumn,
        nrow = 5,
        scales = "free_y"
      )

    n <- ggforce::n_pages(plt2)

    for (i in 1:n) {
      plt <- plt +
        ggforce::facet_wrap_paginate(~name,
          ncol = ncolumn,
          nrow = 5,
          scales = "free_y",
          page = i#,
          #labeller = ggplot2::labeller(name = ylabels)
        )

      finish_fig()
    }
  } else {
    plt <- plt +
      ggplot2::facet_wrap(~name,
        ncol = ncolumn,
        scales = "free_y"#,
       # labeller = ggplot2::labeller(name = ylabels)
      )

    finish_fig()
  }
}

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
#' @param region The stock region
#' @param out Whether the function should save the plot, or return a ggplot object. One of c("ggplot", "save")
#' @param name The file name for the image. Will be saved relative to the working directory. Only needed if saving the plot.
#' @param ... Passed to `ggplot2::ggsave`
#' @return An image file
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @export

esp_overall_score <- function(data, species, region, out = "ggplot", name, ...) {
  dat <- data %>%
    prep_ind_data() %>%
    dplyr::filter(.data$YEAR >= 2000) %>%
    dplyr::group_by(.data$CATEGORY, .data$YEAR) %>%
    dplyr::mutate(
      score = as.numeric(.data$score),
      mean_score = mean(.data$score, na.rm = TRUE)
    ) %>%
    dplyr::select(
      .data$YEAR, .data$INDICATOR_NAME,
      .data$CATEGORY, .data$INDICATOR_TYPE,
      .data$score, .data$mean_score
    ) %>%
    dplyr::distinct()

  dat$CATEGORY <- factor(dat$CATEGORY,
    levels = c(
      "Physical",
      "Larval",
      "Lower Trophic",
      "Juvenile",
      "Upper Trophic",
      "Adult",
      "Fishery Performance",
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
      .data$YEAR, .data$INDICATOR_NAME,
      .data$CATEGORY, .data$INDICATOR_TYPE,
      .data$score, .data$mean_score,
      .data$type_mean_score,
    ) %>%
    dplyr::distinct()

  dat$CATEGORY <- factor(dat$CATEGORY,
                         levels = c(
                           "Physical",
                           "Larval",
                           "Lower Trophic",
                           "Juvenile",
                           "Upper Trophic",
                           "Adult",
                           "Fishery Performance",
                           "Economic",
                           "Community"
                         )
  )

  ymax <- max(abs(dat$mean_score))

  title <- paste("Overall Type Stage 1 Score for", region, species) %>%
    stringr::str_wrap(width = 40)

  plt <- ggplot2::ggplot(dat, ggplot2::aes(x = dat$YEAR)) +
#<<<<<<< HEAD
    ggplot2::geom_line(aes(y = dat$type_mean_score, color= dat$INDICATOR_TYPE), linewidth = 1.5) +
    ggplot2::geom_point(aes(y = dat$type_mean_score, color= dat$INDICATOR_TYPE, shape= dat$INDICATOR_TYPE), show.legend = FALSE, size = 0) +
    ggplot2::geom_line(aes(y = dat$mean_score, color = dat$CATEGORY)) +
    ggplot2::geom_point(aes(y = dat$mean_score, color = dat$CATEGORY, shape = dat$CATEGORY), show.legend = FALSE) +
#=======
    ggplot2::geom_line(ggplot2::aes(y = dat$type_mean_score,
                                    color= dat$INDICATOR_TYPE),
                       linewidth = 1.5) +
    ggplot2::geom_point(ggplot2::aes(y = dat$type_mean_score,
                                     color= dat$INDICATOR_TYPE,
                                     shape= dat$INDICATOR_TYPE),
                        size = 0) +
    ggplot2::geom_line(ggplot2::aes(y = dat$mean_score,
                                    color = dat$CATEGORY)) +
    ggplot2::geom_point(ggplot2::aes(y = dat$mean_score,
                                     color = dat$CATEGORY,
                                     shape = dat$CATEGORY)) +
#>>>>>>> 345c840fbe51d6e2d14eddcc829584375c60b9ea
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
          "Physical" = "red",
          "Larval" = "red",
          "Lower Trophic" = "darkorange",
          "Juvenile" = "darkorange",
          "Upper Trophic" = "gold",
          "Adult" = "gold",
          "Ecosystem" = "darkgray",
          "Fishery Performance" = "green",
          "Economic" = "blue",
          "Community" = "purple",
          "Socioeconomic" = "black"
        ),
        labels = c(
          "Physical" = "Physical",
          "Larval" = "Larval",
          "Lower Trophic" = "Lower Trophic",
          "Juvenile" = "Juvenile",
          "Upper Trophic" = "Upper Trophic",
          "Adult" = "Adult",
          "Ecosystem" = "Overall Ecosystem",
          "Fishery Performance" = "Fishery Performance",
          "Economic" = "Economic",
          "Community" = "Community",
          "Socioeconomic" = "Overall Socioeconomic"
        ),
        breaks = c(
        "Physical", "Larval", "Lower Trophic", "Juvenile",
        "Upper Trophic", "Adult", "Ecosystem", "Fishery Performance",
        "Economic", "Community", "Socioeconomic"
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
