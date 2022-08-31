#Update look-up table, will not need this after add Indicator_Order in BYOD on AKFIN
#First update the file in data-raw/ESP_Lookup_Order.csv
#Then run the following code

indicator_order <- read.csv(here::here("data-raw/ESP_Lookup_Order.csv"))
usethis::use_data(indicator_order, overwrite = TRUE)
roxygen2::roxygenise()
devtools::load_all()
