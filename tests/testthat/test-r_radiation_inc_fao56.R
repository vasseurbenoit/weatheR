test_that("Checking the class of the output with and without correction", {

  # Without correction
  expect_true(
    is.numeric(
      r_radiation_inc_fao56(longitude = 80,
                            latitude = 40,
                            altitude = 50,
                            date = "2020-08-10",
                            T_air_min = 8,
                            T_air_max = 12)
    )
  )

  # With correction
  expect_true(
    is.numeric(
      r_radiation_inc_fao56(longitude = 80,
                            latitude = 40,
                            altitude = 50,
                            date = "2020-08-10",
                            T_air_min = 8,
                            T_air_max = 12,
                            a = 10,
                            b = 5)
    )
  )

})

test_that("Radiation is higher with correction than without", {

  expect_gt(
    object = r_radiation_inc_fao56(longitude = 80,
                                   latitude = 40,
                                   altitude = 50,
                                   date = "2020-08-10",
                                   T_air_min = 8,
                                   T_air_max = 12,
                                   a = 10,
                                   b = 5),
    expected =  r_radiation_inc_fao56(longitude = 80,
                                      latitude = 40,
                                      altitude = 50,
                                      date = "2020-08-10",
                                      T_air_min = 8,
                                      T_air_max = 12)
  )

})
