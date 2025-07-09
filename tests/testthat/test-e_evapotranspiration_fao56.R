test_that("Checking the class of the output with and without correction", {

  # Without correction
  expect_true(
    is.numeric(
      e_evapotranspiration_fao56(altitude = 50,
                                 R_inc = 5,
                                 T_air_moy = 10,
                                 T_air_min = 8,
                                 T_air_max = 12)
    )
  )

  # With correction
  expect_true(
    is.numeric(
      e_evapotranspiration_fao56(altitude = 50,
                                 R_inc = 5,
                                 T_air_moy = 10,
                                 T_air_min = 8,
                                 T_air_max = 12,
                                 a = 10,
                                 b = 5)
    )
  )

})

test_that("ETP is higher with correction than without", {

  expect_gt(
    object = e_evapotranspiration_fao56(altitude = 50,
                                        R_inc = 5,
                                        T_air_moy = 10,
                                        T_air_min = 8,
                                        T_air_max = 12,
                                        a = 10,
                                        b = 5),
    expected =  e_evapotranspiration_fao56(altitude = 50,
                                           R_inc = 5,
                                           T_air_moy = 10,
                                           T_air_min = 8,
                                           T_air_max = 12)
  )

})
