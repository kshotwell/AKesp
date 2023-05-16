---
title: "Appendix 1. Ecosystem and Socioeconomic Profile of the Red King Crab stock in the Bristol Bay "
author: "Erin Fedewa, Kalei Shotwell, Brian Garber Yonts"
date: "Draft 2022"
output: 
  bookdown::word_document2:
    reference_docx: "template.docx" 
    fig_caption: false
    
bibliography: references.bib

params:
  num: 1
  authors: "Kalei Shotwell, Abby Tyrell"
  year: 2022
  contributors: "Kalei Shotwell, Abby Tyrell"
  fish: "Myfish"
  region: "Myarea"
  region_abbreviation: "Myabbrev"
  fig_spreadsheet: 
  tab_spreadsheet: 
  esp_text: 
  stock_image: "default"
  esp_data: NULL
  con_model_path: "default"
  bayes_path: "default"
  ncolumn: 1
  min_year: NULL
  working_dir:
  esp_type: "full"
---



![](C:/Users/abigail.tyrell/Documents/ESP/AKesp/old/snow_crab/images/alaska-snow-crab.png)

*With Contributions from:*

Kalei Shotwell, Abby Tyrell

\newpage



# Executive Summary {-}

National initiatives and North Pacific Fishery Management Council (NPFMC) recommendations suggest a high priority for conducting an ecosystem and socioeconomic profile (ESP) for the Bristol Bay (Myabbrev) Red King Crab stock. In addition, annual guidelines for the Alaska Fisheries Science Center (AFSC) support research that improves our understanding of environmental and climate forcing of ecosystem processes with a focus on variables that can provide direct input into or improve stock assessment and management. The Myabbrev Red King Crab ESP follows the new standardized framework for evaluating ecosystem and socioeconomic considerations for Myabbrev Red King Crab, and may be considered a proving ground for potential use in the main stock assessment.

We use information from a variety of data streams available for the Myabbrev Red King Crab stock and present results of applying the ESP process through a metric and subsequent indicator assessment. Analysis of the ecosystem and socioeconomic processes for Myabbrev Red King Crab by life history stage along with information from the literature identified a suite of indicators for testing and continued monitoring within the ESP. Results of the metric and indicator assessment are summarized below as ecosystem and socioeconomic considerations that can be used for evaluating concerns in the main stock assessment or other management decisions.

## Management Considerations {-}

The following are the summary considerations from the current updates to the ecosystem and socioeconomic indicators evaluated for Myabbrev Red King Crab:

Summary of ecosystem and socioeconomic conclusions from metric or indicator assessment 

## Modeling Considerations {-}

The following are the summary considerations from the intermediate and advanced stage monitoring analyses for Myabbrev Red King Crab:

Summary conclusions from metric assessment or indicator assessment

## Responses to SSC and Plan Team Comments on ESPs in General {-}

“Regarding ESPs in general, the SSC recommends development of a method to aggregate indices into a score that could be estimated over time and compared to stock history. One potential pathway forward may be to normalize and use an unweighted sum of all the indicators where all time series overlap, or just assign +1 or -1 to each indicator so that a neutral environment would be zero.” (SSC, February 2020)

“The JPT were in support of the current templates and the current 3-stage indicator analysis, but noted concerns of over-emphasizing weighting in the first stage and recommended that indicators should be appropriately caveated to not over-generalize indicators across species. The JPT also fully supported the development of the ESP dashboard on AFKIN that includes metadata for each data source, but suggested a staged approach to the integration of data that have not been thoroughly vetted and published.

The SSC endorses the recommendations, comments, and suggestions from the JPT, all of which are consistent with previous SSC recommendations and guidance.” (SSC, October 2020)

We provide a simple score following the SSC recommendation and compare the weighting of indicators in the “Beginning Stage: Traffic Light Test” with the results of the “Intermediate Stage, Importance Test” section. In the intermediate stage we use a Bayesian Adaptive Sampling (BAS) method that produces inclusion probabilities for a subset of indicators with the most potential for informing a stock assessment parameter of interest (e.g., recruitment). This second stage may provide insight on how to weigh the indicators in the beginning stage for a more informed score. 

We have also initiated a new document called the request for indicators or RFI to initiate the ESP process once an ESP is recommended for a stock. The RFI begins with a summary of the dominant ecosystem and socioeconomic processes influencing the stock and then provides the requested list of potential indicators representing those dominant pressures. Instructions for how to contribute an indicator in response to the stock request are included along with details on the indicator review process and associated guideline criteria, the role and responsibilities of ESP teams and contributors, and use and acknowledgement of the indicator if selected for the ESP. The standardized structure of the RFIs and the included guideline criteria will help with vetting indicators and assist with the review of indicators by the ESP teams. A RFI was created for Myabbrev Red King Crab in September 2021 and presented to the Crab Plan Team. We plan to update this RFI with information from the "Data Gaps and Research Priorities" section for the next ESP cycle in 2023. 

“In general, however, the SSC recommends the continued inclusion of community engagement and dependency indices at varying scales in ESPs, ESRs, and SAFEs. For ESPs specifically, changes in patterns of community engagement and dependency at the stock level have the potential to inform not only stock assessments and analyses that support fishery management, but they may also function as early indicators of larger ecosystem changes.” (SSC, December 2020)

Community indicators are currently available in the Annual Community and Participation Overview (ACEPO) report (Wise et al., 2021), that presents social and economic information for communities that are substantially engaged in the commercial groundfish and crab fisheries in Alaska. Moving forward, we plan to include socioeconomic indicators in the ESP that reflect the condition or health of the stock and will be evaluating how to reference the products available in the ACEPO report with what might inform on stock health. We plan to address this in the next full or partial ESP for Myabbrev Red King Crab.

## Responses to SSC and Plan Team Comments Specific to this ESP {-}

"The SSC noted the relatively strong correlations for snow crab and BBRKC with the Arctic Oscillation, and suggests this could be further explored to determine the mechanism. The SSC requests that the CPT or the crab assessment authors examine recruitment estimates across crab stocks to see if they share a common underlying pattern. The SSC recommends that an Ecosystem and Socioeconomic Profile (ESP) be developed for EBS snow crab as time allows that carefully considers what indicators directly affect this stock" (SSC, October 2020, pg. 16)

We have developed this full ESP for Myabbrev Red King Crab following the standardized ESP template detailed in [Shotwellinreview] as recommended by the SSC. 

# Introduction {-}

Ecosystem-based science is becoming a component of effective marine conservation and resource management; however, the gap remains between conducting ecosystem research and integrating it with the stock assessment. A consistent approach has been lacking for deciding when and how to incorporate ecosystem and socioeconomic information into a stock assessment and how to test the reliability of this information for identifying future change. This new standardized framework termed the ecosystem and socioeconomic profile (ESP) has recently been developed to serve as a proving ground for testing ecosystem and socioeconomic linkages within the stock assessment process [Shotwellinreview]. The ESP uses data collected from a variety of national initiatives, literature, process studies, and laboratory analyses in a four-step process to generate a set of standardized products that culminate in a focused, succinct, and meaningful communication of potential drivers on a given stock. The ESP process and products are supported in several strategic documents (Sigleretal2017; Lynchetal2018) and recommended by the NPFMC groundfish and crab Plan Teams and the Scientific and Statistical Committee (SSC).

This ESP for Myabbrev Red King Crab (Chionoecetes opilio) follows the template for ESPs [Shotwellinreview] and replaces the previous ecosystem considerations section in the main Myabbrev Red King Crab stock assessment and fishery evaluation (SAFE) report. Information from the original ecosystem considerations section may be found in Szuwalski (2021). 

