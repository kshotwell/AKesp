
devtools::load_all()
`%>%` <- magrittr::`%>%`

dat <- AKesp::get_esp_data("BS Snow Crab") %>%
  check_data()
esp_traffic_long(dat, paginate = TRUE)
esp_traffic_tab_long(data = dat, year = 2016:2021)

# sablefish (google example)
render_esp(out_dir = here::here("test"),
           esp_data = AKesp::get_esp_data("Alaska Sablefish"),
           con_model_path = "sablefish_con_model.png",
           stock_image = "sablefish.png",
           bayes_path = "sablefish_bayes.png",
           google_folder_url = "https://drive.google.com/drive/folders/1d7bzQfbDb5j-jTbb366vWtHpx5t8wxWe")

# snow crab!!
devtools::load_all()
# dir.create(here::here("snow_crab"))
# create_template(path = here::here("snow_crab"))

# need to fix fig heights, silence messages
# also need to add dummy traffic figures
render_esp(out_dir = here::here("snow_crab"),
           out_name = "snow_crab_test.docx",
           authors = "Erin Fedewa, Kalei Shotwell, Abby Tyrell",
           year = 2022,
           fish = "Snow Crab",
           region = "Eastern Bering Sea",

           tab_spreadsheet = here::here("snow_crab/snow_crab_table_spreadsheet.csv"),
           fig_spreadsheet = here::here("snow_crab/snow_crab_figure_spreadsheet.csv"),
           esp_text = here::here("snow_crab/snow-crab-full-esp-text-template.docx"),

           #esp_text = here::here("snow_crab/full-esp-text-template.docx"),
           esp_data = AKesp::get_esp_data("BS Snow Crab") %>% check_data(),

           con_model_path = here::here("snow_crab/images/snow-crab-con-model.png"),
           stock_image = here::here("snow_crab/images/alaska-snow-crab.png"),
           bayes_path = here::here("snow_crab/images/snow-crab-bayes-model.png"))

# test snow crab report card
render_esp(esp_type = "report_card",
           out_dir = here::here("test"),
           out_name = "snow_crab_test_rc.docx",
           esp_data = AKesp::get_esp_data("BS Snow Crab") %>% check_data(),
           authors = "Erin Fedewa, Kalei Shotwell, Abby Tyrell",
           year = 2022,
           fish = "Snow Crab",
           region = "Eastern Bering Sea",
           render_ref = FALSE)
