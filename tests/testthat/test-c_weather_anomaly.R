test_that("class of outputs", {

  # Plot type 1 ----
  ## Data
  data <- data.frame(date = seq(as.Date("1990-01-01"),
                                as.Date("2019-12-01"),
                                1),
                     rain = 100,
                     T_air_max = 10,
                     T_air_min = 0)

  ## Example
  output <- c_weather_anomaly(data = weather_blue_grass_airport,
                              year_start = 1990,
                              year_end = 2019,
                              months = c(9,10,11,12,1,2,3),
                              day_start = 1,
                              day_end = 31,
                              years = c(2020,2021,2022,2023),
                              source = "Blue Grass Airport (Lexington)")

  ## Test
  expect_true(is.data.frame(output[["data_thirthy_years_avg"]]))
  expect_true(is.data.frame(output[["data_selected_years"]]))
  expect_true("ggplot" %in% class(output[["plot_selected_years"]]))


  # Plot type 2 ----
  ## Data
  data <- data.frame(date = seq(as.Date("1990-01-01"),
                                as.Date("2019-12-01"),
                                1),
                     rain = 100,
                     T_air_max = 10,
                     T_air_min = 0)

  ## Example
  output <- c_weather_anomaly(data = weather_blue_grass_airport,
                              year_start = 1990,
                              year_end = 2019,
                              months = c(9,10,11,12,1,2,3),
                              day_start = 1,
                              day_end = 31,
                              years = c(2020,2021,2022,2023),
                              source = "Blue Grass Airport (Lexington)",
                              plot_type = 2)

  ## Test
  expect_true(is.data.frame(output[["data_thirthy_years_avg"]]))
  expect_true(is.data.frame(output[["data_selected_years"]]))
  expect_true("ggplot" %in% class(output[["plot_selected_years"]]))

})
