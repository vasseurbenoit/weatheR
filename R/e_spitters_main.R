e_spitters_main <- function(latitude){

  # Solar declination
  solar_declination <- -sin(23.45) * cos((360 * (julian_day + 10))/ 365)

  # Solar elevatioon `beta` at hour `julian_day`
  sin_beta <-
    sin(latitude) *
    solar_declination +
    cos(latitude) *
    solar_declination *
    cos(15 * (julian_day - 12))

  # daylength
  daylength <- 12 + 24/180 * asin(tan(latitude) - tan(solar_declination))

  #

}
