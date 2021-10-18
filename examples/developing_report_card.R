# example rendering of ESP report card

# score is calculated by the functions
# report renders in the `inst` folder (can change later)
# replace dummy figure paths with path to real figures (path relative to `inst` folder)
# figure captions/numbers are not perfect, but should at least be a good starting point
# sample text was copied from the sablefish report card
devtools::load_all()
rmarkdown::render(here::here("inst/esp-report-card-template.Rmd"),
                  clean = FALSE,
                  params = list(esp_data = get_esp_data("Alaska Sablefish"),
                                fish = "Sablefish",
                                region = "Alaska",
                                stock_image = "images/noaa.jpg",
                                con_model_path = "images/noaa.jpg",
                                bayes_path = "images/noaa.jpg"))


# AKesp::bbrkc_long is the only data I have that has the `SCORE` column
# report renders in the `inst` folder (can change later)
# replace dummy figure paths with path to real figures (path relative to `inst` folder)
# figure captions/numbers are not perfect, but should at least be a good starting point
# sample text was copied from the sablefish report card
devtools::load_all()
rmarkdown::render(here::here("inst/esp-report-card-template.Rmd"),
                  clean = FALSE,
                  params = list(esp_data = AKesp::bbrkc_long,
                                fish = "Red King Crab",
                                region = "Bristol Bay",
                                stock_image = "images/noaa.jpg",
                                con_model_path = "images/noaa.jpg",
                                bayes_path = "images/noaa.jpg"
                                )
                  )
