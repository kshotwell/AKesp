#' Create a status table for the short-form summary report
#'
#' This function creates a status table for the short-form summary report.
#' @param data The template .csv
#' @param dir The directory where images referenced in the .csv are saved
#' @param type The type of template. One of c("Ecosystem", "Socioeconomic")
#' @param img_w The width of the time series plot (inches)
#' @param img_h The height of the time series plot (inches)
#' @param colnames The column names for the table. Defaults to c("Indicator", "2024 Status", "Trend").
#' @export

create_indicator_table <- function(data, dir, type,
                                   img_w = 4.5, img_h = 2.5,
                                   colnames = c("Indicator", "2024 Status", "Trend")) {
  if (type == "Socioeconomic") {
    head_fill <- "#2e3192ff"
    text_col <- "#2e3192"
  } else if (type == "Ecosystem") {
    head_fill <- "#008998"
    text_col <- "#00467F"
  } else {
    stop("Type must be either 'Socioeconomic' or 'Ecosystem'")
  }

  data$category <- factor(data$category,
    levels = c(
      "predictive", "contextual", "monitoring",
      "fishery performance", "economic", "community"
    )
  )
  data <- data |>
    dplyr::arrange(category)

  data <- data |>
    dplyr::mutate(
      filepath = paste0(dir, "/", trend),
      status_filepath = paste0(dir, "/", status_image)
    ) |>
    dplyr::left_join(AKesp::color_key) |>
    dplyr::rename(type2 = type) |>
    dplyr::filter(type2 == type)

  small_dat <- data |>
    dplyr::select(1:3)

  colnames(small_dat) <- colnames

  flextable::set_flextable_defaults(font.size = 10)

  tbl <- flextable::flextable(small_dat)
  tbl <- flextable::theme_box(tbl)

  for (i in 1:nrow(small_dat)) {
    # add time series graph
    tbl <- flextable::compose(tbl,
      i = i,
      j = 3,
      value = flextable::as_paragraph(
        flextable::as_image(
          src = data$filepath[i],
          width = img_w,
          height = img_h,
          unit = "in",
          guess_size = FALSE
        )
      )
    )
    # add status icon
    tbl <- flextable::compose(tbl,
      i = i,
      j = 2,
      value = flextable::as_paragraph(
        data$status_2024[i], "\n",
        flextable::as_image(
          src = data$status_filepath[i],
          width = 0.5,
          height = 0.5,
          unit = "in",
          guess_size = FALSE
        )
      )
    )
    # update background color
    tbl <- flextable::bg(tbl,
      i = i,
      bg = data$color[i]
    )
  }

  # aesthetic formatting
  tbl <- flextable::bold(tbl, j = 1)
  tbl <- flextable::bg(tbl,
    bg = head_fill,
    part = "header"
  )
  tbl <- flextable::color(tbl,
    color = "white",
    part = "header"
  )
  tbl <- flextable::color(tbl,
    color = text_col,
    part = "body"
  )
  tbl <- flextable::border(tbl,
    border = officer::fp_border(color = "white"),
    part = "all"
  )
  tbl <- flextable::align(tbl,
    align = "center",
    part = "header"
  )
  tbl <- flextable::align(tbl,
    align = "center",
    j = 1:3,
    part = "body"
  )
  tbl <- flextable::width(tbl,
    j = 1:3,
    width = c(1, 1, 3),
    unit = "in"
  )

  return(tbl)
}

# img <- create_indicator_table(data = read.csv(here::here("inst/two-pager_table_template.csv")),
#                               dir = here::here("inst/images"),
#                               type = "Socioeconomic")
# flextable::save_as_image(img,
#                          path = here::here("data-raw/indicator_table.png"))
#
# img <- create_indicator_table(data = read.csv(here::here("inst/two-pager_table_template.csv")),
#                               dir = here::here("inst/images"),
#                               type = "Ecosystem")
# flextable::save_as_image(img,
#                           path = here::here("data-raw/indicator_table_eco.png"))
