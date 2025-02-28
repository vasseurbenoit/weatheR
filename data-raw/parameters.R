# Parameters ----
parameters <- list("inch_to_mm" = 2.54 * 10,
                   "mm_of_snow_to_mm_of_rain_usa" = 1/13, # NSSL Severe Weather 101 - Winter Weather
                   "y_scale_ombrothermic_diagram" = 2)

# Saving ----
usethis::use_data(parameters,
                  overwrite = TRUE,
                  internal = TRUE)
