#' Create an ESP template
#'
#' This function creates an ESP template at the specified path.
#' @param path Where to create the template. Defaults to the present working directory.
#' @param type The type of template. One of c("full", "partial", "report card", "one pager")
#' @export


create_template <- function(path = getwd(),
                            type = "full") {
  file.copy(
    from = system.file(c("images", "tables", "figure_spreadsheet.csv", "table_spreadsheet.csv", "references_spreadsheet.csv"),
      package = "AKesp"
    ),
    to = path,
    recursive = TRUE,
    overwrite = TRUE
  )
  if (type == "full") {
    file.copy(
      from = system.file("full-esp-text-template.docx",
        package = "AKesp"
      ),
      to = path
    )
  } else if (type == "partial") {
    file.copy(
      from = system.file("partial-esp-text-template.docx",
        package = "AKesp"
      ),
      to = path
    )
  } else {
    stop("That template doesn't exist yet!")
  }
}

#' Create an ESP
#'
#' This function creates an ESP from a template. If left empty, an example report will be created.
#' @param out_name The file name for the report
#' @param out_dir The directory to save the ESP in.
#' @param num The appendix number of the EPS
#' @param authors The names of the authors, as a single character string
#' @param year The year of the ESP
#' @param contributors The names of the contributors, as a single character string
#' @param fish The name of the fish species
#' @param region The name of the stock area
#' @param fig_spreadsheet The file path to the filled out figure spreadsheet (one of the template documents)
#' @param tab_spreadsheet The file path to the filled out table spreadsheet (one of the template documents)
#' @param ref_spreadsheet The file path to the filled out references spreadsheet (one of the template documents)
#' @param esp_text The file path to the filled out text template (one of the template documents)
#' @param esp_type The type of ESP to make. One of c("full", "partial", "report card", "one pager")
#' @param esp_data The data to use for automated analyses. Currently only required for report card ESPs.
#' @param con_model_path The path to the conceptual model. Currently only required for report card ESPs.
#' @param stock_image The path to an image to use on the cover page. Shows the NOAA logo as a default.
#' @export

render_esp <- function(out_name = "EXAMPLE-FULL-ESP.docx",
                       out_dir = getwd(),
                       num = 1, # Appendix number
                       authors = "Kalei Shotwell, Abby Tyrell",
                       year = 2021,
                       contributors = "Kalei Shotwell, Abby Tyrell",
                       fish = "Myfish",
                       region = "Myarea",
                       fig_spreadsheet = "figure_spreadsheet.csv",
                       tab_spreadsheet = "table_spreadsheet.csv",
                       ref_spreadsheet = "references_spreadsheet.csv",
                       esp_text = "full-esp-text-template.docx",
                       esp_type = "full",
                       esp_data = NULL,
                       con_model_path = "default",
                       stock_image = "default",
                       bayes_path = "default",
                       google_folder_url = NULL
                       ) {
  # if using a google folder, download files and point to temp folder

  if(!is.null(google_folder_url)){
    # download files
    google <- use_google_files(google_folder_url,
                               overwrite = TRUE)

    # reassign file paths to point to temp folder downloads

    fig_spreadsheet <- paste(google, fig_spreadsheet, sep = "/")
    tab_spreadsheet <- paste(google, tab_spreadsheet, sep = "/")
    ref_spreadsheet <- paste(google, ref_spreadsheet, sep = "/")
    esp_text <- paste(google, esp_text, sep = "/")

    if(stock_image != "default"){
      stock_image <- paste(google, stock_image, sep = "/")
    }

    if(con_model_path != "default"){
      con_model_path <- paste(google, con_model_path, sep = "/")
    }

    if(bayes_path != "default"){
      bayes_path <- paste(google, bayes_path, sep = "/")
    }

    dir <- google
  } else { dir <- out_dir }

  # create references.bib
 # message(getwd())
  message("creating .bib file...")
  AKesp::render_ref(refs = ref_spreadsheet, dir = dir)

  args <- list(
    num, authors, year, contributors, fish, region,
    fig_spreadsheet, tab_spreadsheet, esp_text, esp_type,
    esp_data, con_model_path, bayes_path, stock_image
  )
  names(args) <- c(
    "num", "authors", "year", "contributors", "fish", "region",
    "fig_spreadsheet", "tab_spreadsheet", "esp_text", "esp_type",
    "esp_data", "con_model_path", "bayes_path", "stock_image"
  )

  message("knitting ESP...")
  rmarkdown::render(system.file("esp-template.Rmd",
    package = "AKesp"
  ),
  clean = FALSE,
  params = args,
  output_file = out_name,
  #  knit_root_dir = dir,
  output_dir = out_dir,
  intermediates_dir = dir
  )

  if(!is.null(google_folder_url)){
    unlink(google)
    message("Downloaded google files successfully removed!")
  }

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

render_fig <- function(img, # the file path to the image
                       lab = "no-name",
                       cap = "no-caption",
                       alt = "no-alt") {
  txt <- '```{r, {{label}}, fig.cap = "{{alttext}}"}
      knitr::include_graphics(path = "{{path}}")
      ```'

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

  cat(res,
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

render_tab <- function(tab, # the file path to the table
                       lab = "no-name",
                       cap = "no-caption") {
  res <- knitr::knit_child(
    text = knitr::knit_expand(
      text =
        '```{r, {{label}} }
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

#' Create `references.bib` from template spreadsheet
#'
#' This function creates `references.bib` from a template spreadsheet
#' @param refs The file path to a reference spreadsheet. Defaults to `references_spreadsheet.csv`.
#' @param dir The directory where references.bib should be saved. Only needed because of packaging issues.
#' @importFrom magrittr %>%
#' @export

render_ref <- function(refs = "references_spreadsheet.csv", # the file path to the reference spreadsheet
                       dir # directory where references.bib should be saved. only needed because of packaging issues
) {
  data <- utils::read.csv(file = paste(dir, refs, sep = "/"))
  file <- paste0(dir, "/references.bib")
 # print(file)
  sink(file)

  for (i in 1:nrow(data)) {
    res <- knitr::knit_expand(
      text =
        "@article{ {{keyword}},
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
