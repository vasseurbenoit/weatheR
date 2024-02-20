# libraries ----
library(tidyverse)
library(weatheR)

# data ----
weather_blue_grass_airport <- read.csv(
  file = system.file(
    "extdata",
    "weather_data_blue_grass_airport.csv",
    package = "dssat.intercropping"
  )
) %>%
  mutate(date = as.Date(date,
                        format = "%m/%d/%Y"),
         rain = as.numeric(rain),
         snow = as.numeric(snow),
         T_air_max = as.numeric(T_air_max),
         T_air_min = as.numeric(T_air_min)) %>%
  mutate_all(~replace(., is.na(.), 0)) %>% #FLAG.
  mutate(
    T_air_min = t_fahrenheit_celcius(T_air_fahrenheit = T_air_min),
    T_air_max = t_fahrenheit_celcius(T_air_fahrenheit = T_air_max),
    T_air_avg = (T_air_min + T_air_max)/2,
    rain = rain * parameters[["inch_to_mm"]],
    snow = snow * parameters[["inch_to_mm"]],
    year = year(date),
    month = month(date),
    day = day(date),
    across(c("T_air_min",
             "T_air_max",
             "T_air_avg"),
           ~ round(x = .,
                   digits = 1))
  )



# Saving ----
usethis::use_data(weather_blue_grass_airport,
                  overwrite = TRUE)
checkhelper::use_data_doc(name = "weather_blue_grass_airport",
                          description = "Observations of the blue grass airport weather station")
attachment::att_amend_desc()

