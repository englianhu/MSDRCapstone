## MSDRCapstone Package tests using testthat() package

test_that("Functions correctly complete initial clean-up",
    {
      expect_type(eq_location_clean(noaa_data), "list")
      expect_type(eq_clean_data(eq_location_clean(noaa_data)), "list")
    })

test_that("Eq_map function produced correct file type",
    {
      expect_type(
        eq_map(
          eq_clean_data(
            eq_location_clean(noaa_data)), annot_col = 'Date_ymd')
               , "list")
      expect_s3_class(
        eq_map(
          eq_clean_data(
            eq_location_clean(noaa_data)), annot_col = 'Date_ymd')
               , "leaflet")
      })
