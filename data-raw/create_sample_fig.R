
dat <- AKesp::get_esp_data("Alaska Sablefish") |>
  AKesp::check_data()

fig <- AKesp::esp_traffic(
  data = dat |>
    dplyr::filter(INDICATOR_NAME == "Annual_Copepod_Community_Size_EGOA_Survey"),
  paginate = FALSE,
  out = "one_pager",
  silent = TRUE
)

fig +
  ggplot2::theme(axis.title.x = ggplot2::element_blank(),
                 plot.background = ggplot2::element_rect(color='black'))

ggplot2::ggsave(here::here("inst/images/test_time_series.png"),
                width = 4.5,
                height = 2.5,
                unit = "in")