The ESP process consists of the following four steps: 

Evaluate national initiative and stock assessment classification scores [Lynchetal2018] along with regional research priorities to assess the priority and goals for conducting an ESP. 

Perform a metric assessment to identify potential vulnerabilities and bottlenecks throughout the life history of the stock and provide mechanisms to refine indicator selection. 

Select a suite of indicators that represent the critical processes identified in the metric assessment and monitor the indicators using statistical tests appropriate for the data availability of the stock. 

Generate the standardized ESP report following the guideline template and report ecosystem and socioeconomic considerations, data gaps, caveats, and future research priorities. 

## Justification {-}

National initiatives and NPFMC recommendations support conducting an ESP for the Myabbrev Red King Crab stock. The high commercial importance of the stock and the early life history habitat requirements created a high score for both stock assessment and habitat assessment prioritization (Hollowedetal2016; McConnaugheyetal2017). The vulnerability scores were in the low to moderate based on productivity, susceptibility (Patrick et al., 2010), and sensitivity to future climate exposure [Spenceretal2019]. The new data classification scores for Myabbrev Red King Crab suggest a data-rich stock with high quality data for catch, size/age composition, abundance, life history categories, and ecosystem linkages [Lynchetal2018]. These initiative scores and data classification levels suggest a high priority for conducting an ESP for Myabbrev Red King Crab particularly given the high level of life history information and current application of ecosystem linkages in the stock assessment model for natural mortality and catchability. Additionally, AFSC research priorities support studies that improve our understanding of environmental and climate forcing of ecosystem processes with focus on variables that provide direct input into stock assessment and management. Specifically, research that improves our understanding of Red King Crab dynamics in the Bristol Bay.

## Data {-}

Initially, information on Myabbrev Red King Crab was gathered through a variety of national initiatives that were conducted by AFSC personnel in 2015 and 2016. These include (but are not limited to) stock assessment prioritization, habitat assessment prioritization, climate vulnerability analysis, and stock assessment categorization. Data derived from this effort served as the initial starting point for developing the ESP metrics for stocks in the Bering Sea and Aleutian Islands (BSAI) and Gulf of Alaska (GOA) groundfish fishery management plans (FMP) and the BSAI king and tanner crab FMP. Please see @Shotwellinreview, for more details.

Data used to generate ecosystem metrics and indicators for the Myabbrev Red King Crab ESP were collected from a variety of laboratory studies, remote sensing databases, fisheries surveys, regional reports and fishery observer data collections (Table <a href="#tab:data">1</a>). Results from laboratory studies were specifically used to inform metrics and indicators relating to thermal tolerances, phenology and energetics across Myabbrev Red King Crab life history stages. Larval indicator development utilized datasets from the NOAA Bering Arctic Subarctic Integrated Survey (BASIS) and blended satellite data products from NOAA, NASA and ESA. Data for late-juvenile through adult Myabbrev Red King Crab stages were derived from the annual NOAA eastern Bering Sea bottom trawl survey and fishery observer data collected during the Myabbrev Red King Crab fishery.  Information on Myabbrev Red King Crab habitat use was derived from essential fish habitat (EFH) model output and maps (Figure xx: Laman et al., 2017) as well as laboratory studies and collaborative Myabbrev Red King Crab tagging efforts. Data from the NOAA Resource Ecology and Ecosystem Modeling (REEM) food habits database were used to determine species compositions of benthic predators on commercial crab species. 

Data used to generate socioeconomic metrics and indicators were derived from fishery-dependent sources, including commercial landings data for Myabbrev Red King Crab collected in ADFG fish tickets and the BSAI Crab Economic Data Report (EDR) database (both sourced from AKFIN), and effort statistics reported in the most recent ADFG Annual Management Report for BSAI shellfish fisheries estimated from ADF&G Crab Observer program data (Leon et al. 2017).

# Metrics Assessment {-}

We first provide the analysis of the national initiative data used to generate the baseline metrics for this second step of the ESP process and then provide more specific analyses on relevant ecosystem and/or socioeconomic processes. Metrics are quantitative stock-specific measures that identify vulnerability or resilience of the stock with respect to biological or socioeconomic processes. Where possible, evaluating these metrics by life history stage can highlight potential bottlenecks and improve mechanistic understanding of ecosystem or socioeconomic pressures on the stock.

## National Metrics {-}

The national initiative data were summarized into a metric panel (Figure <a href="#fig:metric"><strong>??</strong></a>) that acts as a first pass ecosystem and socioeconomic synthesis. Metrics range from estimated values to qualitative scores of population dynamics, life history, or economic data for a given stock (see Shotwell et al., In Review for more details). To simplify interpretation, the metrics are rescaled by using a percentile rank for Myabbrev Red King Crab relative to all other stocks in the groundfish and crab FMPs. Additionally, some metrics are inverted so that all metrics can be compared on a low to high scale between all stocks in the FMPs. These adjustments allow for initial identification of vulnerable (percentile rank value is high) and resilient (percentile rank value is low) traits for Myabbrev Red King Crab. Data quality estimates are also provided from the lead stock assessment author (0 or green shaded means no data to support answer, 4 or purple shaded means complete data), and if there are no data available for a particular metric then an “NA” will appear in the panel. Myabbrev Red King Crab did not have any data gaps for the metric panel and the data quality was rated as good to complete for nearly all metrics. The metric panel gives context for how Myabbrev Red King Crab relate to other groundfish and crab stocks in the FMPs and highlights the potential vulnerabilities for the Myabbrev Red King Crab stock.

The 80th and 90th percentile rank areas are provided to highlight metrics indicating a high level of vulnerability for Myabbrev Red King Crab (Figure <a href="#fig:metric"><strong>??</strong></a>). Ecosystem value, depth range, and spawning duration fell within the 80th percentile rank when compared to other stocks in the groundfish FMP. For socioeconomic metrics, constituent demand and commercial demand  fell within the 90th percentile rank. Additionally, Myabbrev Red King Crab ecosystem value, commercial importance, and mean trophic level exceeded a threshold of highly vulnerable established in the national initiatives (e.g., Methot, 2015; Patrick et al., 2010). Myabbrev Red King Crab were relatively resilient for habitat dependence, breeding strategy, geographic concentration, population growth rate, age 50% mature, age at 1st maturity, prey specificity, dispersal ELH, maximum age, temperature sensitivity, recruitment variability, reproductive strategy, mean age, habitat specificity, adult mobility, fecundity, and latitude range.

## Ecosystem Processes {-}

Data evaluated over ontogenetic shifts (e.g., embryo, larvae, juvenile, adult) may be helpful for identifying specific bottlenecks in productivity and relevant indicators for monitoring. As a first attempt, we summarized important ecosystem processes or potential bottlenecks across snow crab life history stages from the literature, process studies and laboratory rearing experiments. Details on why these processes were highlighted, as well as the potential relationship between ecosystem processes and stock productivity are described below. 

