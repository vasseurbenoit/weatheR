#' Evapotranspiration de reference
#'
#' @param R_inc rayonnement incident du jour (MJ/m^2/j)
#' @param T_air_moy temperature moyenne du jour (celcius)
#' @param T_air_min temperature minimale du jour (celcius)
#' @param T_air_max temperature maximale du jour (celcius)
#' @param vent vitesse du vent a 2 m (m/s). Valeur par defaut egale a 2 m/s
#'   d'apres p63 Allan & all. 1998.
#' @param pression_vapeur calcul interne a partir de la temperature minimale :
#'   T_point_rosee = T_air_min d'apres Allan & all. 1998.
#' @param altitude Altitude de la localisation d'etude (m)
#' @param a Parametre correctif facultatif de Evapotranspiration corrige = a . Evapotranspiration + b.
#' @param b Parametre correctif facultatif de Evapotranspiration corrige = a . Evapotranspiration + b.
#'
#' @return Evapotranspiration de reference (mm)
#' @export
#'
#' @source Irrigation and drainage paper, Allen & all (1998)
#'
#' @examples
#' # Without correction
#' e_evapotranspiration_fao56(altitude = 30,
#'                            R_inc = 5,
#'                            T_air_moy = 20,
#'                            T_air_min = 10,
#'                            T_air_max = 30)
#'
#' # With correction
#' e_evapotranspiration_fao56(altitude = 30,
#'                            R_inc = 5,
#'                            T_air_moy = 20,
#'                            T_air_min = 10,
#'                            T_air_max = 30,
#'                            a = 1.2,
#'                            b = 2)
e_evapotranspiration_fao56 <- function(altitude,
                                       R_inc,
                                       T_air_moy,
                                       T_air_min,
                                       T_air_max,
                                       vent = 2,
                                       pression_vapeur = z_pression_vapeur_saturante(T_air_min),
                                       a = NA,
                                       b = NA){

  # constante psychometrique [kPa/celcius] Eq. 8 Allan & all. 1998.
  constante_psychometrique <- 0.665*10^-3*z_pression_atm(altitude)

  # Pente de la courbe de saturation de pression de vapeur a la temperature de l'air [kPA/celcius] Eq. 13 Allan & all. 1998.
  delta <- (4098*z_pression_vapeur_saturante(T_air_moy))/((T_air_moy + 237.3)^2)

  # deficit pression de vapeur
  ## calcul pression de vapeur saturante moyenne du jour
  es <- (z_pression_vapeur_saturante(T_air_min) + z_pression_vapeur_saturante(T_air_max))/2
  ## calcul de la pression de vapeur du jour
  #Utilisation de T_dew = T_air_min (hypothese) Eq. 48 Allan & all. 1998.
  ea <- pression_vapeur

  ## calcul du deficit de pression de vapeur
  deficit_p_vapeur <- es-ea

  # evapotranspiration de reference FAO Penman-Monteith Eq. 6 Allan & all. 1998.
  numerateur <- 0.408 *
    delta *
    R_inc +
    constante_psychometrique *
    (900/(T_air_moy + 273)) *
    vent *
    deficit_p_vapeur

  denominateur <- delta +
    constante_psychometrique *
    (1 + 0.34 * vent)

  if (
    all(
      is.na(a),
      is.na(b)
    )
  ){
    ET_0 <- numerateur/ denominateur
  } else {
    ET_0 <- a * numerateur/ denominateur + b
  }


  return(ET_0)
}
