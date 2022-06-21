#' @title Metric panel data
#' @description DATASET_DESCRIPTION
#' @format A data frame with 476 rows and 20 variables:
#' \describe{
#'   \item{\code{Stock}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Group}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Region}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Metric}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Category}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Use}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Threshold.Value.High}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Threshold.Value.Low}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Reverse}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Mean}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Stdev}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Max}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Min}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Value}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Quality}}{double COLUMN_DESCRIPTION}
#'   \item{\code{Order1}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{Order2}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{Rank0}}{character COLUMN_DESCRIPTION}
#'   \item{\code{Flag}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{Rank}}{character COLUMN_DESCRIPTION}
#' }
#' @details DETAILS
"metric_panel"

#' @title Indicator order key for graphics
#' @description Indicator order key for graphics
#' @format A data frame with 148 rows and 12 variables:
#' \describe{
#'   \item{\code{SOURCE_TARGET_NAME}}{character Indicator name (shortened)}
#'   \item{\code{PRODUCT}}{character Indicator name}
#'   \item{\code{REPORT_CARD_TITLE}}{character Indicator name (human-friendly)}
#'   \item{\code{Intended.ESP}}{character Stock name to which the indicator applies}
#'   \item{\code{SUBMISSION_YEAR}}{integer Year the indicator was first included}
#'   \item{\code{GATE1_YEAR}}{integer Year the indicator was added to the ESP}
#'   \item{\code{GATE2_YEAR}}{integer Year the indicator was added to the stock assessment model}
#'   \item{\code{REMOVED_YEAR}}{integer Year the indicator was removed from the ESP}
#'   \item{\code{SIGN}}{integer +1 for positive effect on stock, -1 for negative effect}
#'   \item{\code{WEIGHT}}{integer Relative importance of the indicator for the stock}
#'   \item{\code{ORDER}}{integer Order to display indicators in (no repeated numbers)}
#'   \item{\code{ORDER2}}{integer Order to display indicators in (repeated numbers)}
#' }
#' @details DETAILS
"indicator_order"
