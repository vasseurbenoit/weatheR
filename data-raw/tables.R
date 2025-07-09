# libraries ----
library(readxl)


# Tables ----
cover_crop_cardinal_temperatures <- read_xlsx(
  path = system.file(
    "extdata",
    "cover_crop_cardinal_temperatures.xlsx",
    package = "weatheR"
  )
)


# Saving ----
usethis::use_data(cover_crop_cardinal_temperatures,
                  overwrite = TRUE)
checkhelper::use_data_doc(name = "cover_crop_cardinal_temperatures",
                          description = "Base, optimum and maximum temperatures",
                          source = "10.1002/agg2.20393")
attachment::att_amend_desc()
