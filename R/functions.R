#' Create an ESP report card
#'
#' This function creates an ESP report card from a template. If left empty, an example report will be created.
#' @param out_name The file name for the report
#' @param esp_dir The ESP will be saved here.
#' @param ... Parameters passed to the Rmarkdown. See details.
#' @param esp_data The data to use for automated analyses.
#'
#' @details Additional arguments are passed as parameters to the ESP Rmarkdown report.
#' @return
#' Suggestions for parameters are:
#' * num: The appendix number of the EPS
#' * authors: The names of the authors, as a single character string
#' * year: The year of the ESP
#' * contributors: The names of the contributors, as a single character string
#' * fish: The name of the fish species
#' * region: The name of the stock area
#' * fig_spreadsheet: The file path to the filled out figure spreadsheet (one of the template documents)
#' * tab_spreadsheet: The file path to the filled out table spreadsheet (one of the template documents)
#' * esp_text: The file path to the filled out text template (one of the template documents)
#' * esp_type: The type of ESP to make. One of c("full", "partial", "report_card")
#' * con_model_path: The path to the conceptual model. Currently only required for report card ESPs.
#' * stock_image: The path to an image to use on the cover page. Shows the NOAA logo as a default.
#' * bayes_path: The path to the image of Bayesian Adaptive Sampling results
#'
#' @export

render_esp <- function(
  out_name = "EXAMPLE-ESP.docx",
  esp_dir = getwd(),
  ...,
  esp_data = NULL
) {
  # create references.bib -- DEPRECATED
  # if (render_ref) {
  #   message("creating .bib file...")
  #   AKesp::render_ref(refs = ref_spreadsheet, dir = dir)
  # } else {
  #   file.create("references.bib") # empty dummy file
  # }

  args <- list(eval(quote(list(...))))
  # print(args)

  if (!is.null(esp_data)) {
    args[[1]]$esp_data <- substitute(esp_data)
  }
  # print(args)

  args <- unlist(args, recursive = FALSE)
  print(args)

  # if(!is.null(esp_data)) {
  #   args <- unlist(args)
  # }
  #
  # print(args)

  message("knitting ESP...")
  rmarkdown::render(
    system.file("report-card-template.Rmd", package = "AKesp"),
    clean = FALSE,
    params = args,
    output_file = here::here(esp_dir, out_name)
  )

  # clean = TRUE removes .bib file
  # delete files manually instead

  # file.remove(
  #   paste0(dir, "/esp-template.knit.md"),
  #   paste0(dir, "/esp-template.utf8.md"),
  #   paste0(dir, "/template.docx")
  # )
}


#' Render the figure section
#'
#' This function renders an ESP figure.
#' @param img The file path to a figure
#' @param lab The figure chunk label (keyword)
#' @param cap The figure caption
#' @param alt The figure alt text
#' @export

render_fig <- function(
  img, # the file path to the image
  lab = "no-name",
  cap = "no-caption",
  alt = "no-alt"
) {
  txt <- '```{r, {{label}}, fig.cap = "{{alttext}}"}
      knitr::include_graphics(path = "{{img}}")
      ```'

  message(img)

  if (stringr::str_detect(img, "system.file")) {
    img <- eval(parse(text = img))
  }

  res <- knitr::knit_child(
    text = knitr::knit_expand(
      text = txt,
      path = img,
      label = lab,
      caption = cap,
      alttext = alt
    ),
    quiet = TRUE
  )

  cat(
    res,
    knitr::knit_expand(
      text = "##### Figure \\@ref(fig:{{label}}). {{caption}} {-}",
      label = lab,
      caption = cap
    ),
    sep = "\n\n"
  )
}

#' Render the table section
#'
#' This function renders an ESP table.
#' @param tab The file path to a table
#' @param lab The table chunk label (keyword)
#' @param cap The table caption
#' @importFrom magrittr %>%
#' @export

render_tab <- function(
  tab, # the file path to the table
  lab = "no-name",
  cap = "no-caption"
) {
  res <- knitr::knit_child(
    text = knitr::knit_expand(
      text = '```{r, {{label}} }
      data <- read.csv(file = tab)
      flextable::flextable(data) %>%
          flextable::theme_vanilla() %>%
          flextable::set_caption(caption = "{{caption}}") %>%
          flextable::autofit()
      ```',
      label = lab,
      caption = cap
    ),
    quiet = TRUE
  )
  cat(res, sep = "\n\n")
}

#' Create `references.bib` from template spreadsheet - DEPRECATED
#'
#' This function creates `references.bib` from a template spreadsheet
#' @param refs The file path to a reference spreadsheet. Defaults to `references_spreadsheet.csv`.
#' @param dir The directory where references.bib should be saved. Only needed because of packaging issues.
#' @importFrom magrittr %>%
#' @export

render_ref <- function(
  refs = "references_spreadsheet.csv", # the file path to the reference spreadsheet
  dir # directory where references.bib should be saved.
) {
  data <- utils::read.csv(file = paste(dir, refs, sep = "/"))
  file <- paste0(dir, "/references.bib")
  # print(file)
  sink(file)

  for (i in 1:nrow(data)) {
    res <- knitr::knit_expand(
      text = "@article{ {{keyword}},
        author  = { {{authors}} },
        title   = { {{title}} },
        journal = { {{journal}} },
        year    = { {{year}} },
        number  = { {{issue}} },
        pages   = { {{pages}} },
        volume  = { {{volume}} }
      }",
      keyword = data$keyword[i],
      authors = data$authors[i],
      title = data$title[i],
      journal = data$journal[i],
      year = data$year[i],
      issue = data$issue[i],
      pages = data$pages[i],
      volume = data$volume[i]
    )
    cat(res, sep = "\n\n")
  }
  sink()
}

# render_ref(refs = here::here("inst/references_spreadsheet.csv"))
