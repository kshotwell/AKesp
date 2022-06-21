# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline # nolint

# Load packages required to define the pipeline:
library(targets)
# library(tarchetypes) # Load other packages as needed. # nolint

# Set target options:
targets::tar_option_set(envir = getNamespace("AKesp"),
                        packages = "AKesp",
                        imports = "AKesp")
library(AKesp)

### Targets pipeline for sablefish partial ESP ----

# create file template
# dir.create(here::here("reports/sablefish_2022"))
# create_template(path = here::here("reports/sablefish_2022"),
#                 type = "partial")

# Target list:
list(

  ## pull data and check
  targets::tar_target(initial_data, get_esp_data("Alaska Sablefish")),
  targets::tar_target(sablefish_data, check_data(initial_data)),

  ## watch all files
  targets::tar_target(tables_csv,
                      here::here("sablefish_2022/table_spreadsheet.csv"),
                      format = "file"),
  targets::tar_target(figs_csv,
                      here::here("sablefish_2022/figure_spreadsheet.csv"),
                      format = "file"),
  targets::tar_target(text_docx,
                      here::here("sablefish_2022/partial-esp-text-template.docx"),
                      format = "file"),
  targets::tar_target(con_png,
                      here::here("sablefish_2022/images/noaa.jpg"),
                      format = "file"),
  targets::tar_target(stock_png,
                      here::here("sablefish_2022/images/noaa.jpg"),
                      format = "file"),
  targets::tar_target(bayes_png,
                      here::here("sablefish_2022/images/noaa.jpg"),
                      format = "file"),

  ## render ESP
  targets::tar_target(esp,
                      { render_esp(out_dir = here::here("sablefish_2022"),
                                  out_name = "sablefish_test.docx",
                                  authors = "Kalei Shotwell, Abby Tyrell",
                                  year = 2022,
                                  fish = "Sablefish",
                                  region = "Alaska",
                                  esp_type = "partial",

                                  tab_spreadsheet = tables_csv,
                                  fig_spreadsheet = figs_csv,
                                  esp_text = text_docx,

                                  esp_data = sablefish_data,

                                  con_model_path = con_png,
                                  stock_image = stock_png,
                                  bayes_path = bayes_png)
                      })
)

# targets::tar_visnetwork()
