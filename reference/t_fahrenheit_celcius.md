# t_fahrenheit_celcius

Conversion of degree Fahrenheit intp degree celcius and vice-versa.

## Usage

``` r
t_fahrenheit_celcius(T_air_celcius = NA, T_air_fahrenheit = NA)
```

## Arguments

- T_air_celcius:

  Air temperature (°C).

- T_air_fahrenheit:

  Air temperature (°F).

## Value

Converted air temperature.

## Examples

``` r
# From fahrenheit to celcius
t_fahrenheit_celcius(T_air_fahrenheit = 72)
#> [1] 22.22222

# From celcius to fahrenheit
t_fahrenheit_celcius(T_air_celcius = 22)
#> [1] 71.6
```
