#' Interactive Earthquake Map and Related Data
#'
#' Generates interactive earthquake map and related data.
#'
#' \code{eq_map} creates an interactive \code{leaflet} map
#' showing the location of earthquakes in the given \code{earthquakes} data set.
#'
#' This function shows an interactive map of the location of the earthquakes in
#' the given \code{earthquakes} data.  The size of the circles are
#' proportional to the magnitude of the earthquakes (in the \code{EQ_PRIMARY})
#' variable. The map is interactive, and when you click on a link, the popup
#' shows the annotation as specified by the \code{annot_col} variable.
#'
#' @param data The \code{earthquakes} data frame based on information taken from
#' the NOAA earthquake databases. Because there is a lot of data, the user should
#'   filter to a single country or an adjacent group of countries.
#' @param annot_col A column to use for the popup annotation. The user can select a
#'   single column; otherwise you can create a more informative label first by using
#'   the \code{eq_create_label} function.
#'
#' @seealso \code{eq_create_label} to create a more informative popup
#'   annotation in the \code{earthquakes} data frame.
#'
#' @return Returns an interactive \code{leaflet} map.
#'
#' @importFrom dplyr filter mutate
#' @importFrom lubridate year
#' @importFrom leaflet leaflet addTiles addCircleMarkers
#' @importFrom magrittr %>%
#'
#' @export
#' @examples
#'
#' ## Using "Date_ymd" column as annotation
#' \dontrun{
#' earthquakes <- earthquakes %>%
#'    dplyr::filter(Country == 'China') %>%
#'    dplyr::filter(lubridate::year(Date_ymd) >= 2000)

#' eq_map(earthquakes, annot_col = 'Date_ymd')
#'
## Create a popup_text variable and use that for the label
#' earthquakes <- earthquakes %>%
#'  dplyr::filter(Country == 'China') %>%
#'  dplyr::filter(lubridate::year(Date_ymd) >= 2000) %>%
#'  dplyr::mutate(Popup_Text = eq_create_label(.)) %>%
#'  eq_map(annot_col = "Popup_Text")
#' }

## eq_map() function generates the map and marks the locations of each earthquake
## in the dataset based on longitude and latitude
eq_map <- function(data, annot_col = "Date_ymd")
  {
    leaflet::leaflet() %>%
    leaflet::addTiles() %>%
    leaflet::addCircleMarkers(
                              lng = data$Longitude,
                              lat = data$Latitude,
                              radius = data$EQ_Primary,
                              weight = 1,
                              popup = data[[annot_col]],
                              stroke = FALSE,
                              fillOpacity = 0.5
                              )

}

#' Popup Label for Earthquake Map
#'
#' Generates HTML labels for earthquake map
#'
#' \code{eq_create_label} creates a more descriptive and HTML-formatted popup
#' label to be used in \code{\link{eq_map}}.
#'
#' This function creates a vector of HTML-formatted labels using supplied
#' \code{earthquakes} data.  The function creates lines of the format
#' \strong{Label:} \code{ value} from the following variables in the
#'  \code{earthquakes} data set:
#' \itemize{
#'   \item Date_ymd
#'   \item Location_Name (as cleaned in the \code{eq_location_clean}
#'   function).
#'   \item EQ_Primary (earthquake magnitude)
#'   \item Total_Deaths
#' }
#' Any of the above variables with missing/NA values are omitted from the label.
#'
#' @param data The \code{earthquakes} data frame.
#'
#' @return A vector with the HTML-formatted labels. Include this
#' vector with the data frame that is sent to \code{eq_map}.
#'
#' @export
#'
#' @examples
#'
# Create a popup_text variable and use that for the label
#'\dontrun{
#' earthquakes <- earthquakes %>%
#'  dplyr::filter(Country == 'China') %>%
#'  dplyr::filter(lubridate::year(Date_ymd) >= 2000) %>%
#'  dplyr::mutate(Popup_Text = eq_create_label(.))
#'  eq_map(earthquakes, annot_col = "Popup_Text")
#' }

# eq_create_label() function returns a label with HTML formatting

 eq_create_label <- function(data) {
    paste(
        ifelse(is.na(data$Location_Name), "",
               paste("<b>Location: </b>", data$Location_Name, "<br/>")
        ),
        ifelse(is.na(data$EQ_Primary), "",
               paste("<b>Magnitude: </b>", data$EQ_Primary, "<br/>")
        ),
        ifelse(is.na(data$Total_Deaths), "",
               paste("<b>Total deaths: </b>", data$Total_Deaths, "<br/>"))
     )
  }

