# c_ombrothermic_diagram

Plot ombrothermic diagram for a set of weather data.

On the y scale, one temperature unit equals two rain unit. To be
correct, 30 years must be selected for the statistical analysis.

## Usage

``` r
c_ombrothermic_diagram(data, year_start, year_end, source)
```

## Arguments

- data:

  Dataframe with the columns `date`, `rain`, `T_air_max` and `T_air_min`
  respectively the date of the day, the rain (mm) and the maximum and
  minimum temperature (°C).

- year_start:

  Start year to begin the statical analysis.

- year_end:

  End year to finish the statical analysis.

- source:

  Source of the data.

## Value

List with `table` and `diagram`. The table is used to build the
ombrothermic plot.

## Examples

``` r
output <- c_ombrothermic_diagram(data = weather_blue_grass_airport,
                                 year_start = 1991,
                                 year_end = 2020,
                                 source = "Blue Grass Airport (Lexington)")
```
