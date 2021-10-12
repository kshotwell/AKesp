tab <- AKesp::esp_traffic_tab(data = AKesp::sablefish,
                              year = 2016:2020)
flextable::save_as_image(tab, path = "sample-sablefish-table.png")
