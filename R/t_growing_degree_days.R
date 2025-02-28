#' Growing degree days calculation
#'
#' @description Calculation of the daily thermal unit.
#' Two methods are available.
#'    - Method A - linear - small grains: use of T_air_avg and T_base.
#'    Method widely used for the calculation of the daily thermal unit of small
#'    grain cereals and in simulation models.
#'    - Method B - linear: use of T_air_min, T_air_max and T_base. Method
#'    widely used for the calculation of the daily thermal unit of corn.
#'    - Method C - triangle: use of T_air_avg, T_base, T_opt and T_max.
#'    - Method D - trapezoid: use of T_air_avg, T_base, T_opt_1, T_opt_2 and
#'    T_max.
#'
#' @param T_air_avg Average air temperature (°C). Required for methods A, C, D.
#' @param T_air_min Minimum air temperature (°C). Required for method B only.
#' @param T_air_max Maximum air temperature (°C). Required for method B only.
#' @param T_base Base air temperature of a crop (°C)
#' @param T_opt Optimum air temperature of a crop (°C)
#' @param T_opt_1 First optimum temperature of a crop (°C)
#' @param T_opt_2 Second optimum temperature of a crop (°C)
#' @param T_max Maximum air temperature of a crop (°C)
#' @param method Selection of the calculation method:
#'  - Method A: Linear - small grains
#'  - Method B: Linear - corn
#'  - Method C: Triangle
#'  - Method D: Trapezoidal
#'
#' @return Daily thermal unit (°Cj)
#' @export
#'
#' @examples
#' # Method A - linear - small grains
#' t_growing_degree_days(T_air_avg = 15,
#'                       T_base = 5,
#'                       method = "A")
#'
#' # Method B - linear - corn
#' t_growing_degree_days(T_air_min = 15,
#'                       T_air_max = 25,
#'                       T_base = 10,
#'                       method = "B")
#'
#' # Method C - triangle
#' t_growing_degree_days(T_air_avg = 15,
#'                       T_base = 5,
#'                       T_opt = 10,
#'                       T_max = 20,
#'                       method = "C")
#'
#' # Method D - trapezoidal
#' t_growing_degree_days(T_air_avg = 15,
#'                       T_base = 5,
#'                       T_opt_1 = 12,
#'                       T_opt_2 = 18,
#'                       T_max = 20,
#'                       method = "D")
t_growing_degree_days <- function(T_air_avg,
                                  T_air_min = NA,
                                  T_air_max = NA,
                                  T_base,
                                  T_opt = NA,
                                  T_opt_1 = NA,
                                  T_opt_2 = NA,
                                  T_max = NA,
                                  method = "A") {

  if(method == "A"){ # Linear - small grains

    rate_of_development <- ifelse(T_air_avg < T_base,
                                  0,
                                  1)
    growing_degree_days <- rate_of_development * T_air_avg

  } else {

    if(method == "B"){ # Linear - corn

      T_air_max <- ifelse(T_air_max < T_base,
                      T_base,
                      T_air_max)

      T_air_min <- ifelse(T_air_min < T_base,
                      T_base,
                      T_air_min)

      T_air_avg <- (T_air_min + T_air_max)/ 2

      rate_of_development <- ifelse(T_air_avg < T_base,
                                    0,
                                    1)

      growing_degree_days <- rate_of_development * T_air_avg

    } else {

      if(method == "C"){ # Triangle

        rate_of_development <-
          ifelse(
            T_air_avg <= T_base | T_air_avg >= T_max,
            0,
            ifelse(T_air_avg <= T_opt,
                   (T_air_avg - T_base)/ (T_opt - T_base),
                   1 - (T_air_avg - T_opt)/ (T_max - T_opt)
            )
          )

        growing_degree_days <- rate_of_development * T_air_avg


      } else {

        if(method == "D"){ # Trapezoidal


          rate_of_development <-
            ifelse(
              T_air_avg <= T_base | T_air_avg >= T_max,
              0,
              ifelse(
                T_air_avg <= T_opt_1,
                (T_air_avg - T_base)/ (T_opt_1 - T_base),
                ifelse(T_air_avg >= T_opt_2,
                       1 - (T_air_avg - T_opt_2)/ (T_max - T_opt_2),
                       1)
              )
            )

          growing_degree_days <- rate_of_development * T_air_avg


        } else {

          message("Incorrect daily thermal unit method sepcified.")

        }

      }

    }

  }


  output <- list(rate_of_development,
                 growing_degree_days)
  names(output) <- c("rate_of_development",
                     "growing_degree_days")
  return(output)

}
