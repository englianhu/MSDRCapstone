library(testthat)

# expect_type(eq_clean_data(eq_location_clean(noaa_data)), "list")

# earthquake_map <- eq_location_clean(noaa_data) %>%
#                   eq_clean_data() %>%
#                   dplyr::filter(Country == 'China') %>%
#                   dplyr::filter(lubridate::year(Date_ymd) >= 2000) %>%
#                   eq_map(., annot_col = 'Date_ymd')
#
# expect_type(earthquake_map, "list")
