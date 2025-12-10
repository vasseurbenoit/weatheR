# Calcul du rayonnement incident net

Calcul du rayonnement incident net

## Usage

``` r
r_radiation_inc_fao56(
  longitude,
  latitude,
  altitude,
  date,
  T_air_min,
  T_air_max,
  albedo = 0.23,
  a = NA,
  b = NA
)
```

## Source

Irrigation and drainage paper, Allen & all (1998)

## Arguments

- longitude:

  Longitude de la localisation d'etude (°)

- latitude:

  Latitude de la localisation d'etude (°)

- altitude:

  Altitude de la localisation d'etude (m)

- date:

  date au format "Y-m-d"

- T_air_min:

  temperature minimale du jour (celcius)

- T_air_max:

  temperature maximale du jour (celcius)

- albedo:

  albedo du gazon hypothetique de reference egale a 0.23 Eq. 38 Allan &
  all. 1998.

- a:

  Parametre correctif facultatif de l'equation Rayonnement net corrige =
  a . Rayonemment net + b.

- b:

  Parametre correctif facultatif de l'equation Rayonnement net corrige =
  a . Rayonemment net + b.

## Value

Rayonnement net (MJ/m^2)

## Examples

``` r
# Without correction
r_radiation_inc_fao56(longitude = 10,
                      latitude = 35,
                      altitude = 30,
                      date = "2022-11-04",
                      T_air_min = 5,
                      T_air_max = 15)
#> [1] 4.494582

# With correction
r_radiation_inc_fao56(longitude = 10,
                      latitude = 35,
                      altitude = 30,
                      date = "2022-11-04",
                      T_air_min = 5,
                      T_air_max = 15,
                      a = 1.2,
                      b = 2)
#> [1] 7.393499
```
