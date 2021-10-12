#' Render the figure section
#'
#' This function renders an ESP figure.
#' @param dat The indicator data
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

#' Create an indicator list
#'
#' This function creates an indicator list from the data.
#' @param data The indicator data
#' @param indicator_type One of `c("Ecosystem", "Socioeconomic")`
#' @export

list_indicators <- function(data, indicator_type){
  dat <- data %>%
    dplyr::select(
      INDICATOR_NAME,
      INDICATOR_TYPE,
      CATEGORY,
      CONTACT,
      PRODUCT_DESCRIPTION
    ) %>%
    dplyr::distinct() %>%
    dplyr::filter(INDICATOR_TYPE == indicator_type)

  num_index <- 1
  total_text <- NULL
  for (j in unique(dat$CATEGORY)) {
    text <- paste0(num_index, ".) ", j, " Indicators")

    total_text <- paste(total_text, text, sep = "\n\n")

    # res <- knitr::knit_expand(text = text)
    # cat(res, sep = "\n")

    letter_index <- 1
    num_index <- num_index + 1

    dat1 <- dat %>%
      dplyr::filter(CATEGORY == j)
    for (k in unique(dat1$INDICATOR_NAME)) {
      dat2 <- dat1 %>%
        dplyr::select(INDICATOR_NAME, CONTACT, PRODUCT_DESCRIPTION) %>%
        dplyr::distinct() %>%
        dplyr::filter(INDICATOR_NAME == k)

      if (stringr::str_detect(dat2$PRODUCT_DESCRIPTION, "\\.$", negate = TRUE)) {
        dat2$PRODUCT_DESCRIPTION <- glue::glue(dat2$PRODUCT_DESCRIPTION, ".")
      }

      text <- paste0(letters[letter_index], ".) ", k, ": ", dat2$PRODUCT_DESCRIPTION, " (contact: ", dat2$CONTACT, ")")

      total_text <- paste(total_text, text, sep = "\n\n")
      # res <- knitr::knit_expand(text = text)
      # cat(res, sep = "\n")

      letter_index <- letter_index + 1
    }
  }
  return(total_text)
}
