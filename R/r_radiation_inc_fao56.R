#' Calcul du rayonnement incident net
#'
#' @param longitude Longitude de la localisation d'etude (°)
#' @param latitude Latitude de la localisation d'etude (°)
#' @param altitude Altitude de la localisation d'etude (m)
#' @param date date au format "Y-m-d"
#' @param T_air_min temperature minimale du jour (celcius)
#' @param T_air_max temperature maximale du jour (celcius)
#' @param albedo albedo du gazon hypothetique de reference egale a 0.23 Eq. 38
#'   Allan & all. 1998.
#' @param a Parametre correctif facultatif de l'equation Rayonnement net corrige = a . Rayonemment net + b.
#' @param b Parametre correctif facultatif de l'equation Rayonnement net corrige = a . Rayonemment net + b.
#'
#' @return Rayonnement net (MJ/m^2)
#' @export
#'
#' @source Irrigation and drainage paper, Allen & all (1998)
#'
#' @examples
#' r_radiation_inc_fao56(longitude = 10,
#'                       latitude = 35,
#'                       altitude = 30,
#'                       date = "2022-11-04",
#'                       T_air_min = 5,
#'                       T_air_max = 15)
r_radiation_inc_fao56 <- function(longitude,
                                  latitude,
                                  altitude,
                                  date,
                                  T_air_min,
                                  T_air_max,
                                  albedo = 0.23,
                                  a = NA,
                                  b = NA){

  # jour julien
  jour_julien <- as.numeric(format(as.Date(date), "%j"))

  # conversion de la latitude des degres en radians
  latitude <- z_angle_conversion(latitude, 1)

  # calcul de la distance inverse Terre - Soleil Eq. 23 Allan & all. 1998.
  distance_relative_inverse_terre_soleil <- 1 + 0.033 * cos(2*pi*jour_julien/365)

  # calcul de la declinaison solaire i.e. angle entre les rayons du soleil et le plan de l'equateur terrestre [rad] Eq. 24 Allan & all. 1998.
  angle_delta <- 0.409 * sin((2 * pi * jour_julien)/365 - 1.39)

  # calcul de l'angle de coucher du soleil [rad] Eq. 25 Allan & all. 1998.
  angle_omega_s <- acos(-tan(latitude)*tan(angle_delta))

  ## calcul du rayonnement solaire extraterrestre [MJ/m^2/j] Eq. 21 Allan & all. 1998.
  R_a <- (24*60)/pi * weatheR::parameters[["Gsc"]] *
    distance_relative_inverse_terre_soleil *
    (angle_omega_s *
       sin(latitude) *
       sin(angle_delta) +
       cos(latitude) *
       cos(angle_delta) *
       sin(angle_omega_s))


  # calcul du rayonnement solaire [MJ/m^2/j] Eq. 50 Allan & all. 1998.
  R_s <- weatheR::parameters[["k_rs"]] * sqrt(T_air_max - T_air_min) * R_a

  # calcul du rayonnement solaire en ciel clair [MJ/m^2/j] Eq. 37 Allan & all. 1998.
  R_so <- (0.75 + 2.*10^-5 * altitude) * R_a

  ## calcul du rayonnement solaire ondes courtes [MJ/m^2/j] Eq. 38 Allan & all. 1998.
  R_ns <- (1-albedo) * R_s

  ## calcul du rayonnement a ondes longues [MJ/m^2/j] Eq. 39 Allan & all. 1998.
  R_nl <- weatheR::parameters[["sigma_botlzmann"]] * (((T_air_max + 273.16)^4 + (T_air_min + 273.16)^4)/2) * (0.34 - 0.14*sqrt(z_pression_vapeur_saturante(T_air_min))) * ((1.35*R_s/R_so) - 0.35)

  ## calcul du rayonnement net [MJ/m^2/j] Eq. 40 Allan & all. 1998.
  if (
    all(
      is.na(a),
      is.na(b)
    )
  ){
    R_n <- R_ns - R_nl
  } else {
    R_n <- a * (R_ns - R_nl) + b
  }

  return(R_n)
}
