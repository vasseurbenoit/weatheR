# Growing degree days calculation

Calculation of the daily thermal unit. Two methods are available.

- Method A - linear - small grains: use of T_air_avg and T_base. Method
  widely used for the calculation of the daily thermal unit of small
  grain cereals and in simulation models.

- Method B - linear: use of T_air_min, T_air_max and T_base. Method
  widely used for the calculation of the daily thermal unit of corn.

- Method C - triangle: use of T_air_avg, T_base, T_opt and T_max.

- Method D - trapezoid: use of T_air_avg, T_base, T_opt_1, T_opt_2 and
  T_max.

## Usage

``` r
t_growing_degree_days(
  T_air_avg,
  T_air_min = NA,
  T_air_max = NA,
  T_base,
  T_opt = NA,
  T_opt_1 = NA,
  T_opt_2 = NA,
  T_max = NA,
  method = "A"
)
```

## Arguments

- T_air_avg:

  Average air temperature (°C). Required for methods A, C, D.

- T_air_min:

  Minimum air temperature (°C). Required for method B only.

- T_air_max:

  Maximum air temperature (°C). Required for method B only.

- T_base:

  Base air temperature of a crop (°C)

- T_opt:

  Optimum air temperature of a crop (°C)

- T_opt_1:

  First optimum temperature of a crop (°C)

- T_opt_2:

  Second optimum temperature of a crop (°C)

- T_max:

  Maximum air temperature of a crop (°C)

- method:

  Selection of the calculation method:

  - Method A: Linear - small grains

  - Method B: Linear - corn

  - Method C: Triangle

  - Method D: Trapezoidal

## Value

Daily thermal unit (°Cj)

## Examples

``` r
# Method A - linear - small grains
t_growing_degree_days(T_air_avg = 15,
                      T_base = 5,
                      method = "A")
#> $rate_of_development
#> [1] 1
#> 
#> $growing_degree_days
#> [1] 15
#> 

# Method B - linear - corn
t_growing_degree_days(T_air_min = 15,
                      T_air_max = 25,
                      T_base = 10,
                      method = "B")
#> $rate_of_development
#> [1] 1
#> 
#> $growing_degree_days
#> [1] 20
#> 

# Method C - triangle
t_growing_degree_days(T_air_avg = 15,
                      T_base = 5,
                      T_opt = 10,
                      T_max = 20,
                      method = "C")
#> $rate_of_development
#> [1] 0.5
#> 
#> $growing_degree_days
#> [1] 7.5
#> 

# Method D - trapezoidal
t_growing_degree_days(T_air_avg = 15,
                      T_base = 5,
                      T_opt_1 = 12,
                      T_opt_2 = 18,
                      T_max = 20,
                      method = "D")
#> $rate_of_development
#> [1] 1
#> 
#> $growing_degree_days
#> [1] 15
#> 
```
