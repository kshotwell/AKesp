---
title: "Appendix 1. Ecosystem and Socioeconomic Profile of the Sablefish stock in the Alaska - Report Card"
author: "Kalei Shotwell, Abby Tyrell"
date: "Draft 2021"
output: 
  bookdown::word_document2:
    reference_docx: "template.docx"
    fig_caption: false
    
# bibliography: references.bib

params:
  num: 1
  authors: "Kalei Shotwell, Abby Tyrell"
  year: 2021
  contributors: "Kalei Shotwell, Abby Tyrell"
  fish: "Myfish"
  region: "Myarea"
  stock_image: system.file('images/noaa.jpg', package = 'AKesp')
  esp_data: NULL
  con_model_path: system.file("images/noaa.jpg", package = "AKesp")
  bayes_path: system.file("images/noaa.jpg", package = "AKesp")
  ncolumn: 1
---



![](images/noaa.jpg)

*With Contributions from:*

Kalei Shotwell, Abby Tyrell

\newpage

# Current Year Update {-}

The ecosystem and socioeconomic profile or ESP is a standardized framework for compiling and evaluating relevant stock-specific ecosystem and socioeconomic indicators and communicating linkages and potential drivers of the stock within the stock assessment process (Shotwell et al., In Review). The ESP process creates a traceable pathway from the initial development of indicators to management advice and serves as an on-ramp for developing ecosystem-linked stock assessments. 
Please refer to the last full ESP and partial ESP documents for further information regarding the ecosystem and socioeconomic linkages for this stock (*list references*).

## Management Considerations {-}

Summary conclusions from ESP for ABC (risk table) 

## Modeling Considerations {-}

Summary of indicators with high importance in the Bayesian adaptive sampling routine and discussion of which indicators have had consistent high importance. 
List of research ecosystem model runs that are currently ongoing and potential for operational use in the future. 

# Assessment {-}

## Ecosystem and Socioeconomic Processes {-}

One paragraph description of ecosystem and socioeconomic (if available) conceptual model(s)

## Indicator Suite {-}

One paragraph description of LME level indicators relevant to stock (ESR summary)

### Ecosystem Indicators: {-}

1.) Physical Indicators

a.) Annual_Heatwave_GOA_Model: Annual marine heatwave index is calculated from daily sea surface temperatures for 1981 through present from the NOAA High-resolution Blended Analysis Data for the central GOA (< 300 m). Data source is the NOAA Optimum Interpolation Sea Surface Temperature (OISST) v2.1 from the NOAA Centers for Environmental Information (NCEI). Daily mean sea surface temperature data were processed to obtain the marine heatwave cumulative intensity (MHWCI) (Hobday et al., 2016) value where we defined a heat wave as 5 days or more with daily mean sea surface temperatures greater than the 90th percentile of the January 1983 through December 2012 time series. Spatial resolution is 5 km satellite sea surface temperatures aggregated over longitude -145 to -160 and depth <300m polygon followed by annual summation of a cumulative heatwave index in degree Celsius days in the Gulf of Alaska. (contact: Steve Barbeaux)

NA

b.) Spring_Temperature_Surface_EGOA_Satellite: Late spring (May-June) daily sea surface temperatures (SST) on a 5 km grid averaged over the eastern GOA (NMFS areas 640 and 650, no depth restriction) (Watson, 2020) from the NOAA Coral Reef Watch Program which provides the Global 5km Satellite Coral Bleaching Heat Stress Monitoring Product Suite Version 3.1, derived from CoralTemp v1.0. product (NOAA Coral Reef Watch, 2018), 1985 to present.

Code available at: https://github.com/jordanwatson/ESP_Indicators. (contact: Jordan Watson)

Despite marked inter-annual variability, there appears to only be a slight upward trend in the overall time series.

c.) Spring_Temperature_Surface_SEBS_Satellite: Late spring (May-June) daily sea surface temperatures (SST) on a 5 km grid averaged over the southeastern Bering Sea (deeper than 10 m) (Watson, 2020) from the NOAA Coral Reef Watch Program which provides the Global 5km Satellite Coral Bleaching Heat Stress Monitoring Product Suite Version 3.1, derived from CoralTemp v1.0. product (NOAA Coral Reef Watch, 2018), 1985 to present.

