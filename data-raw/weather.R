# libraries ----
library(tidyverse)
library(weatheR)

# data ----
## NOAA ----
weather_blue_grass_airport <- read.csv(
  file = system.file(
    "weatherdata",
    "lexington_blue_grass_airport_weather_data_1991_2024.csv",
    package = "weatheR"
  )
) %>%
  rename("date" = "DATE",
         "rain" = "PRCP",
         "snow" = "SNOW",
         "T_air_max" = "TMAX",
         "T_air_min" = "TMIN") %>%
  mutate(date = as.Date(date,
                        format = "%Y-%m-%d"),
         rain = as.numeric(rain),
         snow = as.numeric(snow),
         T_air_max = as.numeric(T_air_max),
         T_air_min = as.numeric(T_air_min)) %>%
  mutate(
    year = year(date),
    month = month(date),
    day = day(date),
    T_air_avg = (T_air_min + T_air_max)/2,
    snow_into_rain_mm = snow * weatheR::parameters[["mm_of_snow_to_mm_of_rain_usa"]],
    rain = rain + snow_into_rain_mm,
    across(c("T_air_min",
             "T_air_max",
             "T_air_avg"),
           ~ round(x = .,
                   digits = 1))
  ) %>%
  select(date,
         year,
         month,
         day,
         rain,
         snow,
         T_air_max,
         T_air_min,
         T_air_avg)

## NASAPOWER ----
nasapower_radiation_spindletop <- read.csv(
  file = system.file(
    "nasapower",
    "nasapower_radiation_spindletop_2018_2024.csv",
    package = "weatheR"
  )
) %>%
  rename("date" = "DATE",
         "radiation" = "ALLSKY_SFC_PAR_TOT") %>%
  mutate(date = as.Date(date,
                        format = "%d/%m/%Y"),
         radiation = as.numeric(radiation)) %>%
  select(date,
         radiation)

# Saving ----
usethis::use_data(weather_blue_grass_airport,
                  nasapower_radiation_spindletop,
                  overwrite = TRUE)
checkhelper::use_data_doc(name = "weather_blue_grass_airport",
                          description = "Observations of the blue grass airport weather station")
checkhelper::use_data_doc(name = "nasapower_radiation_spindletop",
                          description = "Observations of all sky solar radiation (PAR) from NASA POWER obtained at the coordiantes of the Landscape Nitrogen Position fields.")
attachment::att_amend_desc()

