% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data_functions.R
\name{get_esp_data}
\alias{get_esp_data}
\title{Pull ESP data}
\usage{
get_esp_data(stock = NULL)
}
\arguments{
\item{stock}{The name of the stock to pull data for. Use \code{AKesp::esp_stock_options()} to view current options. Leave as NULL to get all data.}
}
\value{
A tibble
}
\description{
This function pulls ESP data on a specific stock from the AKFIN web service.
}
