`%>%` <- magrittr::`%>%`

# load package ----
devtools::load_all()
`%>%` <- magrittr::`%>%`

# get data ----
dat <- get_esp_data("BS Snow Crab") %>%
  check_data() %>%
  dplyr::mutate(INDICATOR_NAME = dplyr::case_when(
    INDICATOR_NAME == "Winter_Sea_Ice_Advance_BS_Satellite" ~ paste(INDICATOR_NAME, DATA_SOURCE_NAME, sep = "_"),
    TRUE ~ INDICATOR_NAME))

# a generic figure ----
esp_traffic(dat, paginate = TRUE)

# a generic table ----
esp_traffic_tab(data = dat, year = 2018:2023)

# make a folder to save stuff in
dir.create(here::here("snow_crab_workshop"))

# a one pager ----
AKesp::one_pager(data = dat %>%
                   dplyr::filter(INDICATOR_TYPE == "Ecosystem") %>%
                   dplyr::mutate(UNITS = ""),
                 overall_data = dat,
                 years = 2018:2023,
                 bayes_path = here::here("old/snow_crab/images/snow-crab-bayes-model.png"),
                 output_name = here::here(paste0("old/snow_crab_workshop/snow_crab_one_pager_",
                                                 Sys.Date(), ".pdf"))
                 )

# a report card ----
devtools::load_all()
render_esp(esp_type = "report_card",
           esp_dir = here::here("old/snow_crab_workshop"),
           out_name = paste0("snow_crab_workshop_rc_", Sys.Date(), ".docx"),
           esp_data = dat,
           authors = "Erin Fedewa, Kalei Shotwell, Abby Tyrell",
           year = 2023,
           fish = "Snow Crab",
           region = "Eastern Bering Sea",
           render_ref = FALSE)

# a full ESP ----

## template creation example
create_template(path = here::here("snow_crab_workshop"))

## knit the ESP based off of existing info
render_esp(out_dir = here::here("snow_crab_workshop"),
           out_name = "snow_crab_test.docx",
           authors = "Erin Fedewa, Kalei Shotwell, Abby Tyrell",
           year = 2022,
           fish = "Snow Crab",
           region = "Eastern Bering Sea",

           tab_spreadsheet = here::here("old/snow_crab/snow_crab_table_spreadsheet.csv"),
           fig_spreadsheet = here::here("old/snow_crab/snow_crab_figure_spreadsheet.csv"),
           esp_text = here::here("old/snow_crab/snow-crab-full-esp-text-template.docx"),

           esp_data = AKesp::get_esp_data("BS Snow Crab") %>% check_data(),

           con_model_path = here::here("old/snow_crab/images/snow-crab-con-model.png"),
           stock_image = here::here("old/snow_crab/images/alaska-snow-crab.png"),
           bayes_path = here::here("old/snow_crab/images/snow-crab-bayes-model.png"))


