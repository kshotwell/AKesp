# example rendering of ESP report card

# remove package before re-installing
remove.packages("AKesp")
# install package
devtools::install_github("atyrell3/AKesp", upgrade = "never")

# score is calculated by the functions
# can change where output renders - defaults to working directory
# replace dummy figure paths with path to real figures (suggest to use `here` package)
# figure captions/numbers are not perfect, but should at least be a good starting point
# sample text was copied from the sablefish report card
rmarkdown::render(system.file("esp-report-card-template.Rmd",
  package = "AKesp"
  ),
  output_dir = getwd(),
  params = list(
    esp_data = AKesp::get_esp_data("Alaska Sablefish"),
    fish = "Sablefish",
    region = "Alaska",
    stock_image = here::here("inst/images/noaa.jpg"),
    con_model_path = here::here("inst/images/noaa.jpg"),
    bayes_path = here::here("inst/images/noaa.jpg")
  )
)

# goa pcod
rmarkdown::render(system.file("esp-report-card-template.Rmd",
                              package = "AKesp"
  ),
  output_dir = getwd(),
  params = list(
    esp_data = AKesp::get_esp_data("GOA Pacific Cod"),
    fish = "Pacific Cod",
    region = "GOA",
    stock_image = here::here("inst/images/noaa.jpg"),
    con_model_path = here::here("inst/images/noaa.jpg"),
    bayes_path = here::here("inst/images/noaa.jpg")
  )
)

# AKesp::bbrkc_long
# can change where output renders - defaults to working directory
# replace dummy figure paths with path to real figures (suggest to use `here` package)
# figure captions/numbers are not perfect, but should at least be a good starting point
# sample text was copied from the sablefish report card
rmarkdown::render(system.file("esp-report-card-template.Rmd",
  package = "AKesp"
  ),
  output_dir = getwd(),
  params = list(
    esp_data = AKesp::bbrkc_long,
    fish = "Red King Crab",
    region = "Bristol Bay",
    stock_image = here::here("inst/images/noaa.jpg"),
    con_model_path = here::here("inst/images/noaa.jpg"),
    bayes_path = here::here("inst/images/noaa.jpg")
  )
)