After molting to maturity, female snow crab mate and extrude new egg clutches each spring, which remain attached to pleopods on the female’s abdomen for a full year prior to hatching (Watson, 1970). Fecundity is positively correlated with female size, and primiparous females have a lower fecundity than multiparous females (Sainte-Marie, 1993). The optimal range for embryo development is 0 to 3&deg;C, although laboratory studies indicate that incubation temperatures below 0&deg;C can trigger diapause or a biennial reproduction cycle (Webb et al., 2007). Peak hatching of snow crab larvae occurs in April (Armstrong et al., 1981) and phyto-detritus may act as a chemical cue for larval release (Starr et al., 1994). Larval duration for each of the two zoeal stages is approximately 30 days (Incze et al., 1982). A longer larval stage associated with cooler temperatures may leave larvae more vulnerable to pelagic predators for a prolonged period. Furthermore, historical larval year-class failures have coincided with low zooplankton abundance over the middle shelf and low water column stability, suggesting that increased larval mortality is related to less favorable feeding conditions (Incze et al., 1987) and mismatches between larval release and the spring bloom (Somerton 1982). Likewise, laboratory studies suggest that relatively high prey densities are required for successful feeding in snow crab zoeae (Paul et al., 1979)  Major predators of larval snow crab include yellowfin sole (Armstrong et al., 1980), walleye pollock, jellyfish and juvenile salmon (Kruse et al., 2007). 

Snow crab larvae settle between late August to the end of October (Conan et al., 1992). Early benthic instars are cryptic and concentrate in shallow, cold water habitats (Lovrish et al., 1995; Murphy et al., 2010). Previous laboratory studies have shown that adequate energetic stores are prerequisites for molting, growth, and survival in snow crab early life history stages (e.g. Lovrich and Ouellet, 1994), indicating that variability in energetic reserves could represent a potential recruitment bottleneck in snow crab. Both settlement intensity and early benthic survival are likely critical determinants of year-class strength in snow crab (Sainte-Marie et al., 1996), and successful advection to areas of suitable temperature and muddy substrate are thought to be critical criteria for juvenile survival (Dionne et al., 2003). Density-dependence may also play a regulatory role due to high rates of cannibalism (Lovrich and Sainte-Marie 1997) and potential prey resource limitation in juvenile nurseries. Previous studies have shown that Pacific cod, sculpin, skates and halibut are major predators of juvenile snow crab (Livingston et al., 1993; Livingston and deReynier, 1996; Lang et al., 2003) and the cold pool may provide refuge from predators like Pacific cod that avoid waters less than 2&deg;C (Ciannelli and Bailey, 2005). Juvenile snow crab are especially vulnerable to predation and cannibalism during and immediately following molting. 

Spatial patterns in juvenile and adult snow crab distribution are determined largely by ontogenetic migrations linked to size- and sex-specific thermal requirements. Immature snow crab concentrate in colder, shallow waters of the NBS and EBS middle shelves, and have historically avoided thermal habitats >2&deg;C (Kolts et al., 2015; Murphy, 2020). Likewise, primiparous female snow crab appear to track near-bottom temperature during a northeast to southwest ontogenetic migration to warmer waters near the shelf break (Ernst et al., 2005; Parada et al., 2010). Shifts in centers of distribution of mature female snow crab relative to prevailing currents may affect larval supply to nursery areas (Zheng and Kruse, 2006) and thermal occupancy patterns of snow crab depend on the availability of cold water habitat (Fedewa et al., 2020). While 2&deg;C may represent a critical temperature threshold for immature snow crab (Murphy, 2020), negative effects on metabolic processes are not apparent in mature snow crab until temperatures exceed 7&deg;C (Foyle et al., 1989). Temperature also influences molt timing (Dutil et al., 2010), growth rates (Yamamoto et al., 2015), energy stores (Hardy et al., 2000), and body condition (Dutil et al., 2010) of snow crab in the laboratory.

## Socioeconomic Processes {-}

As described below, the set of socioeconomic indicators proposed in this ESP are categorized as Fishery Performance and Economic Performance and Community Effects indicators. Fishery Performance indicators are intended to represent processes most directly involved in prosecution of the EBS snow crab fishery, and thus have the potential to differentially affect the condition of the stock depending on how they influence the timing, spatial distribution, selectivity, and other aspects of fishing pressure. Economic Performance and Community Effects indicators are intended to capture key dimensions of the economic and social processes through which outputs, benefits and other effects flowing from commercial exploitation of the fishery are generated and distributed. Notwithstanding these categorical distinctions, the social and economic processes that affect, and are affected by, the condition of the stock are complex and interrelated at different time scales. Moreover, these processes are strongly influenced by the institutional structures of fishery management, which develop over time and include both discrete measures undertaken by in-season management, as well as comprehensive structural changes that induce complex, multidimensional change affecting numerous social and economic processes. Implementation of the Crab Rationalization (CR) Program in 2005 is an example of the latter (a full summary of the management history of the EBS snow crab fishery is beyond the scope of the ESP; see Nichols, et al., 2019).

A key distinction of most observable socioeconomic processes from ecosystem processes associated with the EBS snow crab fishery is that they occur during the fishery, and as such, cannot be captured in indicators that provide advance information for use in informing the current stock assessment. Moreover, data collection and monitoring of many aspects of socioeconomic processes is conducted following the fishing season such that the most recent available data point may be lagged by up to two years behind the current assessment. As such, in the context of the ESP, time series of socioeconomic indicators are largely limited to informing interpretation of historic patterns observed in other data series captured in the assessment, or to providing general context regarding the effects of historic fishery management.   

Among other changes, the CR program resulted in rapid consolidation of the EBS snow crab fleet, from a high of 272 vessels in 1994 to 78 during the first year of the CR program, which has subsequently further consolidated to 59 vessels operating in the 2020/21 season. Allocation of tradable crab harvest quota shares, with leasing of annual harvest quota, facilitated fleet consolidation and improved operational and economic efficiency of the fleet, changing the timing of the fishery from short derby seasons to more extended seasons, and inducing extensive and ongoing changes in harvest sector ownership, employment, and income. Crab processing sector provisions of the CR program include allocation of transferable processing quota shares (PQS), leasing of annual processing quota and custom-processing arrangements that enable PQS holders that do not operate a processing plant to purchase IFQ crab landings and direct them to a processing plant for custom processing, and community protection measures, including regional designation on harvest quota, requiring associated catch to be landed to ports within a specified region. While these and other elements of CR program design facilitated similar operational and economic efficiencies in the sector, with more limited consolidation of processing capacity to somewhat fewer locations, and fewer plants in some ports, they have also limited some economic adjustments that would likely have occurred in their absence. Most notably, North regional designation of a large fraction of EBS snow crab IFQ has likely maintained a larger proportion of landings to St. Paul Island than would have occurred otherwise. St. Paul Island has historically and to-date received the largest share of EBS snow crab landings, with Akutan, King Cove, and Unalaska/Dutch Harbor representing the other principal landing ports for EBS landings historically and to-date. See the Council’s 10-Year Program Review for the CR Program for detailed description and analysis of program structure and management (Council, 2017).

These and other institutional changes continue to influence the geographic and inter-sectoral distribution of benefits produced by the EBS snow crab fleet, both through direct ownership and labor income in the EBS snow crab harvest and processing sectors, and indirect social and economic effects on fishery-dependent communities throughout Alaska and greater Pacific Northwest region. The full range of fishery, economic, and social processes cannot be captured within the scope of the ESP framework, and more comprehensive set of metrics and indicators intended to inform EBS snow crab fishery management and annual harvest specifications are provided in the annual Crab Economic SAFE.

# Indicators Assessment {-}

We first provide information on how we selected the indicators for the third step of the ESP process and then provide results on the indicators analysis. In this indicator assessment a time-series suite is first created that represents the critical processes identified by the metric assessment. These indicators must be useful for stock assessment in that they are regularly updated, reliable, consistent, and long-term. The indicator suite is then monitored in a series of stages that are statistical tests that gradually increase in complexity depending on the data availability of the stock (Shotwell et al., In Review).

## Indicator Suite {-}

Brief literature review on ecosystem or socioeconomic indicators previously explored for stock that are currently available or updatable.

