#' Render the figure section
#'
#' This function renders an ESP figure.
#' @param dat
#' @export

make_traffic_plot <- function(dat) {
  plt <- esp_traffic_long(dat,
    out = "save",
    name = "../../test/images/traffic",
    paginate = TRUE,
    label = TRUE,
    height = 8
  )

  n <- 3

  for(i in 1:n){
    file_name <- paste0("../../test/images/traffic", "_page", i, ".png")
    print(file_name)

    render_fig(
      img = file_name,
      lab = paste0("traffic", "_page", i),
      cap = "testcap",
      alt = "testalt"
    )
  }

  # names <- unique(dat$INDICATOR_NAME)
  # n <- ceiling(length(names) / 5)
  #
  # # loop through esp_traffic_long ??
  #
  # for (i in 1:n) {
  #   print(i)
  #
  #   num <- i
  #
  #   txt <- '```{r, {{label}}-{{num}}, fig.cap = "{{alttext}}", fig.height = 8 * ({{num}} * 5 - ({{num}} - 1) * 5 + 1)/5, echo = TRUE}
  #       print({{label}}-{{num}})
  #
  #       start <- ({{num}} - 1) * 5 + 1
  #   end <- {{num}} * 5
  #
  #   if(length(dat$INDICATOR_NAME) < end) {
  #     end <- length(dat$INDICATOR_NAME)
  #   }
  #
  #   names <- unique(dat$INDICATOR_NAME)
  #
  #   new_dat <- dat %>%
  #   dplyr::filter(.data$INDICATOR_NAME %in% names[start:end] )
  #
  #     plt{{num}} <<- esp_traffic_long(new_dat,
  #   out = "ggplot", paginate = FALSE,
  #   label = TRUE
  # )
  #
  # print(plt{{num}})
  #     ```'
  #
  #   lab <- "traffic"
  #   cap <- "testcap"
  #   alt <- "testalt"
  #
  #   ex <- abs(rnorm(1))
  #
  #   print(knitr::knit_expand(
  #     text = txt,
  #     label = lab,
  #     caption = cap,
  #     alttext = alt,
  #     num = i
  #   ))
  #
  #   res <- knitr::knit_child(
  #     text = knitr::knit_expand(
  #       text = txt,
  #       label = lab,
  #       caption = cap,
  #       alttext = alt,
  #       num = i
  #     ),
  #     quiet = TRUE
  #   )
  #
  #   cat(res,
  #     knitr::knit_expand(
  #       text = "#### Figure \\@ref(fig:{{label}}-{{num}}). {{caption}} {-}",
  #       label = lab,
  #       caption = cap,
  #       num = i,
  #       extra = ex
  #     ),
  #     sep = "\n\n"
  #   )
  # }
}

#make_traffic_plot(AKesp::bbrkc_long)
