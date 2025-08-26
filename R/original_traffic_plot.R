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
  options(scipen = 999)
  maxyear <- max(data$YEAR)
  minyear <- maxyear - 1

  if (ncolumn == 1) {
    dat <- prep_ind_data(data, label_width = 50)
  } else {
    dat <- prep_ind_data(data, label_width = 25)
  }

  dat <- dat %>%
    dplyr::arrange(INDICATOR_ORDER)
  #use report card title for label instead of indicator name
  dat$name <- dat$REPORT_CARD_TITLE

  dat$name <- factor(dat$name, levels = unique(dat$name))

  # add units on facet ----
  if (f_units & "UNITS" %in% colnames(dat)) {
    dat <- dat %>%
      dplyr::mutate(name = paste0(.data$name, "\n", .data$UNITS))
  }

  # line data ----
  if (skip_lines) {
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
    ggplot2::geom_hline(
      ggplot2::aes(
        yintercept = .data$mean + .data$sd,
        group = .data$name
      ),
      color = "darkgreen",
      linetype = "solid"
    ) +
    ggplot2::geom_hline(
      ggplot2::aes(
        yintercept = .data$mean - .data$sd,
        group = .data$name
      ),
      color = "darkgreen",
      linetype = "solid"
    ) +
    ggplot2::geom_hline(
      ggplot2::aes(
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
    ggplot2::geom_point(
      data = dat %>%
        dplyr::filter(
          score == 1,
          INDICATOR_TYPE == "Ecosystem"
        ),
      #color = "cornflowerblue"
      color = "black"
    ) +
    ggplot2::geom_point(
      data = dat %>%
        dplyr::filter(
          score == -1,
          INDICATOR_TYPE == "Ecosystem"
        ),
      #color = "brown1"
      color = "black"
    )

  # try to add units on y axis ----
  # if you need to make more space between y axis labels and axis add more "\n"
  if (y_units & "UNITS" %in% colnames(dat)) {
    key <- dat %>%
      dplyr::select(.data$name, .data$UNITS, .data$DATA_VALUE, .data$YEAR) %>%
      dplyr::mutate(min_year = min(.data$YEAR, na.rm = TRUE)) %>%
      dplyr::group_by(.data$name, .data$UNITS, .data$min_year) %>%
      dplyr::summarise(mean = mean(.data$DATA_VALUE, na.rm = TRUE))

    plt <- plt +
      ggplot2::geom_text(
        data = key,
        inherit.aes = FALSE,
        ggplot2::aes(
          x = min_year,
          y = mean,
          label = paste(
            stringr::str_wrap(.data$UNITS, 10),
            "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
          )
        ),
        angle = 90,
        lineheight = 0.75
      ) +
      ggplot2::theme(plot.margin = ggplot2::unit(c(1, 1, 1, 3), "lines")) +
      ggplot2::coord_cartesian(clip = "off") +
      ggplot2::scale_y_continuous(breaks = scales::breaks_pretty(n = 3))
    # ggplot2::scale_y_continuous(labels = scales::label_scientific(), breaks = scales::breaks_pretty(n = 3))
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
        0, score
      ))

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
    } else {
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
          page = i # ,
          # labeller = ggplot2::labeller(name = ylabels)
        )

      finish_fig()
    }
  } else {
    plt <- plt +
      ggplot2::facet_wrap(~name,
        ncol = ncolumn,
        scales = "free_y" # ,
        # labeller = ggplot2::labeller(name = ylabels)
      )

    finish_fig()
  }
}
