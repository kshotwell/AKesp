
color_key <- read.csv(here::here("data-raw/color_key.csv"))

usethis::use_data(color_key, overwrite = TRUE)