### Ecosystem Indicators {-}



1.) Physical Indicators



a.) Annual_Heatwave_GOA_Model: Annual marine heatwave cumulative index over the central GOA (contact: Steve Barbeaux)



Status and trends: NA



Influential factors: NA



b.) Spring_Temperature_Surface_EGOA_Satellite: Late spring (May-June) daily sea surface temperatures (SST) for the eastern GOA from the NOAA Coral Reef Watch Program (contact: Matt Callahan)



Status and trends: Despite marked inter-annual variability, there appears to only be a slight upward trend in the overall time series.



Influential factors: Oceanography.



c.) Spring_Temperature_Surface_GOA_Satellite: Late spring (May-June) daily sea surface temperatures (SST) for the GOA from the NOAA Coral Reef Watch Program (contact: Matt Callahan)



Status and trends: Slight trend in overall time series



Influential factors: NA



d.) Spring_Temperature_Surface_SEBS_Satellite: Late spring (May-June) daily sea surface temperatures (SST) for the southeastern Bering Sea from the NOAA Coral Reef Watch Program (contact: Matt Callahan)



Status and trends: While inter-annual variability is evident, a generally increasing trend is apparent (from both linear and non-linear smoothers). However, a cold stanza is a dominant feature for a portion of the time series. Recent years appear remarkably warmer than the majority of the time series.



Influential factors: Um, global climate change?



e.) Summer_Temperature_250m_GOA_Survey: Summer temperature anomalies at 250 m isobath during the AFSC annual longline survey (contact: Kevin Siwicke)



Status and trends: The 250-m slope temperature index is in prime sablefish habitat and the magnitude of interannual differences is small compared to surface water temperature fluctuations. However, this index has remained positive for the last six years, a deviation from the historical fluctuations around the mean, suggesting these deeper waters continue to be warmer than average (~0.15°C) since 2017.



Influential factors: Warming that has been evident in bottom temperatures throughout the shelf environment has not been particularly present over much of the slope environment, which may provide a buffer during spawning and egg deposition for sablefish.



2.) Lower Trophic Indicators



a.) Annual_Copepod_Community_Size_EGOA_Survey: Abundance of copepod community size from the continuous plankton recorder (CPR) for the offshore eastern GOA (contact: Clare Ostle)



Status and trends: On the western side of the oceanic Gulf of Alaska the diatom anomaly was also positive in 2021. On the eastern side of the oceanic Gulf of Alaska the diatom abundance anomaly was negative for the last two years, with the strongest negative anomaly of the time-series appearing in 2021. The copepod community size anomaly was mostly negative in all regions in the last 5-7 years, but it has oscillated in the Alaskan shelf to a positive anomaly in 2021. Zooplankton biomass anomalies were positive in both the Shelf and eastern Gulf of Alaska regions in 2020, but have switched to negative in 2021, while the anomaly has remained negative in the western side of the Gulf of Alaska. The zooplankton biomass anomaly in 2021 in the eastern Gulf of Alaska is the most negative it has been for the timeseries presented.



Influential factors: The Pacific Decadal Oscillation (PDO) monthly values were often negative in 2017 causing a lower annual mean value compared to the years of 2014-2016 and 2018-2020, which had experienced a marine heat wave (DiLorenzo and Mantua, 2016). 2021 appears to be not as warm as the previous 7 years. In warm conditions smaller species tend to be more abundant and the copepod community size index reflects this and was mostly negative throughout the marine heat wave periods of 2014-2016, and 2018-2020. The large diatom abundance was positive in 2021 in the shelf and western regions, however in the eastern Gulf of Alaska regions there is a lower than average diatom anomaly. It is unclear what has led to the decrease in diatom abundance in this region, but it could be that the decreased meso-zooplankton biomass provided decreased grazing pressure and therefore an increase in the diatom abundance in the shelf and western Gulf of Alaska.



b.) Annual_Copepod_Community_Size_WGOA_Survey: Abundance of copepod community size from the continuous plankton recorder (CPR) for the offshore western GOA (contact: Clare Ostle)



Status and trends: On the western side of the oceanic Gulf of Alaska the diatom anomaly was also positive in 2021. On the eastern side of the oceanic Gulf of Alaska the diatom abundance anomaly was negative for the last two years, with the strongest negative anomaly of the time-series appearing in 2021. The copepod community size anomaly was mostly negative in all regions in the last 5-7 years, but it has oscillated in the Alaskan shelf to a positive anomaly in 2021. Zooplankton biomass anomalies were positive in both the Shelf and eastern Gulf of Alaska regions in 2020, but have switched to negative in 2021, while the anomaly has remained negative in the western side of the Gulf of Alaska. The zooplankton biomass anomaly in 2021 in the eastern Gulf of Alaska is the most negative it has been for the timeseries presented.



Influential factors: The Pacific Decadal Oscillation (PDO) monthly values were often negative in 2017 causing a lower annual mean value compared to the years of 2014-2016 and 2018-2020, which had experienced a marine heat wave (DiLorenzo and Mantua, 2016). 2021 appears to be not as warm as the previous 7 years. In warm conditions smaller species tend to be more abundant and the copepod community size index reflects this and was mostly negative throughout the marine heat wave periods of 2014-2016, and 2018-2020. The large diatom abundance was positive in 2021 in the shelf and western regions, however in the eastern Gulf of Alaska regions there is a lower than average diatom anomaly. It is unclear what has led to the decrease in diatom abundance in this region, but it could be that the decreased meso-zooplankton biomass provided decreased grazing pressure and therefore an increase in the diatom abundance in the shelf and western Gulf of Alaska.



c.) Annual_Sablefish_Growth_YOY_Middleton_Survey: Age-0 sablefish growth rate from auklet diets in Middleton Island (contact: Mayumi Arimitsu)



Status and trends: NA



Influential factors: NA



d.) Spring_Chlorophylla_Biomass_EGOA_Satellite: Derived chlorophyll a concentration during spring seasonal peak (May) in the eastern GOA from the MODIS satellite (contact: Matt Callahan)



Status and trends: Variable



Influential factors: Oceanography



e.) Spring_Chlorophylla_Biomass_GOA_Satellite: Derived chlorophyll a concentration during spring seasonal peak (May) in the GOA from the MODIS satellite (contact: Matt Callahan)



Status and trends: NA



Influential factors: NA



f.) Spring_Chlorophylla_Biomass_SEBS_Satellite: Derived chlorophyll a concentration during spring seasonal peak (May) in the southeastern Bering Sea from the MODIS satellite (contact: Jens Nielsen)



Status and trends: NA



Influential factors: NA



g.) Spring_Chlorophylla_Peak_EGOA_Satellite: Peak timing of the spring bloom averaged across individual ADF&G statistical areas in the eastern GOA region from the MODIS satellite (contact: Matt Callahan)



Status and trends: NA



Influential factors: NA



h.) Spring_Chlorophylla_Peak_GOA_Satellite: Peak timing of the spring bloom averaged across individual ADF&G statistical areas in the GOA region from the MODIS satellite (contact: Matt Callahan)



Status and trends: NA



Influential factors: NA



i.) Spring_Chlorophylla_Peak_SEBS_Satellite: Peak timing of the spring bloom averaged across individual ADF&G statistical areas in the southeastern Bering Sea from the MODIS satellite (contact: Jens Nielsen)



Status and trends: 2021 spring bloom timing was close to the long-term mean peak timing



Influential factors: NA



j.) Summer_Euphausiid_Abundance_Kodiak_Survey: Summer euphausiid abundance for the Kodiak core survey area from the AFSC acoustic survey (contact: Patrick Ressler)



