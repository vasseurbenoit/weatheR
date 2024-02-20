# Parameters ----
parameters <- list("inch_to_mm" = 2.54 * 10,
                   "y_scale_ombrothermic_diagram" = 2)

# Saving ----
usethis::use_data(parameters,
                  overwrite = TRUE,
                  internal = TRUE)
