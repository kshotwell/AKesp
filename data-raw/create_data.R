sheetnames <- c(readxl::excel_sheets(here::here("data-raw/ESP_Indicators_2020.xlsx")))
sheetnames

for(i in sheetnames){

  code <- knitr::knit_expand(
    text =
      '{{name}} <- readxl::read_excel(here::here("data-raw/ESP_Indicators_2020.xlsx"), sheet = "{{name}}", col_types = "numeric", na = "NA"); usethis::use_data({{name}}, overwrite = TRUE)',
    name = i)

  eval(parse(text = code))

}

metric_panel <- read.csv(here::here("data-raw/panel5.csv"))
usethis::use_data(metric_panel)

bbrkc_long <- read.csv(here::here("data-raw/bbrkc_long.csv"))
usethis::use_data(bbrkc_long)
