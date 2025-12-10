# c_weather_anomaly

To be correct, 30 years must be selected for the statistical analysis.

## Usage

``` r
c_weather_anomaly(
  data,
  year_start,
  year_end,
  months,
  day_start,
  day_end,
  years,
  source,
  plot_type = 1
)
```

## Arguments

- data:

  Dataframe with the columns `date`, `rain`, `T_air_max` and `T_air_min`
  respectively the date of the day, the rain (mm) and the maximum and
  minimum temperature (°C).

- year_start:

  Starting year to begin the statical analysis.

- year_end:

  End year to finish the statical analysis.

- months:

  Vector with the month to take into account.

- day_start:

  Start day to begin the statical analysis.

- day_end:

  End day to finish the statical analysis.

- years:

  A vector with a selection of years with potential anomaly. Selected
  years must be out of the range of years selected between `year_start`
  and `year_end`.

- source:

  Source of the data.

- plot_type:

  1 rain in ratio to mean, 2 rain in absolute value

## Value

List with `data_thirthy_years_avg`, `data_selected_years` and
`plot_selected_years`, the df with the thirthy years average temperature
and rainfall, the df with the average temperature and rainfall of the
selected years and the plot of the selected years.

## Examples

``` r
output <- c_weather_anomaly(data = weather_blue_grass_airport,
                            year_start = 1990,
                            year_end = 2019,
                            months = c(9,10,11,12,1,2,3),
                            day_start = 1,
                            day_end = 31,
                            years = c(2020,2021,2022,2023),
                            source = "Blue Grass Airport (Lexington)")
```
