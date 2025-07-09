test_that("Checking the class of the output", {

  # Method A - linear - small grains
  output_a <- t_growing_degree_days(T_air_avg = 15,
                                    T_base = 5,
                                    method = "A")

  expect_true(is.list(output_a))
  expect_true(
    all(
      c("rate_of_development",
        "growing_degree_days") %in% names(output_a)
    )
  )

  # Method B - linear - corn
  output_b <- t_growing_degree_days(T_air_min = 15,
                                    T_air_max = 25,
                                    T_base = 10,
                                    method = "B")

  expect_true(is.list(output_b))
  expect_true(
    all(
      c("rate_of_development",
        "growing_degree_days") %in% names(output_b)
    )
  )

  # Method C - triangle
  output_c <- t_growing_degree_days(T_air_avg = 15,
                                    T_base = 5,
                                    T_opt = 10,
                                    T_max = 20,
                                    method = "C")

  expect_true(is.list(output_c))
  expect_true(
    all(
      c("rate_of_development",
        "growing_degree_days") %in% names(output_c)
    )
  )

  # Method D - trapezoidal
  output_d <- t_growing_degree_days(T_air_avg = 15,
                                    T_base = 5,
                                    T_opt_1 = 12,
                                    T_opt_2 = 18,
                                    T_max = 20,
                                    method = "D")

  expect_true(is.list(output_d))
  expect_true(
    all(
      c("rate_of_development",
        "growing_degree_days") %in% names(output_d)
    )
  )

})

test_that("The function returns a message when the selected method is not available", {

  expect_error(
    t_growing_degree_days(T_air_avg = 15,
                          T_base = 5,
                          T_opt_1 = 12,
                          T_opt_2 = 18,
                          T_max = 20,
                          method = "Z")
  )

})
