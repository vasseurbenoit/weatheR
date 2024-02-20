#' c_ombrothermic_diagram
#'
#' @description Plot a ombrothermic diagram for a set of weather data.
#' @description On the y scale, one temperature unit equals two rain unit. To
#' be correct, 30 years must be selected for the statistical analysis.
#'
#' @param data Dataframe with the columns `date`, `rain`, `T_air_max` and
#' `T_air_min` respectively the date of the day, the rain (mm) and the maximum
#' and minimum temperature (°C).
#' @param year_start Start year to begin the statical analysis.
#' @param year_end End year to finish the statical analysis.
#' @param source Source of the data.
#'
#' @return List with `table` and `diagram`. The table is used to build the
#' ombrothermic plot.
#'
#' @import ggplot2
#' @import lubridate
#' @importFrom dplyr mutate summarise across group_by filter
#' @export
#'
#' @examples
#' output <- c_ombrothermic_diagram(data = weather_blue_grass_airport,
#'                                  year_start = 1990,
#'                                  year_end = 2019,
#'                                  source = "Blue Grass Airport (Lexington)")
c_ombrothermic_diagram <- function(data,
                                   year_start,
                                   year_end,
                                   source){

  # Processing ----
  table <-
    data %>%
    mutate(year = year(date),
           month = month(date,
                         label = TRUE,
                         abbr = TRUE),
           day = day(date),
           T_air_avg = (T_air_max + T_air_min)/2,
           freezing_day = ifelse(T_air_max < 0,
                                 1,
                                 0)) %>%
    filter(year >= {{year_start}},
           year < {{year_end}}) %>%
    group_by(year,
             month) %>%
    summarise(rain = sum(rain),
              T_air_min = mean(T_air_min),
              T_air_max = mean(T_air_max),
              T_air_avg = mean(T_air_avg),
              freezing_day = sum(freezing_day)) %>%
    group_by(month) %>%
    summarise(rain = mean(rain),
              T_air_min = mean(T_air_min),
              T_air_max = max(T_air_max),
              T_air_avg = mean(T_air_avg),
              freezing_day = mean(freezing_day)) %>%
    mutate(across(c("rain",
                    "T_air_min",
                    "T_air_max",
                    "T_air_avg",
                    "freezing_day"),
                  ~ round(x = .,
                          digits = 1)))


  # Ploting ----
  diagram <-
    ggplot(data = table) +
    geom_col(aes(x = month, y = rain), fill = "lightblue") +
    geom_point(aes(x = month,
                   y = T_air_max * parameters[["y_scale_ombrothermic_diagram"]]),
               color = "darkred",
               size = 3) +
    geom_line(aes(x = month,
                  y = T_air_max * parameters[["y_scale_ombrothermic_diagram"]],
                  group = 1),
              color = "darkred",
              size = 0.5) +
    geom_point(aes(x = month,
                   y = T_air_min * parameters[["y_scale_ombrothermic_diagram"]]),
               color = "darkgreen",
               size = 3) +
    geom_line(aes(x = month,
                  y = T_air_min * parameters[["y_scale_ombrothermic_diagram"]],
                  group = 1),
              color = "darkgreen",
              size = 0.5) +
    geom_point(aes(x = month,
                   y = T_air_avg * parameters[["y_scale_ombrothermic_diagram"]]),
               color = "darkblue",
               size = 3) +
    geom_line(aes(x = month,
                  y = T_air_avg * parameters[["y_scale_ombrothermic_diagram"]],
                  group = 1),
              color =  "darkblue",
              size = 0.5) +
    geom_point(aes(x = month,
                   y = freezing_day * parameters[["y_scale_ombrothermic_diagram"]]),
               color = "snow",
               size = 3) +
    geom_line(aes(x = month,
                  y = freezing_day * parameters[["y_scale_ombrothermic_diagram"]],
                  group = 1),
              color = "snow",
              size = 0.5) +
    labs(x = "Month",
         y = "Rain (mm)") +
    scale_y_continuous(
      limits = c(
        -(min(table$T_air_min) + 5),
        (max(table$rain) + 50)),
      sec.axis = sec_axis(trans = ~.*(1/parameters[["y_scale_ombrothermic_diagram"]]),
                          name = "AVerage air temperature (°C)")) +
    theme_bw() +
    labs(caption = {{source}})


  # Output ----
  output <- list(table,
                 diagram)
  names(output) <- c("table",
                     "diagram")
  return(output)

}
