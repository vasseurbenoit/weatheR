test_that("Checking the class of the output", {

  expect_true(is.numeric(z_pression_atm(500)))

})

test_that("The atmospheric decreases with the altitude", {

  expect_true(z_pression_atm(500) > z_pression_atm(1000))

})


