# Parameters ----
parameters <- list(

  "inch_to_mm" = 2.54 * 10,
  "mm_of_snow_to_mm_of_rain_usa" = 1/13, # NSSL Severe Weather 101 - Winter Weather
  "y_scale_ombrothermic_diagram" = 2,

  # Parameters used in the FAO56 method ----
  Gsc = 0.0820, # constante solaire (MJ/m2/min)
  sigma_botlzmann = 4.903*10^-9, # constante de Stefan-Boltzmann (MJ/K^4/m^2/j)
  k_rs = 0.16 # parametre a optimsier?

)

# Saving ----
usethis::use_data(parameters,
                  overwrite = TRUE)
checkhelper::use_data_doc(name = "parameters",
                          description = "List of parameters used in the package.")
attachment::att_amend_desc()
