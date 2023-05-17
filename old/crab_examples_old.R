

# load package ----
devtools::load_all()
`%>%` <- magrittr::`%>%`

# get data ---- have three different calls for Crab ESPs, start here and change dat by ESP
# use unique(dat$INDICATOR_NAME) to find out the list of indicators in the dat

dat <- get_esp_data("Alaska Sablefish") %>%
  check_data()
unique(dat$INDICATOR_NAME)

dat <- get_esp_data("Bristol Bay Red King Crab") %>%
  check_data()
unique(dat$INDICATOR_NAME)

#use to filter out one year in particular
dat <- dat %>%
  dplyr::filter(!(INDICATOR_NAME=="Annual_Red_King_Crab_Active_Vessels_BBRKC_Fishery" & YEAR==2021))%>%
dplyr::filter(!(INDICATOR_NAME=="Annual_Red_King_Crab_Recruit_Abundance_BBRKC_Survey"))
unique(dat$INDICATOR_NAME)

#use to replace data in a specific column
dat["INDICATOR_NAME"][dat["INDICATOR_NAME"]=="Annual_Red_King_Crab_Recruit_Biomass_BBRKC_Model"]<-"Annual_Red_King_Crab_Recruit_Abundance_BBRKC_Survey"
unique(dat$INDICATOR_NAME)

#for looking at specific indicators
#dat <- dat %>%
#  dplyr::filter(INDICATOR_NAME=="Annual_Red_King_Crab_Recruit_Biomass_BBRKC_Model")

#use below if need to lag data by a constant, take comment (#) out if using
  #filter it out, mutate and subtract 1 across the year column, and make that a separate   dataframe (icatch here), then filter out the old version from the main datafram (dat in   this case), then rbind the new dataframe and main dataframe (icatch and dat)
#icatch <- dat %>%k
#  dplyr::filter(INDICATOR_NAME=="Annual_Red_King_Crab_Incidental_Catch_EBS_Fishery")%>%
#  dplyr::mutate(across(YEAR,~.-1))
#  dplyr::filter(!INDICATOR_NAME=="Annual_Red_King_Crab_Incidental_Catch_EBS_Fishery")
#dat <- rbind(dat,icatch)

dat <- get_esp_data("BS Snow Crab") %>%
  check_data()

#use to filter out a data source if getting double entries
dat <- dat %>%
  dplyr::filter(DATA_SOURCE_NAME != "National Snow and Ice Data Center Sea Ice")
unique(dat$INDICATOR_NAME)
unique(dat$REPORT_CARD_TITLE)

dat <- get_esp_data("EBS Pacific Cod") %>%
  check_data()
dat <- dat %>%
  dplyr::filter(DATA_SOURCE_NAME != "Copernicus Marine and Environment Monitoring Service")
unique(dat$INDICATOR_NAME)

#write out a csv file
write.csv(dat,"C:\\Users\\kalei.shotwell\\Downloads\\ESP\\MODEL\\2022\\ebspcod22.csv",row.names=FALSE)

# a generic figure ----
esp_traffic(dat, paginate = TRUE)

# a generic table ----
esp_traffic_tab(data = dat, year = 2017:2022)

# make a folder to save stuff in
dir.create(here::here("play/smbkc_2022"))

# a one pager ----
AKesp::one_pager(data = dat %>%
                   dplyr::filter(INDICATOR_TYPE == "Ecosystem") %>%
                   dplyr::mutate(UNITS = ""),
                 overall_data = dat,
                 years = 2017:2022,
                 bayes_path = here::here("old/snow_crab/images/snow-crab-bayes-model.png"),
                 output_name = here::here("snow_crab_workshop/snow_crab_one_pager.pdf")
)

# a report card ----
render_esp(esp_type = "report_card",
           out_dir = here::here("play/sablefish_2022"),
           out_name = "sablefish_2022_rc.docx",
           esp_data = AKesp::get_esp_data("Alaska Sablefish") %>% check_data(),
           authors = "Kalei Shotwell",
           year = 2022,
           fish = "Alaska Sablefish",
           region = "Bering Sea Aleutian Islands and Gulf of Alaska",
           render_ref = FALSE)

# a full ESP ----

## template creation example
dir.create(here::here("test"))
create_template(path = here::here("test"))
setwd(here::here("test"))

## knit the ESP based off of existing info
render_esp(out_dir = here::here("test"),
           # working_dir = here::here("test"),
           out_name = "test_ESP.docx",
           authors = "Erin Fedewa, Kalei Shotwell, Brian Garber Yonts",
           year = 2022,
           fish = "Red King Crab",
           region = "Bristol Bay",
           esp_type = "full",

           tab_spreadsheet = here::here("test/snow_crab_table_spreadsheet.csv"),
           fig_spreadsheet = here::here("test/snow_crab_figure_spreadsheet.csv"),
           esp_text = here::here("test/snow-crab-full-esp-text-template.docx"),

           esp_data = AKesp::get_esp_data("Alaska Sablefish") %>% check_data(),
           # esp_data = AKesp::get_esp_data("BS Snow Crab") %>% check_data(),

           con_model_path = here::here("test/images/snow-crab-con-model.png"),
           stock_image = here::here("test/images/alaska-snow-crab.png"),
           bayes_path = here::here("test/images/snow-crab-bayes-model.png"),

           render_ref = FALSE)

dat <- AKesp::get_esp_data("BS Snow Crab") %>%
  check_data()
esp_traffic_tab(data = dat, year = 2018:2022)

