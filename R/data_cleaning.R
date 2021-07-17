## Mastering Software Development in R - Capstone Project
## M.A. Sondergard, July 2021

## Add documentation

# setwd("D:/Data Files/R Data/Coursera Data Science/Software Development/capstone")

# library(tidyverse)

# noaa_data <- read_delim("earthquakes-2021-06-28_09-38-35_-0600.tsv", delim = "\t")

#' @title Data Preparation for Earthquakes Database
#'
#' @description \code{eq_location_clean} function strips out country name and
#' converts column names to title case for readability.
#'
#' @param data Earthquakes data frame from NOAA database.
#'
#' @importFrom dplyr rename
#' @importFrom tidyr separate
#' @importFrom stringr str_to_title
#' @importFrom magrittr %>%
#'
#' @export
#'
## Function strips out country name and converts names to title case
## Takes a character vector as input
eq_location_clean <- function (data) {

  # Remove Search Parameter row and column
  data <- data[-1, ]
  data <- data[, -1]

  # Split Location Name into Country and specific Location_Name
  # Writes NA into Location_Name for entries with single entry
  data <- data %>% dplyr::rename("Country" = "Location Name") %>%
                   tidyr::separate("Country", c("Country", "Location_Name"),
                                   sep = ":", fill = "right", extra = "drop")

  # Set Location_Name(s) to title case
  data$Location_Name <- stringr::str_to_title(data$Location_Name)
  data$Country <- stringr::str_to_title(data$Country)

  return(data)
}

#' @title Data Preparation for Plotting
#'
#' @description \code{eq_clean_data} Prepares earthquakes data for plotting; consolidates date records
#'              into a single record (year-month-date format).
#'
#' @param data Earthquakes data set from NOAA database.
#'
#' @importFrom lubridate ymd
#' @importFrom dplyr select rename
#' @importFrom tidyselect everything
#'
#' @export

eq_clean_data <- function(data) {

  # Combine Year, Month and Day into a single variable with lubridate package
  data$Date_ymd <- lubridate::ymd(paste(data$Year,
                                        data$Mo,
                                        data$Dy,
                                        sep = "-"))

  data <- dplyr::select(data, -(Year:Sec))

  data <- dplyr::select(data, Date_ymd, everything())

  # Change all variable names to single entries (joined by underscores)
  names(data) <- gsub(" ", "_", names(data))
  data <- dplyr::rename(data, EQ_Primary = Mag)

  # Make sure that Latitude and Longitude are numeric variables
  data$Latitude <- as.numeric(data$Latitude)
  data$Longitude <- as.numeric(data$Longitude)

  return(data)
}

# noaa_data_location_clean <- eq_location_clean(noaa_data)

# earthquakes <- eq_clean_data(noaa_data_location_clean)

