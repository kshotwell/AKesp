% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/functions.R
\name{render_esp}
\alias{render_esp}
\title{Create an ESP}
\usage{
render_esp(
  out_name = "EXAMPLE-ESP.docx",
  esp_dir = getwd(),
  ...,
  ref_spreadsheet = "references_spreadsheet.csv",
  esp_data = NULL,
  google_folder_url = NULL,
  render_ref = FALSE
)
}
\arguments{
\item{out_name}{The file name for the report}

\item{esp_dir}{The directory with your ESP files. This folders should have been populated with the ESP template files. The ESP will be saved here.}

\item{...}{Parameters passed to the Rmarkdown. See details.}

\item{ref_spreadsheet}{The file path to the filled out references spreadsheet (one of the template documents; optional)}

\item{esp_data}{The data to use for automated analyses.}

\item{google_folder_url}{The URL of the google drive folder holding the template materials (optional)}

\item{render_ref}{Whether to render references in markdown from a references spreadsheet}
}
\value{
Suggestions for parameters are:
\itemize{
\item num: The appendix number of the EPS
\item authors: The names of the authors, as a single character string
\item year: The year of the ESP
\item contributors: The names of the contributors, as a single character string
\item fish: The name of the fish species
\item region: The name of the stock area
\item fig_spreadsheet: The file path to the filled out figure spreadsheet (one of the template documents)
\item tab_spreadsheet: The file path to the filled out table spreadsheet (one of the template documents)
\item esp_text: The file path to the filled out text template (one of the template documents)
\item esp_type: The type of ESP to make. One of c("full", "partial", "report_card")
\item con_model_path: The path to the conceptual model. Currently only required for report card ESPs.
\item stock_image: The path to an image to use on the cover page. Shows the NOAA logo as a default.
\item bayes_path: The path to the image of Bayesian Adaptive Sampling results
}
}
\description{
This function creates an ESP from a template. If left empty, an example report will be created.
}
\details{
Additional arguments are passed as parameters to the ESP Rmarkdown report.
}
