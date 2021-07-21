## MSDRCapstone Package tests using testthat() package

test_that("Data cleaning functions correctly complete initial clean-up",
    {
      expect_s3_class(eq_location_clean(noaa_data), "data.frame")
      expect_s3_class(eq_clean_data(eq_location_clean(noaa_data)), "data.frame")
      expect_identical(names(
                    eq_clean_data(eq_location_clean(noaa_data))[1]), "Date_ymd")
    })

test_that("Eq_map() function produces a leaflet object",
    {
      expect_s3_class(
        eq_map(
          eq_clean_data(
            eq_location_clean(noaa_data)), annot_col = 'Date_ymd')
               , "leaflet")
      })

test_that("geom_timeline() and geom_timeline_label() functions generate a ggplot
          object",
          {
            test_plot <- noaa_data |>
                         eq_location_clean() |>
                         eq_clean_data() |>
                         dplyr::filter(Country %in% c("China", "New Zealand")
                         ) |>
                         dplyr::filter(Date_ymd > "2000-01-01"
                         ) |>
                         dplyr::select(Date_ymd, Country, Location_Name, Latitude,
                                       Longitude, EQ_Primary, Total_Deaths
                         ) |>
                         tidyr::drop_na(Location_Name
                         ) |>
            ggplot() +
                geom_timeline(aes(x = Date_ymd,
                                  y = Country,
                                  colour = Total_Deaths,
                                  size = EQ_Primary)) +

                geom_timeline_label(aes(x = Date_ymd,
                                        magnitude = EQ_Primary,
                                        label = Location_Name,
                                        y = Country,
                                        n_max = 5))
      expect_s3_class(test_plot , "ggplot")
      })