Status and trends: NA



Influential factors: NA



3.) Upper Trophic Indicators



a.) Annual_Arrowtooth_Biomass_GOA_Model: Arrowtooth flounder total biomass from the most recent stock assessment model in the GOA (contact: Kalei Shotwell)



Status and trends: NA



Influential factors: NA



b.) Annual_Sablefish_Age_Evenness_Female_Adult_Model: Measure of evenness or concentration of age composition by cohort of female sablefish from the most recent sablefish stock assessment model (contact: Dan Goethel)



Status and trends: NA



Influential factors: NA



c.) Annual_Sablefish_Incidental_Catch_Arrowtooth_Target_GOA_Fishery: Incidental catch of sablefish in the GOA arrowtooth flounder fishery (contact: Kalei Shotwell)



Status and trends: NA



Influential factors: NA



d.) Annual_Sablefish_Mean_Age_Female_Adult_Model: Mean age of sablefish female spawning stock biomass from the most recent sablefish stock assessment model (contact: Dan Goethel)



Status and trends: NA



Influential factors: NA



e.) Summer_Sablefish_CPUE_Juvenile_GOA_Survey: Catch-per-unit-of-effort (CPUE) of juvenile sablefish (<400 mm, likely age-1) collected on summer AFSC bottom-trawl surveys (contact: Kalei Shotwell)



Status and trends: NA



Influential factors: NA



f.) Summer_Sablefish_CPUE_Juvenile_Nearshore_GOAAI_Survey: Sablefish catch-per-unit-effort (CPUE) and lengths from the ADF&G large mesh bottom trawl survey of crab and groundfish (contact: Kally Spalinger)



Status and trends: Sablefish CPUE on the ADF&G large-mesh bottom trawl survey remained at relatively low levels from 1989 until 2015 when it began increasing, peaking in 2020. CPUE has declined the last 2 years, while catch in kg remains above average for 7 of the last 8 years.



Influential factors: NA



g.) Summer_Sablefish_Condition_Female_Adult_GOA_Survey: Summer sablefish condition for large adult (>=750 mm) female sablefish from the GOA AFSC longline survey (contact: Jane Sullivan)



Status and trends: The condition of large female sablefish in the longline survey was below average for the fourth consecutive year.



Influential factors: NA



h.) Summer_Sablefish_Condition_Female_Age4_GOA_Survey: Summer sablefish condition for age-4, immature female sablefish from the GOA AFSC longline survey (contact: Jane Sullivan)



Status and trends: The condition index for the 2021 age-4 immature females collected in the longline survey was above average for the first time since 2014.



Influential factors: NA

### Socioeconomic Indicators {-}



1.) Fishery Performance Indicators



a.) Annual_Sablefish_Combined_CPUE_Alaska_Fishery: Catch per unit of effort of sablefish estimated from the longline and pot fisheries combined in Alaska (contact: Matt Cheng)



Status and trends: Standardized relative indices of abundance for sablefish in 2021 increased by 36.8% compared to the previous year. Trends prior to 2017 primarily result from the hook-and-line fishery as they precede the 2017 regulatory shift that allowed for pot gear fishing in the Gulf of Alaska. In contrast, trends from 2017 - 2021 are indicative of both the hook-and-line and pot fishery. Starting in 2020, > 50% of fishery observations originated from pot gear. Considering that the index currently does not differentiate between rigid conical pots and “slinky-pots”, which likely exhibit differences in catchability, these trends should be interpreted with caution.



Influential factors: Increases in relative indices of abundance for sablefish can be attributed to a variety of factors. Notably, there has been an influx of sablefish resulting from large recruitment events in recent years.



b.) Annual_Sablefish_Condition_Female_Adult_BSAI_Fishery: Sablefish condition for large (>= 750 mm) female sablefish from data collected randomly by observers in the BSAI fisheries (contact: Jane Sullivan)



Status and trends: There has been no update to this indicator since 2016 due to lack of data.



Influential factors: NA



c.) Annual_Sablefish_Condition_Female_Adult_GOA_Fishery: Sablefish condition for large (>= 750 mm) female sablefish from data collected randomly by observers in the GOA fisheries (contact: Jane Sullivan)



Status and trends: The 2021 condition index for large female sablefish in the fishery is the lowest for the time series.



Influential factors: These findings are based on 24 samples collected in the fishery; however, the data are consistent with decreasing trends in body condition in the longline survey. The decrease in available data is attributed to shifts towards electronic monitoring and reduced fishing effort due to low prices, small fish, and Covid-19.



d.) Annual_Sablefish_Incidental_Catch_BSAI_Fishery: Incidental catch estimates of sablefish in the Bering Sea fisheries excluding the sablefish fishery (contact: Kalei Shotwell)



Status and trends: NA



Influential factors: NA



e.) Annual_Sablefish_Incidental_Catch_GOA_Fishery: Incidental catch estimates of sablefish in the GOA fisheries excluding the sablefish fishery (contact: Kalei Shotwell)



Status and trends: NA



Influential factors: NA



f.) Annual_Sablefish_Longline_CPUE_GOA_Fishery: Catch-per-unit-of-effort of sablefish from the longline fisheries in the GOA (contact: Kalei Shotwell)



Status and trends: NA



Influential factors: NA



g.) Annual_Sablefish_Pot_CPUE_Alaska_Fishery: Catch per unit of effort of sablefish estimated from the  pot fisheries in  Alaska (contact: Matt Cheng)



Status and trends: Standardized relative indices of abundance from the pot fishery for sablefish in 2021 increased by 35.3% compared to the previous year. Trends prior to 2017 precede the regulatory shift for pot gear fishing in the Gulf of Alaska (GOA), and result from the Bering Sea Aleutian Islands (BSAI) pot fishery. Trends from 2017 - 2021 are representative of both the GOA and BSAI pot fisheries. Beginning in 2017, > 60% of fishery observations originate from the GOA pot fishery. This current index does not differentiate between rigid conical pots and "slinky-pots", which may exhibit differences in catchability, and thus rends should be interpreted with caution. Note that the year 2015 is missing from this index due to low sample sizes, likely because of observer restructuring and low observer coverage in the BSAI region.



Influential factors: Increases in standardized indices of abundance from the pot fishery are attributed to a variety of factors, which include high recruitment events in recent years, and the expansion of the pot fleet into the GOA.



h.) Annual_Sablefish_Pot_CPUE_EBS_Fishery: Catch per unit of effort of sablefish estimated from the pot fisheries in the eastern Bering Sea (contact: Matt Cheng)



Status and trends: NA



Influential factors: NA



2.) Economic Indicators



a.) Annual_Sablefish_Real_Exvessel_Price_Fishery: Average real ex-vessel price per pound of sablefish from fish ticket information (contact: Ben Fissel)



Status and trends: NA



Influential factors: NA



b.) Annual_Sablefish_Real_Exvessel_Value_Fishery: Annual estimated real ex-vessel value of sablefish (contact: Ben Fissel)



Status and trends: NA



Influential factors: NA



3.) Community Indicators

## Indicator Monitoring Analysis {-}

