# Alaska ESP templates

## The purpose of this package

This package was created to facilitate the development and maintenance of the Alaska Fisheries Science Center's Ecosystem and Socioeconomic Profiles.

### Create figures

This package can quickly generate styled figures based on indicator input data.

### Create ESP templates and reports

1. This package can create templates for ESP report cards. Up-to-date data is pulled from AKFIN and processed into figures and tables. The text is populated with default information and placeholders. The report is knit to Word, where it can be edited.

2. This package can create templates for partial and full ESP reports. After the user fills out these templates, this package can knit a final Word report, including pulling in figures and tables. 

## Files

### R folder

All functions have their own documentation files that can be accessed with the notation `?function_name`. Functions are grouped into different .R files based on what they do.

- `R/data.R` Documentation for data stored in the R package                                                                                  
- `R/data_functions.R` Functions that get and manipulate data                                                                        
- `R/figure_functions.R` Functions that create figures                                                                      
- `R/functions.R` Functions to produce .Rmds and associated outputs                                                                            
- `R/one-pager.R` Function that creates the "one-pager" ESP summary (shorter than a report card)
- `R/render_AKesp_book.R` Function that renders an ESP Standard Operating Procedure bookdown document (possibly outdated, not maintained)
- `R/table_functions.R` Function to create ESP "traffic light" table                                                                       
- `R/use_google_files.R` Function to use files from google drive to build ESP report (possibly outdated, not maintained)  
- `R/utils.R` Helper functions used behind the scenes                        

### data folder
- `data/indicator_order.rda` Hardcoded indicator order key                                                                  
- `data/metric_panel.rda` Metric panel data 

### data-raw folder
- `data-raw/create_data.R` Created R package data objects from spreadsheets                                                                   
- `data-raw/create_data_documentation.R` Created skeleton `data.R` file for documentation                                                      
- `data-raw/edges.csv` Documents connections between functions, data, and files used in this R package
- `data-raw/ESP_Indicators_2020.xlsx` Spreadsheet of indicator time series. Not needed if getting data from AKFIN.
- `data-raw/esp_lookup.R` Created indicator_order R data object                                                                     
- `data-raw/ESP_Lookup_Order.csv` Hardcoded indicator order spreadsheet                                                             
- `data-raw/nodes.csv` Documents functions, data, and files used in this R package
 `data-raw/panel5.csv` Metric panel data                                                                      
- `data-raw/visualization.R` Creates visual of connections between functions, data, and files used in this R package 

### inst folder
- `inst/esp-report-card-child.Rmd` Child Rmarkdown document that inserts ESP report card information
- `inst/esp-template.Rmd` Rmarkdown document that assembles the ESP report (do not edit)
- `inst/figure-child.Rmd` Child Rmarkdown document that inserts figures into the ESP report (do not edit)
- `inst/figure_spreadsheet.csv` Example figure identifier spreadsheet; used in report creation if no unique figures spreadsheet is provided.  
- `inst/full-esp-text-template.docx` Text template for full ESP report                                                          
- `inst/images/bayes.png` Default image of Bayesian Adaptive Sampling results                                                                     
- `inst/images/header.png` Default header for report card                                                                    
- `inst/images/noaa.jpg` Placeholder image for documents                                                                     
- `inst/partial-esp-text-template.docx` Text template for partial ESP report                                                       
- `inst/references.bib` Example references .bib; used in report creation if no unique references spreadsheet is provided.                               - `inst/references_spreadsheet.csv` Example references spreadsheet; used in report creation if no unique references spreadsheet is provided.            - `inst/table-child.Rmd` Child Rmarkdown document that inserts tables into the ESP report (do not edit)
- `inst/table_spreadsheet.csv` Example table identifier spreadsheet; used in report creation if no unique tables spreadsheet is provided.               - `inst/tables/example.csv` Example of how to include a spreadsheet that will be turned into a table in the ESP report
- `inst/template.docx` Template for Word document formatting (do not edit)

### docs folder

Contains the files that create the github pages website. Automatically created by `pkgdown`; do not edit.

### man folder

Automatically created by `roxygen2`; do not edit.

### vignettes folder

### old folder

Various old files for reference only.

#### book folder

Standard Operating Procedure document for this R package. Not recently maintained; likely redundant with the vignettes and `pkgdown` website.

#### shiny folder

Shiny app to produce "traffic light" table and figures for the stock of choice. Not recently maintained. 


-----
This repository is a scientific product and is not official communication of the National Oceanic and
Atmospheric Administration, or the United States Department of Commerce. All NOAA GitHub project code is
provided on an ‘as is’ basis and the user assumes responsibility for its use. Any claims against the Department of
Commerce or Department of Commerce bureaus stemming from the use of this GitHub project will be governed
by all applicable Federal law. Any reference to specific commercial products, processes, or services by service
mark, trademark, manufacturer, or otherwise, does not constitute or imply their endorsement, recommendation or
favoring by the Department of Commerce. The Department of Commerce seal and logo, or the seal and logo of a
DOC bureau, shall not be used in any manner to imply endorsement of any commercial product or activity by
DOC or the United States Government.