Code available at: https://github.com/jordanwatson/ESP_Indicators. (contact: Jordan Watson)

While inter-annual variability is evident, a generally increasing trend is apparent (from both linear and non-linear smoothers). However, a cold stanza is a dominant feature for a portion of the time series. Recent years appear remarkably warmer than the majority of the time series.

d.) Summer_Temperature_250m_GOA_Survey: Summer temperature profiles were recorded during the annual longline survey along the continental slope using an SBE39 (Seabird Electronics) attached to the groundline approximately one-third of the way in from the shallow portion of a station (Siwicke, In prep.). In the GOA, 13 stations had complete temperature profiles for the entire timeseries (2005–2019). Annual anomalies from the 15-year mean can be calculated by station at discrete depths, and an index for each year can be represented by the mean of these anomalies at a chosen depth. Interpolation between actual depth recordings in a profile was conducted using weighted parabolic interpolation (Reiniger and Ross, 1968). The 250 m isobath was selected to represent deeper water at the shelf-slope break where adult sablefish are typically sampled. Annual values come from this extent: Latitude (54.4 to 59.6) and Longitude (-157.8 to -134.0) and the survey is conducted by the Marine Ecology and Stock Assessment (MESA) program, Auke Bay Laboratories, Alaska Fisheries Science Center. (contact: Kevin Siwicke)

The 250-m slope temperature index is in prime sablefish habitat and has not deviated greatly from the long-term mean. However, this index has remained positive for the last five years, a deviation from the historical fluctuations around the mean, suggesting these deeper waters may remain somewhat warmer than average (~0.1°C) from 2017-2021.

### Socioeconomic Indicators: {-}


1.) Fishery Performance Indicators

a.) Annual_Sablefish_Condition_Female_Adult_BSAI_Fishery: Sablefish condition for large (>= 750 mm) female sablefish. Body condition was estimated using a length-weight relationship (Laman and Rohan, 2020) from data collected randomly by observers for otoliths in the BSAI fishery, 1999 to present. (contact: Jane Sullivan)

There has been no update to this indicator since 2016 due to lack of data.

b.) Annual_Sablefish_Condition_Female_Adult_GOA_Fishery: Sablefish condition for large (>= 750 mm) female sablefish. Body condition was estimated using a length-weight relationship (Laman and Rohan, 2020) from data collected randomly by observers for otoliths in the GOA fishery, 1999 to present. (contact: Jane Sullivan)

The 2021 condition index for large female sablefish in the fishery is the lowest for the time series.

c.) Annual_Sablefish_Incidental_Catch_BSAI_Fishery: Incidental catch estimates of sablefish in the Bering Sea fisheries excluding the sablefish fishery provided by AKFIN, 1992 to present. (contact: Kalei Shotwell)

NA

d.) Annual_Sablefish_Incidental_Catch_GOA_Fishery: Incidental catch estimates of sablefish in the GOA fisheries excluding the sablefish fishery provided by from AKFIN, 1992 to present. (contact: Kalei Shotwell)

NA

e.) Annual_Sablefish_Longline_CPUE_GOA_Fishery: Catch-per-unit-of-effort of sablefish in tons from the longline fisheries in the GOA, 1996 to present. (contact: Dan Goethel)

NA

f.) Annual_Sablefish_Pot_CPUE_EBS_Fishery: Catch per unit of effort of sablefish in tons estimated from the pot fisheries in the eastern Bering Sea, 1999 to present. (contact: Dan Goethel)

NA

## Indicator Monitoring Analysis {-}

References for statistical tests for monitoring indicator suite by stage where relevant 

### Beginning Stage: Traffic Light Test {-}

One paragraph summary of indicator status and trends over time and last five years trend
Report scores by category (if applicable) and overall ecosystem and socioeconomic indicators. 

### Intermediate Stage: Importance Test {-}

One paragraph summary of importance results with analysis of highly explanatory variables for stock assessment input of interest (e.g., recruitment estimates)

### Advanced Stage: Research Model Test {-}

Update on ecosystem linked model in development and link to relevant literature or report on model 

# Data Gaps and Future Research Priorities {-}

Copy from full ESP

\newpage

# Tables {-}














