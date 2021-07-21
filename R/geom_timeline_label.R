## Coursera - Mastering Software Development in R
## Capstone Project
## July, 2021

## ----------------------------------------------------------------------------
# Summary
# geom_timeline_label() adds annotations to the earthquake data.  Geom adds a
# vertical line to each data point with text annotation providing the location
# of the earthquake.

# The x aesthetic is a date of the earthquake and label which takes the column
# name from which annotations will be obtained.

# library(tidyverse)
# library(grid)

# Test script
# earthquakes %>%
#   dplyr::filter(Country %in% c("China", "New Zealand")
#   ) %>%
#   dplyr::filter(Date_ymd > "2000-01-01"
#   ) %>%
#   dplyr::select(Date_ymd, Country, Location_Name, Latitude,
#                 Longitude, EQ_Primary, Total_Deaths
#   ) %>%
#   tidyr::drop_na(Location_Name
#   ) %>%
#   ggplot() +
#   geom_timeline(aes(x = Date_ymd,
#                     y = Country,
#                     colour = Total_Deaths,
#                     size = EQ_Primary)) +
#
#   geom_timeline_label(aes(x = Date_ymd,
#                           magnitude = EQ_Primary,
#                           label = Location_Name,
#                           y = Country,
#                           n_max = 5)) +
#
#   scale_size_continuous(name = "Richter Scale Magnitude") +
#   scale_colour_continuous(name = "Total Deaths",
#                           type = "viridis") +
#   theme_light() +
#   xlab("Year")

## ----------------------------------------------------------------------------
##
#' @title Generate annotations for points on map of earthquake data
#'
#' @description \code{geom_timeline_label()} adds annotations to the earthquake data.
#' The geom adds a vertical line to each data point with text annotation providing
#' the location of the earthquake. This is a function that builds a layer, based
#'  on a \code{Geom} specification. It takes the geom definition and the coordinate data together.
#'
#' @param mapping Set of aesthetic mappings created by aes(). If specified and
#' inherit.aes = TRUE (the default), it is combined with the default mapping at
#' the top level of the plot.
#' @param data The data to be displayed in this layer.
#' @param stat The statistical transormation to use on the data for this layer,
#' as a string.
#' @param position Position adjustment, either as a string or the result of a
#' call to a position adjustment function.
#' @param na.rm If FALSE, missage values are removed with a warning.
#' @param show.legend Should this layer be included, any aesthetics are mapped.
#' @param inherit.aes If FALSE, overrides the default aesthetics, rather than
#' combining them.
#' @param ... Other parameters to be included.

#' @import ggplot2
#' @import grid
#' @export

geom_timeline_label <- function(mapping = NULL,
                                data = NULL,
                                stat = "identity",
                                position = "identity",
                                na.rm = FALSE,
                                show.legend = NA,
                                inherit.aes = TRUE, ...)
  {
  ggplot2::layer(
      geom = GeomTimelineLabel,
      mapping = mapping,
      data = data,
      stat = stat,
      position = position,
      show.legend = show.legend,
      inherit.aes = inherit.aes,
      params = list(na.rm = na.rm, ...)
      )
  }

## ----------------------------------------------------------------------------
#' @title       GeomTimelineLabel
#' @description ggproto object to display the labels for earthquake time line
#'
#' @import ggplot2
#' @importFrom dplyr mutate
#' @importFrom dplyr top_n
#' @export

## gproto() function is used to construct a new class corresponding
## to the new geom.  Specifies attributes and functions that describe how
## data should be drawn on plot

GeomTimelineLabel <- ggplot2::ggproto("GeomTimelineLabel",
                                       ggplot2::Geom,
                                       required_aes = c("x",
                                                        "label",
                                                        "magnitude"),

                                       default_aes = ggplot2::aes(y = 0,
                                                                  size = 0.5,
                                                                  colour = "lightblue",
                                                                  linetype = 1,
                                                                  n_max = 5,
                                                                  alpha = NA
                                             ),
                             # Function that is used to draw the key in legend
                             draw_key = ggplot2::draw_key_point,

                             # Function that returns a grid grob to be plotted
                             #    "data" element is df with 1 column for each
                             #           aesthetic
                             #    "panel_scales" list describing x and y scales
                             #    "coord" describes coordinate system
                             draw_panel = function(data, panel_scales, coord)
                               {
                                 n_max = data$n_max[1]

                                 data <- data %>%
                                         # Scale magnitude from 0 to 1.5
                                         dplyr::mutate(magnitude = magnitude/
                                                         max(magnitude) * 1.5) %>%
                                         # Extract n_max events
                                         dplyr::top_n(n_max, magnitude)

                                 # Vertical line
                                 data$xend <- data$x
                                 data$yend <- data$y + 0.1
                                 g1 <- ggplot2::GeomSegment$draw_panel(unique(data),
                                                              panel_scales, coord)

                                 # grob for text label
                                 data$y <- data$yend + 0.03
                                 data$angle <- 45
                                 data$linetype <- 3
                                 data$lineheight <- 2
                                 data$hjust <- "left"
                                 data$vjust <- "top"
                                 data$family <- "sans"
                                 data$fontface <- 1
                                 data$size <- 3
                                 data$colour <- "black"

                                 g2 <- ggplot2::GeomText$draw_panel(unique(data),
                                                           panel_scales, coord)
                                 # "grob" stands for graphical object
                                 grobTree(g1, g2)

                        }
    )
