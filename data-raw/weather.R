# libraries ----
library(tidyverse)
library(weatheR)

# data ----
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
         rain,
         snow,
         T_air_max,
         T_air_min)

# Saving ----
usethis::use_data(weather_blue_grass_airport,
                  overwrite = TRUE)
checkhelper::use_data_doc(name = "weather_blue_grass_airport",
                          description = "Observations of the blue grass airport weather station")
attachment::att_amend_desc()

