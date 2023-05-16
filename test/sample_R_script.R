
# load package ----
devtools::load_all()
`%>%` <- magrittr::`%>%`
# dir.create(here::here("test")) # test folder

# get data ----
dat <- get_esp_data("Alaska Sablefish") %>%
  check_data()

# full esp ----
create_template(path = here::here("test"))
render_esp(esp_dir = here::here("test"),
           # working_dir = here::here("test"),
           out_name = "test_full_ESP.docx",
           authors = "Erin Fedewa, Kalei Shotwell, Brian Garber Yonts",
           year = 2022,
           fish = "Red King Crab",
           region = "Bristol Bay",
           esp_type = "full",

           tab_spreadsheet = here::here("test/snow_crab_table_spreadsheet.csv"),
           fig_spreadsheet = here::here("test/snow_crab_figure_spreadsheet.csv"),
           esp_text = here::here("test/snow-crab-full-esp-text-template.docx"),

           esp_data = dat,

           con_model_path = here::here("test/images/snow-crab-con-model.png"),
           stock_image = here::here("test/images/alaska-snow-crab.png"),
           bayes_path = here::here("test/images/snow-crab-bayes-model.png"),

           render_ref = FALSE)

# a report card ----
render_esp(esp_type = "report_card",
           esp_dir = here::here("test"),
           out_name = "test_rc_ESP.docx",

           esp_data = dat,

           authors = "Kalei Shotwell",
           year = 2022,
           fish = "Alaska Sablefish",
           region = "Bering Sea Aleutian Islands and Gulf of Alaska",
           render_ref = FALSE)

# a one pager ----
AKesp::one_pager(data = dat %>%
                   dplyr::filter(CATEGORY == "Upper Trophic") %>%
                   dplyr::mutate(UNITS = ""),
                 overall_data = dat,
                 years = 2018:2022,
                 bayes_path = here::here("test/images/snow-crab-bayes-model.png"),
                 output_name = here::here("test/test_1pg_ESP.pdf")
)

