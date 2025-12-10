# Evapotranspiration de reference

Evapotranspiration de reference

## Usage

``` r
e_evapotranspiration_fao56(
  altitude,
  R_inc,
  T_air_moy,
  T_air_min,
  T_air_max,
  vent = 2,
  pression_vapeur = z_pression_vapeur_saturante(T_air_min),
  a = NA,
  b = NA
)
```

## Source

Irrigation and drainage paper, Allen & all (1998)

## Arguments

- altitude:

  Altitude de la localisation d'etude (m)

- R_inc:

  rayonnement incident du jour (MJ/m^2/j)

- T_air_moy:

  temperature moyenne du jour (celcius)

- T_air_min:

  temperature minimale du jour (celcius)

- T_air_max:

  temperature maximale du jour (celcius)

- vent:

  vitesse du vent a 2 m (m/s). Valeur par defaut egale a 2 m/s d'apres
  p63 Allan & all. 1998.

- pression_vapeur:

  calcul interne a partir de la temperature minimale : T_point_rosee =
  T_air_min d'apres Allan & all. 1998.

- a:

  Parametre correctif facultatif de Evapotranspiration corrige = a .
  Evapotranspiration + b.

- b:

  Parametre correctif facultatif de Evapotranspiration corrige = a .
  Evapotranspiration + b.

## Value

Evapotranspiration de reference (mm)

## Examples

``` r
# Without correction
e_evapotranspiration_fao56(altitude = 30,
                           R_inc = 5,
                           T_air_moy = 20,
                           T_air_min = 10,
                           T_air_max = 30)
#> [1] 3.56085

# With correction
e_evapotranspiration_fao56(altitude = 30,
                           R_inc = 5,
                           T_air_moy = 20,
                           T_air_min = 10,
                           T_air_max = 30,
                           a = 1.2,
                           b = 2)
#> [1] 6.27302
```
