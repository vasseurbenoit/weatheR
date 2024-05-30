#' w_daily_thermal_unit
#'
#' @description Calculation of the daily thermal unit.
#' Two methods are available.
#'    - Method 1: use of T_min, T_max and T_base. Method widely used for
#'    the calculation of the daily thermal unit of small grain cereals.
#'    - Method 1: use of T_min, T_max and T_base. Method widely used for
#'    the calculation of the daily thermal unit of corn.
#'    - Method 2: use of T_min, T_max, T_base, T_opt and T_max
#'
#' @param T_air_min Minimum air temperature (°C)
#' @param T_air_max Maximum air temperature (°C)
#' @param T_base Base air temperature of a crop (°C)
#' @param T_opt Optimum air temperature of a crop (°C)
#' @param T_max Maximum air temperature of a crop (°C)
#' @param method Selection of method 1 or 2. NOT the third one.
#'
#' @return Daily thermal unit (°Cj)
#' @export
#'
#' @examples
#' # Method 1
#' t_daily_thermal_unit(T_air_min = 5,
#'                      T_air_max = 8,
#'                      T_base = 10,
#'                      method = 1)
#'
#' # Method 2
#' t_daily_thermal_unit(T_air_min = 5,
#'                      T_air_max = 8,
#'                      T_base = 10,
#'                      method = 2)
#'
#' # Method 3
#' t_daily_thermal_unit(T_air_min = 5,
#'                      T_air_max = 8,
#'                      T_base = 10,
#'                      T_opt = 10,
#'                      T_max = 20)
t_daily_thermal_unit <- function(T_air_min,
                                 T_air_max,
                                 T_base,
                                 T_opt = NA,
                                 T_max = NA,
                                 method = 1) {

  daily_thermal_unit <-

    if(method == 1){

    ## Method 1
    if((T_air_min + T_air_max)/ 2 < T_base) {
      T_base
    } else {
      (T_air_min + T_air_max)/ 2 - T_base
    }

  } else if (method == 2){

    ## Method 2
    T_air_max <- if(T_air_max < T_base){
      T_base
    }
    T_air_min <- if(T_air_min < T_base){
      T_base
    }

    (T_air_max + T_air_min)/2 - T_base

  } else {

    ## Method 3
    T_air_avg <- (T_air_min + T_air_max)/ 2

    if(T_air_avg <= T_base | T_air_avg >= T_max){
      0
    } else if(T_air_avg <= T_opt) {
      (T_air_avg - T_base)/ (T_opt - T_base)
    } else {
      1 - (T_air_avg - T_opt)/ (T_max - T_opt)
    }

  }

  return(daily_thermal_unit)

}
