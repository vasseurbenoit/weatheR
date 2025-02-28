#' Calcul de la pression atmospherique en fonction de l'altitude de la station
#'
#' @param altitude elevatation au dessus du niveau de la mer (m)
#'
#' @return pression atmospherique (kPa)
#' @export
#'
#' @examples
#' z_pression_atm(0)
#' z_pression_atm(5000)
z_pression_atm <- function(altitude){
  101.3*((293-0.0065*altitude)/293)^5.26
}
