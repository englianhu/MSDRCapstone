
<!-- README.md is generated from README.Rmd. Please edit that file -->

# MSDR Capstone Project - Interactive Earthquake Map

Package: MSDRCapstone - completed as part of Coursera Mastering Software
Development with R Specialization.

GitHub: <https://github.com/SondergardM/MSDRCapstone>

## Travis badge

<!-- badges: start -->

[![R-CMD-check](https://github.com/SondergardM/MSDRCapstone/workflows/R-CMD-check/badge.svg)](https://github.com/SondergardM/MSDRCapstone/actions)

[macOS: ![R](https://github.com/englianhu/MSDRCapstone/actions/workflows/R-macos.yaml/badge.svg)](https://github.com/MSDRCapstone/farsdata/actions/workflows/R-macos.yaml) [Ubuntu: ![R](https://github.com/englianhu/MSDRCapstone/actions/workflows/R-ubuntu.yaml/badge.svg)](https://github.com/MSDRCapstone/farsdata/actions/workflows/R-ubuntu.yaml)
<!-- badges: end -->

## Data Source

The functions in this R package utilize data from the US National
Oceanic and Atmospheric Administration’s (NOAA’s) National Center for
Environmental Information (NCEI) [Global Significant Earthquake
Database](https://www.ngdc.noaa.gov/hazard/earthqk.shtml), which is a
covers significant earthquakes from 2150 B.C. to the present. For the
purposes of this package, data was downloaded from the year 2000 A.D. to
the present and has been included in the package (data set
**noaa\_data**). The data set includes 1219 observations and 39 fields.

## Package Summary

The functions in this package are designed to utilize data from NOAA’s
earthquake database and produce two basic sets of plots: (1) the first
is an earthquake timeline for a given country (or countries) that shows
the date and magnitude of the earthquake, along with data labels for the
five most significant quakes in the data chosen by the user; (2) an HTML
map showing the geographic locale of the earthquake along with either a
date or other related data shown as a pop-up label when the user clicks
on a given earthquake location.

The package consists of six (6) functions:

-   **eq\_location\_clean()** - Function strips out country name for
    data downloaded from the NOAA earthquake database and converts the
    column names to title case for readability.

-   **eq\_clean\_data()** - Function combines Year, Month and Day fields
    into a single date variable and prepares the data for use in plots.

-   **geom\_timeline()** - Function plots a time line for earthquakes
    ranging from “xmin” to “xmax” dates, with a point for each
    earthquake. The x aesthetic is a date and the y aesthetic is a
    factor indicating some stratification, in which case multiple time
    lines will be plotted for each level of the factor (e.g. country).

-   **geom\_timeline\_label()** - Function adds annotations to the
    earthquake data provided by the geom\_timeline() function. The geom
    adds a vertical line to each data point with a text annotation
    providing the location of the earthquake. The x aesthetic is a date
    of the earthquake and a label which takes the column name from which
    annotations will be obtained.

-   **eq\_map()** - Function creates an interactive map showing the
    location of earthquakes in the given earthquakes data set. The size
    of the circles in the map are proportional to the magnitude of the
    earthquakes. The map is interactive, and when you click on a link, a
    popup label shows the annotation as specified by the **annot\_col**
    variable.

-   **eq\_create\_label()** - Function creates a more descriptive and
    HTML-formatted popup label to be used with the **eq\_map()**
    function. This function creates a vector of HTML-formatted labels
    using supplied data from the eathquakes data set. The label contains
    the following information:

    -   Date in YMD format
    -   Location Name (as cleaned by the **eq\_location\_clean()**
        function)
    -   Earthquake magnitude (Richter scale)
    -   Total Deaths caused by the event

Further documentation can be found in the package documentation for each
individual function.

## Useful Reference Links:

-   [Common `roxygen2`
    tags](https://bookdown.org/rdpeng/RProgDA/documentation.html#common-roxygen2-tags)
-   [R Packages (book)](https://r-pkgs.org/)
-   [Writing R
    Extensions](https://cran.r-project.org/doc/manuals/R-exts.html#Creating-R-packages)
-   [Testing packages](http://r-pkgs.had.co.nz/tests.html)
-   [Travis: Building R
    packages](https://docs.travis-ci.com/user/languages/r/)
