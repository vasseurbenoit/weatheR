test_that("conversion are correct", {

  expect_equal(
    object = round(t_fahrenheit_celcius(T_air_fahrenheit = 72),
                   digits = 0),
    expected = 22)

  expect_equal(
    object = round(t_fahrenheit_celcius(T_air_celcius = 22.22),
                   digits = 0),
    expected = 72)

})