There are up to three stages (beginning, intermediate, and advanced) of statistical analyses for monitoring the indicator suite listed in the previous section. These analyses gradually increase in complexity depending on the stability of the indicator for monitoring the ecosystem or socioeconomic process and the data availability for the stock (Shotwell et al., In Review). The beginning stage is a relatively simple score based on the current year trends relative to the mean of the whole time series, and provides a historical perspective on the utility of the whole indicator suite. The intermediate stage uses importance methods related to a stock assessment variable of interest (e.g., recruitment, biomass, catchability). These regression techniques provide a simple predictive performance for the variable of interest and are run separate from the stock assessment model. They provide the direction, magnitude, uncertainty of the effect, and an estimate of inclusion probability. The advanced stage is used for testing a research ecosystem linked model and output can be compared with the current operational model to understand information on retrospective patterns, prediction performance, and comparisons of other model output such as terminal spawning stock biomass or mean recruitment. This stage provides an on-ramp for introducing an alternative ecosystem linked stock assessment model to the current operational stock assessment model and can be used to understand the potential reduction in uncertainty by including the ecosystem information. 

At this time, we report the results of the beginning and intermediate stages of the indicator monitoring analysis for Myabbrev Red King Crab and a review of current ecosystem linked modeling developments for the advanced stage.

### Beginning Stage: Simple Score {-}

We use a simple scoring calculation for the beginning stage evaluation. Indicator status is evaluated based on being greater than (“high”), less than (“low”), or within (“neutral”) one standard deviation of the long-term mean. A sign based on the anticipated relationship between the indicator and the stock (Figure <a href="#fig:con">1</a>) is also assigned to the indicator where possible for ecosystem indicators only. If a high value of an indicator generates good conditions for the stock and is also greater than one standard deviation above the mean, then that value receives a +1 score. If a high value generates poor conditions for the stock and is greater than one standard deviation above the mean, then that value receives a -1 score. All values less than or equal to one standard deviation from the long-term mean are average and receive a 0 score. The scores are summed by the three organizational categories within the ecosystem (physical, lower trophic, and upper trophic) or socioeconomic (fishery performance, economic, and community) indicators and divided by the total number of indicators available in that category for a given year. We provide the category scores for the past twenty years as the majority of indicators were available throughout this time period (Figure <a href="#fig:overall"><strong>??</strong></a>). The scores over time allow for comparison of the indicator performance and the history of stock productivity. We also provide five year indicator status tables with a color or text code for the relationship with the stock (Tables <a href="#fig:status"><strong>??</strong></a>) and evaluate the current year status in the historical indicator time series graphic (Figures <a href="#fig:time"><strong>??</strong></a>) for each ecosystem and socioeconomic indicator.

We evaluate the list of ecosystem indicators to understand the pressures on the Myabbrev Red King Crab stock regarding recruitment, stock productivity, and stock health. We start with the physical indicators and proceed through the increasing trophic levels, fishery performance, and economic indicators as listed above. <Describe category scores for most recent year relative to past years for ecosystem then socioeconomic indicators.>

<Describe trends of the ecosystem indicators by category>

<Describe trends of the socioeconomic indicators by category>

### Intermediate Stage: Importance Analysis {-}

Bayesian adaptive sampling (BAS) was used for the intermediate stage statistical analysis to quantify the association between hypothesized predictors and Myabbrev Red King Crab recruitment and to assess the strength of support for each hypothesis. BAS explores model space, or the full range of candidate combinations of predictor variables, to calculate marginal inclusion probabilities for each predictor, model weights for each combination of predictors, and generate Bayesian model averaged predictions for outcomes (Clyde et al., 2011). In this intermediate analysis, the full set of indicators is first winnowed to the predictors that could directly relate to recruitment and highly correlated covariates are removed (Figure <a href="#fig:bayes">2</a>). We further restrict potential covariates to those that can provide the longest model run and through the most recent estimate of recruitment that is well estimated. This results in a model run from xxxx through the xxxx for Myabbrev Red King Crab. We then provide the mean relationship between each predictor variable and log Myabbrev Red King Crab recruitment over time (Figure <a href="#fig:bayes">2</a>, left side), with error bars describing the uncertainty (95% confidence intervals) in each estimated effect and the marginal inclusion probabilities for each predictor variable (Figure <a href="#fig:bayes">2</a>, right side). A higher probability indicates that the variable is a better candidate predictor of Myabbrev Red King Crab recruitment. The highest ranked predictor variables (inclusion probability > 0.5) based on this process were the <list any high inclusion probability covariates> (Figure <a href="#fig:bayes">2</a>). 

The BAS method requires observations of all predictor variables in order to fit a given data point. This method estimates the inclusion probability for each predictor, generally by looking at the relative likelihood of all model combinations (subsets of predictors). If the value of one predictor is missing in a given year, all likelihood comparisons cannot be computed. When the model is run, only the subset of observations with complete predictor and response time series are fit. It is possible to effectively “trick” the model into fitting all years by specifying a 0 (the long-term average in z-score space) for missing predictor values. However, this may bias inclusion probabilities for time series that have more zeros and result in those time series exhibiting low inclusion probability, independent of the strength of the true relationship. Due to this consideration of bias, we only fit years with complete observations for each covariate at the longest possible time frame. This resulted in a smaller final subset of covariates. We plan to explore alternate model runs to potentially include more covariates in the future. 

### Advanced Stage: Research Model {-}

<Summarize any research ecosystem model runs that have occurred for this stock>

# Conclusion {-}

The Myabbrev Red King Crab ESP follows the standardized framework for evaluating the various ecosystem and socioeconomic considerations for this stock (Shotwell et al., In Review). Given the metric and indicator assessment we provide the following summary for ecosystem and socioeconomic indicators: 

## Ecosystem Indicators {-}

<Summary conclusions regarding ecosystem information from the metric or indicator assessment, include main takeaways from ecosystem processes section, and three stages of indicator monitoring >

## Socioeconomic Indicators {-}

<Summary conclusions regarding socioeconomic information from the metric or indicator assessment, include main takeaways from socioeconomic processes section, and three stages of indicator monitoring >

## Data Gaps and Future Research Priorities {-}

Description of data gaps, future priorities for ecosystem and socioeconomic research that would support future versions of the ESP

# Acknowledgements {-}

We would like to thank all the contributors for their timely response to requests and questions regarding their data, report summaries, and manuscripts. We also thank our AFSC internal reviewer <name> for reviewing this ESP and the Crab Plan Team and SSC for their helpful insight on the development of this report and future reports. 

We would also like to thank all the AFSC personnel and divisions, the Alaska Department of Fish and Game, <list other contributing agencies>, the Southwest Fisheries Science Center CoastWatch Program, and the Alaska Fisheries Information Network for their data processing and contributions to this report.

# Literature Cited {-}

Caddy, J.F. 2015. The traffic light procedure for decision making: its rapid extension from fisheries to other sectors of the economy. Glob. J. of Sci. Front. Res: 1 Mar. Sci. 15(1), 30 pp.

Clyde, M. A., J. Ghosh, and M. L. Littman. 2011. Bayesian Adaptive Sampling for Variable Selection and Model Averaging. Journal of Computational and Graphical Statistics 20:80-101.

Hollowed, A.B., K. Aydin, K. Blackhart, M. Dorn, D. Hanselman, J. Heifetz, S. Kasperski, S. Lowe, and K. Shotwell. 2016. Discussion Paper Stock Assessment Prioritization for the North Pacific Fishery Management Council: Methods and Scenarios. Report to North Pacific Fisheries Management Council, 605 W 4th Ave, Suite 306, Anchorage, AK 99501. 17 pp.

Lynch, P. D., R. D. Methot, and J. S. Link (eds.). 2018. Implementing a Next Generation Stock Assessment Enterprise. An Update to the NOAA Fisheries Stock Assessment Improvement Plan. U.S. Dep. Commer., NOAA Tech. Memo. NMFS-F/SPO-183, 127 p. doi:10.7755/TMSPO.183

