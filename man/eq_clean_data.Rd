% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data_cleaning.R
\name{eq_clean_data}
\alias{eq_clean_data}
\title{Data Preparation for Plotting}
\usage{
eq_clean_data(data)
}
\arguments{
\item{data}{Earthquakes data set from NOAA database.}
}
\description{
\code{eq_clean_data} Prepares earthquakes data for plotting; consolidates
             date records into a single record (year-month-day format) and removes
             columns with separate Year, Month and Day values.  Also changes variable
             names with spaces to single names with text joined by an underscore (_)
             character.
}
\examples{
\dontrun{
earthquakes <- eq_clean_data(earthquakes)
}
}
