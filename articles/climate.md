# Climate

## Ombrothermic diagram

    #> $table
    #> # A tibble: 48 × 4
    #>    month  rain variable                        value
    #>    <chr> <dbl> <chr>                           <dbl>
    #>  1 Apr   112.  "Average air\ntemperature (°C)"  13.4
    #>  2 Apr   112.  "Minimum air\ntemperature (°C)"   7.4
    #>  3 Apr   112.  "Maximum air\ntemperature (°C)"  22.6
    #>  4 Apr   112.  "Number of\nfreezing day"         0  
    #>  5 Aug    94.2 "Average air\ntemperature (°C)"  24.2
    #>  6 Aug    94.2 "Minimum air\ntemperature (°C)"  18.5
    #>  7 Aug    94.2 "Maximum air\ntemperature (°C)"  33.3
    #>  8 Aug    94.2 "Number of\nfreezing day"         0  
    #>  9 Dec   108.  "Average air\ntemperature (°C)"   3.1
    #> 10 Dec   108.  "Minimum air\ntemperature (°C)"  -1.3
    #> # ℹ 38 more rows
    #> 
    #> $diagram

![](climate_files/figure-html/unnamed-chunk-1-1.png)

## Weather anomaly

    #> $data_thirthy_years_avg
    #> # A tibble: 1 × 2
    #>    rain T_air_avg
    #>   <dbl>     <dbl>
    #> 1  648.       8.1
    #> 
    #> $data_selected_years
    #> # A tibble: 4 × 5
    #>   year   rain T_air_avg ratio_precipitation_historical_…¹ difference_temperatu…²
    #>   <chr> <dbl>     <dbl>                             <dbl>                  <dbl>
    #> 1 2020   658.      8.87                             101.                  0.771 
    #> 2 2021   741.      8.59                             114.                  0.486 
    #> 3 2022   635       8.19                              97.9                 0.0928
    #> 4 2023   530.     11.1                               81.7                 2.96  
    #> # ℹ abbreviated names: ¹​ratio_precipitation_historical_mean_percentage,
    #> #   ²​difference_temperature_historical_mean
    #> 
    #> $plot_selected_years

![](climate_files/figure-html/unnamed-chunk-2-1.png)

## References
