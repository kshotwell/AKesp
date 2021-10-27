library(AKesp)
devtools::load_all()

sheetnames <- c(readxl::excel_sheets(here::here("data-raw/ESP_Indicators_2020.xlsx")))
sheetnames

names <- list(sheetnames)

my_save <- function(x) {
  data <- get(x)
  sinew::makeOxygen(data)

  print(x)
}

sink("R/data.R")
lapply(sheetnames, my_save)
sink()

sink("R/data2.R")
my_save("indicator_order")
sink()
