

# load package ----
devtools::load_all()
`%>%` <- magrittr::`%>%`

# get data ---- have three different calls for Crab ESPs, start here and change dat by ESP
dat <- get_esp_data("St. Matthew Blue King Crab") %>%
  check_data()
dat <- get_esp_data("Bristol Bay Red King Crab") %>%
  check_data()
dat <- get_esp_data("BS Snow Crab") %>%
  check_data()
dat <- get_esp_data("Alaska Sablefish") %>%
  check_data()

# a generic figure ----
esp_traffic(dat, paginate = TRUE)

# a generic table ----
esp_traffic_tab(data = dat, year = 2017:2022)

# make a folder to save stuff in
dir.create(here::here("bbrkc_2022"))

# a one pager ----
AKesp::one_pager(data = dat %>%
                   dplyr::filter(INDICATOR_TYPE == "Ecosystem") %>%
                   dplyr::mutate(UNITS = ""),
                 overall_data = dat,
                 years = 2016:2021,
                 bayes_path = here::here("old/snow_crab/images/snow-crab-bayes-model.png"),
                 output_name = here::here("snow_crab_workshop/snow_crab_one_pager.pdf")
)

# a report card ----
render_esp(esp_type = "report_card",
           out_dir = here::here("bbrkc_2022"),
           out_name = "bbrkc_2022_rc.docx",
           esp_data = dat,
           authors = "Erin Fedewa, Kalei Shotwell, Brian Garber Yonts",
           year = 2022,
           fish = "Red King Crab",
           region = "Bristol Bay",
           render_ref = FALSE)

# a full ESP ----

## template creation example
create_template(path = here::here("bbrkc_2022"))

## knit the ESP based off of existing info
render_esp(out_dir = here::here("bbrkc_2022"),
           out_name = "bbrkc_2022.docx",
           authors = "Erin Fedewa, Kalei Shotwell, Brian Garber Yonts",
           year = 2022,
           fish = "Red King Crab",
           region = "Bristol Bay",

           tab_spreadsheet = here::here("old/snow_crab/snow_crab_table_spreadsheet.csv"),
           fig_spreadsheet = here::here("old/snow_crab/snow_crab_figure_spreadsheet.csv"),
           esp_text = here::here("old/snow_crab/snow-crab-full-esp-text-template.docx"),

           esp_data = AKesp::get_esp_data("BS Snow Crab") %>% check_data(),

           con_model_path = here::here("old/snow_crab/images/snow-crab-con-model.png"),
           stock_image = here::here("old/snow_crab/images/alaska-snow-crab.png"),
           bayes_path = here::here("old/snow_crab/images/snow-crab-bayes-model.png"))


