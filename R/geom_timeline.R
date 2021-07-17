## Coursera - Mastering Software Development in R
## Capstone Project
## July, 2021

## ----------------------------------------------------------------------------
# Summary
# geom_timeline() plots a time line for earthquakes ranging from "xmin" to "xmax"
# dates, with a point for each earthquake.  The x aesthetic is a date and the
# y aesthetic is a factor indicating some stratification, in which case multiple
# time lines will be plotted for each level of the factor (e.g. country).

# library(tidyverse)
# library(grid)
#
# # Test script
# earthquakes %>%
#                 dplyr::filter(Country %in% c("Afghanistan")
#                 ) %>%
#                 dplyr::filter(Date_ymd > "2000-01-01"
#                 ) %>%
#                 ggplot() +
#                     geom_timeline(aes(x = Date_ymd,
#                                       y = Country,
#                                       colour = Total_Deaths,
#                                       size = EQ_Primary)) +
#                     scale_size_continuous(name = "Richter Scale Magnitude") +
#                     scale_colour_continuous(name = "Total Deaths",
#                                             type = "viridis") +
#                     theme_light() +
#                     xlab("Year")
#

## ----------------------------------------------------------------------------
##
#' @title geom_timeline
#' @description Function that builds a layer based on geom specification; takes
#'              the geom definition and the coordinate data together.
#'
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
#'
#' @importFrom ggplot2 layer
#' @import grid
#' @export

geom_timeline <- function(mapping = NULL,
                          data = NULL,
                          stat = "identity",
                          position = "identity",
                          na.rm = FALSE,
                          show.legend = NA,
                          inherit.aes = TRUE, ...)
{
  ggplot2::layer(
      geom = GeomTimeline,
      mapping = mapping,
      data = data,
      stat = stat,
      position = position,
      show.legend = show.legend,
      inherit.aes = inherit.aes,
      params = list(na.rm = na.rm, ...))

}

## ----------------------------------------------------------------------------
#' @title       GeomTimeline
#' @description ggproto object to display the earthquake time line
#
#' @importFrom ggplot2 ggproto Geom aes draw_key_point
#' @import grid
#' @importFrom dplyr select
#' @export
#'

## gproto() function is used to construct a new class corresponding
## to the new geom

GeomTimeline <- ggplot2::ggproto("GeomTimeline", ggplot2::Geom,
                                  required_aes = c("x"),

                                  default_aes = ggplot2::aes(y = 0,
                                                             size = 1.5,
                                                             colour = "black",
                                                             alpha = 0.5,
                                                             shape = 16,
                                                             fill = NA
                                                             ),

        # Data transformation for draw panel
        draw_key = ggplot2::draw_key_point,

        draw_panel = function(data, panel_scales, coord)
            {
              coords <- coord$transform(data, panel_scales)

              coords$size <- coords$size / max(coords$size) + 1.5

              grid::pointsGrob(
                                x = coords$x,
                                y = coords$y,
                                pch = coords$shape,
                                gp = grid::gpar(
                                                col   = coords$colour,
                                                alpha = coords$alpha,
                                                cex   = coords$size
                                                )
                              )
             }
  )
