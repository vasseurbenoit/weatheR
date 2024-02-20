#' @title t_fahrenheit_celcius
#'
#' @description Conversion of degree Fahrenheit intp degree celcius and
#' vice-versa.
#'
#' @param T_air_celcius Air temperature (°C).
#' @param T_air_fahrenheit Air temperature (°F).
#'
#' @return Converted air temperature.
#' @export
#'
#' @examples
#' # From fahrenheit to celcius
#' t_fahrenheit_celcius(T_air_fahrenheit = 72)
#'
#' # From celcius to fahrenheit
#' t_fahrenheit_celcius(T_air_celcius = 22)
t_fahrenheit_celcius <- function(T_air_celcius = NA,
                                 T_air_fahrenheit = NA){
  T_air <-
    if(all(is.na(T_air_celcius),
           is.na(T_air_fahrenheit))) {

      stop("Temperature is missing")

    } else {

      if(is.na(T_air_celcius)){
        (T_air_fahrenheit - 32) * (5/9)
      } else {
        T_air_celcius * (9/5) + 32
      }

    }

  return(T_air)

}
