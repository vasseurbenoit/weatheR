test_that("class of outputs", {

  # Data ----
  data <- data.frame(date = seq(as.Date("1990-01-01"),
                                as.Date("2019-12-01"),
                                1),
                     rain = 100,
                     T_air_max = 10,
                     T_air_min = 0)

  # Example ----
  output <- c_ombrothermic_diagram(data = data,
                                   year_start = 1990,
                                   year_end = 2019,
                                   source = "test")

  # Test
  expect_true(is.data.frame(output[["table"]]))
  expect_true("ggplot" %in% class(output[["diagram"]]))

})
