test_that("class of outputs", {

  # Data ----
  data <- weather_blue_grass_airport

  # Example ----
  output <- c_ombrothermic_diagram(data = data,
                                   year_start = 1990,
                                   year_end = 2019,
                                   source = "test")

  # Test
  expect_true(is.data.frame(output[["table"]]))
  expect_true("ggplot" %in% class(output[["diagram"]]))

})
