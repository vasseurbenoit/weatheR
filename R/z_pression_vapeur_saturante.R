#' Calcul de la pression de vapeur saturante pour une temperature donnee
#'
#' @param temperature temperature de l'air (degre celcius)
#'
#' @return pression de vapeur saturante (kPa)
#' @export
#'
#' @examples
#' z_pression_vapeur_saturante(20)
z_pression_vapeur_saturante <- function(temperature){
  0.6108*exp(17.27*temperature/(temperature+237.3))
}
