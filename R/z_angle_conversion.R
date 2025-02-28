#' Conversion des angles en degres en radians et vice versa
#'
#' @param angle valeur de l'angle
#' @param mode 1 : conversion des degres en radians 2 : conversion des radians en degres
#'
#' @return valeur convertie de l'angle
#' @export
#'
#' @examples
#' z_angle_conversion(pi, 2)
#' z_angle_conversion(180, 1)
z_angle_conversion <- function(angle, mode){
  if (mode == 1){
    pi * angle /180
  }else{
    180 * angle /pi
  }
}
