devtools::load_all()
`%>%` <- magrittr::`%>%`

# get data ----
dat <- get_esp_data("BS Snow Crab") %>%
  check_data() %>%
  dplyr::mutate(INDICATOR_NAME = dplyr::case_when(
    INDICATOR_NAME == "Winter_Sea_Ice_Advance_BS_Satellite" ~ paste(INDICATOR_NAME, DATA_SOURCE_NAME, sep = "_"),
    TRUE ~ INDICATOR_NAME))

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
render_esp(esp_dir = here::here("data-raw/dev_2024"),
           out_name = paste0("report_card_", Sys.Date(), ".docx"),
           akfin_stock_name = "Alaska Sablefish",
           # esp_data = dat,
           authors = "Erin Fedewa, Kalei Shotwell, Abby Tyrell",
           year = 2023,
           fish = "Snow Crab",
           region = "Eastern Bering Sea",
           render_ref = FALSE#,
          # con_model_path = ...
          )

# ALL THE REPORT CARDS!
# broken maybe due to data problems, I can troubleshoot later --AT

akfin = c("Alaska Sablefish", #"BS Snow Crab",
          "Bristol Bay Red King Crab",
          "EBS Pacific Cod", "GOA Pacific Cod", "GOA Pollock",
          "St. Matthew Blue King Crab")
species = c("Sablefish", #"Snow Crab",
            "Red King Crab",
            "Pacific Cod", "Pacific Cod", "Pollock", "Blue King Crab")
stock = c("Alaska", #"Bering Sea",
          "Bristol Bay",
          "Eastern Bering Sea", "Gulf of Alaska", "Gulf of Alaska",
          "St. Matthew")

purrr::pwalk(list(akfin, species, stock), function(a, b, c){
  print(a)
  render_esp(
    esp_dir = here::here("data-raw/dev_2024"),
    out_name = paste0("report_card_", a, "_", Sys.Date(), ".docx"),
    akfin_stock_name = a,
    # esp_data = dat,
    authors = "Erin Fedewa, Kalei Shotwell, Abby Tyrell",
    year = 2023,
    fish = b,
    region = c,
    render_ref = FALSE
  )
})

