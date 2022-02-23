
# query data
dat <- AKesp::get_esp_data("Alaska Sablefish")
head(dat)

# make a figure
AKesp::esp_traffic_long(
  data = dat,
  paginate = TRUE,
  out = "ggplot",
  silent = TRUE
)

# make a table
AKesp::esp_traffic_tab_long(dat, year = 2017:2021)

# render a skeleton report
rmarkdown::render(system.file("esp-report-card-template.Rmd",
                              package = "AKesp"
                              ),
                  output_dir = getwd(),
                  output_file = "NMFS-R-example.docx",
                  params = list(
                    esp_data = dat,
                    fish = "Sablefish",
                    region = "Alaska",
                    stock_image = here::here("inst/images/noaa.jpg"),
                    con_model_path = here::here("inst/images/noaa.jpg"),
                    bayes_path = here::here("inst/images/noaa.jpg")
                    )
                  )
