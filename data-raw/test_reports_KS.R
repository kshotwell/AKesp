devtools::load_all()# remember to run this after every change!!!
`%>%` <- magrittr::`%>%`
library(tidyverse)
library(httr)
library(jsonlite)

# get fields ----
# simple function to get all the fields in the ESP webservice for data checking
get_all_esp <- function() {
  jsonlite::fromJSON(
    httr::content(
      httr::GET("https://apex.psmfc.org/akfin/data_marts/akmp/esp_indicators?"),
      as="text", encoding="UTF-8")) %>%
    dplyr::bind_rows() %>%
    rename_with(tolower)
}

esp <-get_all_esp()
# or just pop the url into a browser to see the column names https://apex.psmfc.org/akfin/data_marts/akmp/esp_indicators

# get stocks ----
# function to return a list of all stocks available on the webservice with data
esp_list <- esp_stock_options()

# get data ----
# function to return data frame of given esp stock for inspection
yr <- 2024 #use just for this year with crab stocks, delete when new changes have been implemented in database and substitute with internal code below

#use purrr here TBD - KS

# get data for a single ESP
dat <- get_esp_data(paste(esp_list[i,])) %>%
  check_data()
#%>%

# filter data from all indicators to a category
dat<-dat %>%
  dplyr::filter(INDICATOR_TYPE=="Ecosystem")

# filter dat from all indicators to a single indicator, specify name
dat<-dat %>%
  dplyr::filter(INDICATOR_NAME !="Annual_Red_King_Crab_CPUE_BBRKC_Fishery")%>%
  dplyr::filter(INDICATOR_NAME !="Annual_Red_King_Crab_Total_Potlift_BBRKC_Fishery")%>%
dplyr::filter(!(INDICATOR_NAME=="Annual_Red_King_Crab_Active_Vessels_BBRKC_Fishery" & DATA_VALUE<2))

# look at data ---
unique(dat$INDICATOR_NAME)
summary(dat)
esp_traffic(dat, skip_lines = TRUE, paginate = TRUE) #make sure data is plotting correctly
esp_traffic_tab(data = dat, year = (yr-4):yr)
#esp_traffic_tab(data = dat, year = (as.numeric(max(dat$SUBMISSION_YEAR))-4):as.numeric(max(dat$SUBMISSION_YEAR))) #make sure table look right
esp_overall_score(data=dat,species=paste(esp_list[i,]),region=" ")
esp_type_score(data=dat,species=paste(esp_list[i,]),region=" ")

# errata to be fixed in backend ----

#BS Snow crab, two indicators named Winter Sea Ice Advance BS Satellite, need the Copernicus one, use "dplyr::filter(DATA_SOURCE_NAME != "National Snow and Ice Data Center Sea Ice")" if can't fix

#EBS Pacific cod, two indicators named Winter Sea Ice Advance BS Satellite, need the National Snow and Ice one, use "dplyr::filter(DATA_SOURCE_NAME != "Copernicus Marine and Environment Monitoring Service")"
#EBS Pacific cod, two entries were uploaded for the same indicator, Summer Pacific cod adult EBS survey, one of the entries was the EBS and one was the GOA. The GOA needs to be backed out. The product and the indicator name don't match. If can't fix use "dplyr::filter(ESR != "Gulf of Alaska")" to get rid of this data

#BBRKC, active vessels has confidential data (when vessels less than one) that we cannot show so need to have a filter in the database for confidential data. If can't fix then use "dplyr::filter(!(INDICATOR_NAME=="Annual_Red_King_Crab_Active_Vessels_BBRKC_Fishery" & DATA_VALUE<2))". Also note that the current graphing function connects dots when there's no data so it looks odd for this one"

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
render_esp(esp_dir = here::here("data-raw/dev_2024/KS_reports"),
           out_name = paste0("report_card ", paste(esp_list[i,])," ", Sys.Date(), ".docx"),
           akfin_stock_name = paste(esp_list[i,]),
           # esp_data = dat,
           authors = "Erin Fedewa, Kalei Shotwell, Abby Tyrell",
           year = 2024,
           fish = paste(esp_list[i,]),
           region = "Bristol Bay",
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

esp_type_score(dat,paste(esp_list[i,]),"Eastern Bering Sea")

#Testing overall score function change to Type
esp_type_score <- function(data, species, region, out = "ggplot", name, ...) {
  dat <- data %>%
    prep_ind_data() %>%
    dplyr::filter(.data$YEAR >= 2000) %>%
    dplyr::group_by(.data$INDICATOR_TYPE, .data$YEAR) %>%
    dplyr::mutate(
      score = as.numeric(.data$score),
      mean_score = mean(.data$score, na.rm = TRUE)
    ) %>%
    dplyr::select(
      .data$YEAR, .data$INDICATOR_NAME,
      .data$INDICATOR_TYPE,
      .data$score, .data$mean_score
    ) %>%
    dplyr::distinct()

  dat$INDICATOR_NAME <- factor(dat$INDICATOR_TYPE,
                         levels = c(
                           "Ecosystem",
                           "Socioeconomic"
                         )
  )

  ymax <- max(abs(dat$mean_score))

  title <- paste("Overall Type Stage 1 Score for", region, species) %>%
    stringr::str_wrap(width = 40)

  plt <- ggplot2::ggplot(
    dat,
    ggplot2::aes(
      x = .data$YEAR,
      y = .data$mean_score,
      color = .data$INDICATOR_TYPE,
      shape = .data$INDICATOR_TYPE
    )
  ) +
    ggplot2::geom_hline(
      yintercept = 0,
      lty = "dashed"
    ) +
    ggplot2::geom_line() +
    ggplot2::geom_point() +
    ggplot2::ylab("Score") +
    ggplot2::xlab(ggplot2::element_blank()) +
    ggplot2::theme_bw(base_size = 16) +
    ggplot2::theme(
      legend.title = ggplot2::element_blank(),
      legend.position = "bottom",
      legend.direction = "vertical",
      plot.title = ggplot2::element_text(size = 14)
    ) +
    ggplot2::guides(color = ggplot2::guide_legend(ncol = 2)) +
    ggplot2::ggtitle(label = title) +
    ggplot2::ylim(-ymax, ymax) +
    ggplot2::facet_grid(rows = ggplot2::vars(.data$INDICATOR_TYPE))

  if (out == "save") {
    ggplot2::ggsave(plt, filename = name, ...)
  } else if (out == "ggplot") {
    print(plt)
    cat("\n\n")
  } else if (out == "one_pager") {
    return(plt)
  } else {
    stop("Please specify output format")
  }
}
