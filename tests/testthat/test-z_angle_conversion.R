test_that("The function is able to convert angle in degrees to radians", {

  expect_true(
    is.numeric(z_angle_conversion(angle = 150,
                                  mode = 1))
  )

})

test_that("The function is able to convert angle in radians to degrees", {

  expect_true(
    is.numeric(z_angle_conversion(angle = 150,
                                  mode = 2))
  )

})

test_that("With the same angle value, mode 2 returns a higher value than mode 1", {

  angle <- 150

  expect_true(
    z_angle_conversion(angle = angle,
                       mode = 1) < z_angle_conversion(angle = angle,
                                                      mode = 2)
  )

})
