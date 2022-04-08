
devtools::load_all()

# sablefish (google example)
render_esp(out_dir = here::here("test"),
           esp_data = AKesp::get_esp_data("Alaska Sablefish"),
           con_model_path = "sablefish_con_model.png",
           stock_image = "sablefish.png",
           bayes_path = "sablefish_bayes.png",
           google_folder_url = "https://drive.google.com/drive/folders/1d7bzQfbDb5j-jTbb366vWtHpx5t8wxWe")

# snow crab!!
dir.create(here::here("snow_crab"))
create_template(path = here::here("snow_crab"))
render_esp(out_dir = here::here("snow_crab"),
           out_name = "snow_crab_test.docx",
           authors = "Erin Fedewa, Kalei Shotwell, Abby Tyrell",
           year = 2022,
           fish = "Snow Crab",
           region = "Eastern Bering Sea",
           esp_data = AKesp::get_esp_data("BS Snow Crab"))