McConnaughey, R. A., K. E. Blackhart , M. P. Eagleton , and J. Marsh. 2017. Habitat assessment prioritization for Alaska stocks: Report of the Alaska Regional Habitat Assessment Prioritization Coordination Team. U.S. Dep. Commer., NOAA Tech. Memo. NMFS-AFSC-361, 102 p.

Methot, R. D. Jr. (ed.). 2015. Prioritizing fish stock assessments. NOAA Tech. Memo. NMFS-F/SPO-152, 31 p.

Patrick, W.S.,  P. Spencer, J. Link, J. Cope, J. Field, D. Kobayashi, P. Lawson, T. Gedamke, E. Cortés, O.A. Ormseth, K. Bigelow, W. Overholtz. 2010. Using productivity and susceptibility indices to assess the vulnerability of United States fish stocks to overfishing. Fish. Bull., 108: 305–322.

Shotwell, S.K., K., Blackhart, C. Cunningham, E. Fedewa, D., Hanselman, K., Aydin, M., Doyle, B., Fissel, P., Lynch, O., Ormseth, P., Spencer, S., Zador. In Review. Introducing the Ecosystem and Socioeconomic Profile, a proving ground for next generation stock assessments.

Sigler, M. F., M. P. Eagleton, T. E. Helser, J. V. Olson, J. L. Pirtle, C. N. Rooper, S. C. Simpson, and R. P. Stone. 2017. Alaska Essential Fish Habitat Research Plan: A Research Plan for the National Marine Fisheries Service’s Alaska Fisheries Science Center and Alaska Regional Office. AFSC Processed Rep. 2015-05, 22 p. Alaska Fish. Sci. Cent., NOAA, Natl. Mar. Fish. Serv., 7600 Sand Point Way NE, Seattle WA 98115.

Spencer, P.D., A.B. Hollowed, M.F. Sigler, A.J. Hermann, and M.W. Nelson. 2019. Trait-based climate vulnerability assessments in data-rich systems: an application to eastern Bering sea fish and invertebrate stocks. Global Change Biology 25(11): 3954-3971.

<div id="refs"></div>

\newpage

# Tables {-}




::: {custom-style="Table Caption"}

<caption>Table 1: `<w:r><w:t xml:space="preserve">table of data used in the esp</w:t></w:r>`{=openxml}</caption>

:::

``````{=openxml}
<w:tbl xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture"><w:tblPr><w:tblLayout w:type="fixed"/><w:jc w:val="center"/><w:tblLook w:firstRow="1" w:lastRow="0" w:firstColumn="0" w:lastColumn="0" w:noHBand="0" w:noVBand="1"/></w:tblPr><w:tblGrid><w:gridCol w:w="570"/><w:gridCol w:w="557"/></w:tblGrid><w:tr><w:trPr><w:trHeight w:val="568" w:hRule="auto"/><w:tblHeader/></w:trPr>header1<w:tc><w:tcPr><w:tcBorders><w:bottom w:val="single" w:sz="16" w:space="0" w:color="666666"/><w:top w:val="single" w:sz="16" w:space="0" w:color="666666"/><w:left w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:right w:val="none" w:sz="0" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:val="clear" w:color="auto" w:fill="FFFFFF"/><w:tcMar><w:top w:w="0" w:type="dxa"/><w:bottom w:w="0" w:type="dxa"/><w:left w:w="0" w:type="dxa"/><w:right w:w="0" w:type="dxa"/></w:tcMar><w:vAlign w:val="center"/></w:tcPr><w:p><w:pPr><w:pStyle w:val="Normal"/><w:jc w:val="left"/><w:pBdr><w:bottom w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:top w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:left w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:right w:val="none" w:sz="0" w:space="0" w:color="000000"/></w:pBdr><w:spacing w:after="100" w:before="100" w:line="240"/><w:ind w:firstLine="0" w:left="100" w:right="100"/></w:pPr><w:r xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml"><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:eastAsia="Arial" w:cs="Arial"/><w:i w:val="false"/><w:b w:val="true"/><w:u w:val="none"/><w:sz w:val="22"/><w:szCs w:val="22"/><w:color w:val="000000"/></w:rPr><w:t xml:space="preserve">X</w:t></w:r></w:p></w:tc><w:tc><w:tcPr><w:tcBorders><w:bottom w:val="single" w:sz="16" w:space="0" w:color="666666"/><w:top w:val="single" w:sz="16" w:space="0" w:color="666666"/><w:left w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:right w:val="none" w:sz="0" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:val="clear" w:color="auto" w:fill="FFFFFF"/><w:tcMar><w:top w:w="0" w:type="dxa"/><w:bottom w:w="0" w:type="dxa"/><w:left w:w="0" w:type="dxa"/><w:right w:w="0" w:type="dxa"/></w:tcMar><w:vAlign w:val="center"/></w:tcPr><w:p><w:pPr><w:pStyle w:val="Normal"/><w:jc w:val="right"/><w:pBdr><w:bottom w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:top w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:left w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:right w:val="none" w:sz="0" w:space="0" w:color="000000"/></w:pBdr><w:spacing w:after="100" w:before="100" w:line="240"/><w:ind w:firstLine="0" w:left="100" w:right="100"/></w:pPr><w:r xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml"><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:eastAsia="Arial" w:cs="Arial"/><w:i w:val="false"/><w:b w:val="true"/><w:u w:val="none"/><w:sz w:val="22"/><w:szCs w:val="22"/><w:color w:val="000000"/></w:rPr><w:t xml:space="preserve">Y</w:t></w:r></w:p></w:tc></w:tr><w:tr><w:trPr><w:trHeight w:val="569" w:hRule="auto"/></w:trPr>body1<w:tc><w:tcPr><w:tcBorders><w:bottom w:val="single" w:sz="4" w:space="0" w:color="666666"/><w:top w:val="single" w:sz="16" w:space="0" w:color="666666"/><w:left w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:right w:val="none" w:sz="0" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:val="clear" w:color="auto" w:fill="FFFFFF"/><w:tcMar><w:top w:w="0" w:type="dxa"/><w:bottom w:w="0" w:type="dxa"/><w:left w:w="0" w:type="dxa"/><w:right w:w="0" w:type="dxa"/></w:tcMar><w:vAlign w:val="center"/></w:tcPr><w:p><w:pPr><w:pStyle w:val="Normal"/><w:jc w:val="left"/><w:pBdr><w:bottom w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:top w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:left w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:right w:val="none" w:sz="0" w:space="0" w:color="000000"/></w:pBdr><w:spacing w:after="100" w:before="100" w:line="240"/><w:ind w:firstLine="0" w:left="100" w:right="100"/></w:pPr><w:r xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml"><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:eastAsia="Arial" w:cs="Arial"/><w:i w:val="false"/><w:b w:val="false"/><w:u w:val="none"/><w:sz w:val="22"/><w:szCs w:val="22"/><w:color w:val="000000"/></w:rPr><w:t xml:space="preserve">A</w:t></w:r></w:p></w:tc><w:tc><w:tcPr><w:tcBorders><w:bottom w:val="single" w:sz="4" w:space="0" w:color="666666"/><w:top w:val="single" w:sz="16" w:space="0" w:color="666666"/><w:left w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:right w:val="none" w:sz="0" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:val="clear" w:color="auto" w:fill="FFFFFF"/><w:tcMar><w:top w:w="0" w:type="dxa"/><w:bottom w:w="0" w:type="dxa"/><w:left w:w="0" w:type="dxa"/><w:right w:w="0" w:type="dxa"/></w:tcMar><w:vAlign w:val="center"/></w:tcPr><w:p><w:pPr><w:pStyle w:val="Normal"/><w:jc w:val="right"/><w:pBdr><w:bottom w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:top w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:left w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:right w:val="none" w:sz="0" w:space="0" w:color="000000"/></w:pBdr><w:spacing w:after="100" w:before="100" w:line="240"/><w:ind w:firstLine="0" w:left="100" w:right="100"/></w:pPr><w:r xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml"><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:eastAsia="Arial" w:cs="Arial"/><w:i w:val="false"/><w:b w:val="false"/><w:u w:val="none"/><w:sz w:val="22"/><w:szCs w:val="22"/><w:color w:val="000000"/></w:rPr><w:t xml:space="preserve">1</w:t></w:r></w:p></w:tc></w:tr><w:tr><w:trPr><w:trHeight w:val="569" w:hRule="auto"/></w:trPr>body2<w:tc><w:tcPr><w:tcBorders><w:bottom w:val="single" w:sz="4" w:space="0" w:color="666666"/><w:top w:val="single" w:sz="4" w:space="0" w:color="666666"/><w:left w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:right w:val="none" w:sz="0" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:val="clear" w:color="auto" w:fill="FFFFFF"/><w:tcMar><w:top w:w="0" w:type="dxa"/><w:bottom w:w="0" w:type="dxa"/><w:left w:w="0" w:type="dxa"/><w:right w:w="0" w:type="dxa"/></w:tcMar><w:vAlign w:val="center"/></w:tcPr><w:p><w:pPr><w:pStyle w:val="Normal"/><w:jc w:val="left"/><w:pBdr><w:bottom w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:top w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:left w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:right w:val="none" w:sz="0" w:space="0" w:color="000000"/></w:pBdr><w:spacing w:after="100" w:before="100" w:line="240"/><w:ind w:firstLine="0" w:left="100" w:right="100"/></w:pPr><w:r xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml"><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:eastAsia="Arial" w:cs="Arial"/><w:i w:val="false"/><w:b w:val="false"/><w:u w:val="none"/><w:sz w:val="22"/><w:szCs w:val="22"/><w:color w:val="000000"/></w:rPr><w:t xml:space="preserve">B</w:t></w:r></w:p></w:tc><w:tc><w:tcPr><w:tcBorders><w:bottom w:val="single" w:sz="4" w:space="0" w:color="666666"/><w:top w:val="single" w:sz="4" w:space="0" w:color="666666"/><w:left w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:right w:val="none" w:sz="0" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:val="clear" w:color="auto" w:fill="FFFFFF"/><w:tcMar><w:top w:w="0" w:type="dxa"/><w:bottom w:w="0" w:type="dxa"/><w:left w:w="0" w:type="dxa"/><w:right w:w="0" w:type="dxa"/></w:tcMar><w:vAlign w:val="center"/></w:tcPr><w:p><w:pPr><w:pStyle w:val="Normal"/><w:jc w:val="right"/><w:pBdr><w:bottom w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:top w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:left w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:right w:val="none" w:sz="0" w:space="0" w:color="000000"/></w:pBdr><w:spacing w:after="100" w:before="100" w:line="240"/><w:ind w:firstLine="0" w:left="100" w:right="100"/></w:pPr><w:r xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml"><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:eastAsia="Arial" w:cs="Arial"/><w:i w:val="false"/><w:b w:val="false"/><w:u w:val="none"/><w:sz w:val="22"/><w:szCs w:val="22"/><w:color w:val="000000"/></w:rPr><w:t xml:space="preserve">2</w:t></w:r></w:p></w:tc></w:tr><w:tr><w:trPr><w:trHeight w:val="574" w:hRule="auto"/></w:trPr>body3<w:tc><w:tcPr><w:tcBorders><w:bottom w:val="single" w:sz="16" w:space="0" w:color="666666"/><w:top w:val="single" w:sz="4" w:space="0" w:color="666666"/><w:left w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:right w:val="none" w:sz="0" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:val="clear" w:color="auto" w:fill="FFFFFF"/><w:tcMar><w:top w:w="0" w:type="dxa"/><w:bottom w:w="0" w:type="dxa"/><w:left w:w="0" w:type="dxa"/><w:right w:w="0" w:type="dxa"/></w:tcMar><w:vAlign w:val="center"/></w:tcPr><w:p><w:pPr><w:pStyle w:val="Normal"/><w:jc w:val="left"/><w:pBdr><w:bottom w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:top w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:left w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:right w:val="none" w:sz="0" w:space="0" w:color="000000"/></w:pBdr><w:spacing w:after="100" w:before="100" w:line="240"/><w:ind w:firstLine="0" w:left="100" w:right="100"/></w:pPr><w:r xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml"><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:eastAsia="Arial" w:cs="Arial"/><w:i w:val="false"/><w:b w:val="false"/><w:u w:val="none"/><w:sz w:val="22"/><w:szCs w:val="22"/><w:color w:val="000000"/></w:rPr><w:t xml:space="preserve">C</w:t></w:r></w:p></w:tc><w:tc><w:tcPr><w:tcBorders><w:bottom w:val="single" w:sz="16" w:space="0" w:color="666666"/><w:top w:val="single" w:sz="4" w:space="0" w:color="666666"/><w:left w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:right w:val="none" w:sz="0" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:val="clear" w:color="auto" w:fill="FFFFFF"/><w:tcMar><w:top w:w="0" w:type="dxa"/><w:bottom w:w="0" w:type="dxa"/><w:left w:w="0" w:type="dxa"/><w:right w:w="0" w:type="dxa"/></w:tcMar><w:vAlign w:val="center"/></w:tcPr><w:p><w:pPr><w:pStyle w:val="Normal"/><w:jc w:val="right"/><w:pBdr><w:bottom w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:top w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:left w:val="none" w:sz="0" w:space="0" w:color="000000"/><w:right w:val="none" w:sz="0" w:space="0" w:color="000000"/></w:pBdr><w:spacing w:after="100" w:before="100" w:line="240"/><w:ind w:firstLine="0" w:left="100" w:right="100"/></w:pPr><w:r xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml"><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:eastAsia="Arial" w:cs="Arial"/><w:i w:val="false"/><w:b w:val="false"/><w:u w:val="none"/><w:sz w:val="22"/><w:szCs w:val="22"/><w:color w:val="000000"/></w:rPr><w:t xml:space="preserve">3</w:t></w:r></w:p></w:tc></w:tr></w:tbl>
``````

\newpage

# Figures {-}



[1] "C:/Users/abigail.tyrell/Documents/ESP/AKesp/old/snow_crab/images/snow-crab-con-model.png"

![Figure 1: An image of the EBS snow crab conceptual model](../old/snow_crab/images/snow-crab-con-model.PNG)

##### Figure <a href="#fig:con">1</a>. Conceptual model of EBS snow crab {-}
[1] "C:/Users/abigail.tyrell/Documents/ESP/AKesp/old/snow_crab/images/snow-crab-bayes-model.png"

![Figure 2: An image of the EBS snow crab Bayesian adaptive sampling model output](../old/snow_crab/images/snow-crab-bayes-model.PNG)

##### Figure <a href="#fig:bayes">2</a>. Bayesian adaptive sampling model of EBS snow crab {-}
[1] "C:/Users/abigail.tyrell/Documents/ESP/AKesp/old/snow_crab/images/alaska-snow-crab.png"

![Figure 3: test](../old/snow_crab/images/alaska-snow-crab.png)

##### Figure <a href="#fig:imgtest">3</a>. test {-}
