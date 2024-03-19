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
#' @importFrom dplyr mutate summarise across group_by filter rename
#' @importFrom forcats fct_relevel
#' @importFrom tidyr pivot_longer
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
                          digits = 1))) %>%
    rename("Average air\ntemperature (°C)" = "T_air_avg",
           "Minimum air\ntemperature (°C)" = "T_air_min",
           "Maximum air\ntemperature (°C)" = "T_air_max",
           "Number of\nfreezing day" = "freezing_day") %>%
    pivot_longer(cols = c("Average air\ntemperature (°C)",
                          "Minimum air\ntemperature (°C)",
                          "Maximum air\ntemperature (°C)",
                          "Number of\nfreezing day"),
                 names_to = "variable",
                 values_to = "value")


  # Ploting ----
  diagram <-
    ggplot(
      data = table %>%
        mutate(month = fct_relevel(month,
                                   c("Oct",
                                     "Nov",
                                     "Dec",
                                     "Jan",
                                     "Feb",
                                     "Mar",
                                     "Apr",
                                     "May",
                                     "Jun",
                                     "Jul",
                                     "Aug",
                                     "Sep")),
               variable = fct_relevel(variable,
                                      c("Maximum air\ntemperature (°C)",
                                        "Average air\ntemperature (°C)",
                                        "Minimum air\ntemperature (°C)",
                                        "Number of\nfreezing day")))
    ) +
    geom_col(aes(x = month, y = rain), fill = "lightblue") +
    geom_point(aes(x = month,
                   y = value *
                     parameters[["y_scale_ombrothermic_diagram"]],
                   color = variable),
               size = 3) +
    geom_line(aes(x = month,
                   y = value *
                    parameters[["y_scale_ombrothermic_diagram"]],
                   group = variable,
                  color = variable)) +
    labs(x = "Month",
         y = "Monthly average precipitation (mm)") +
    scale_y_continuous(
      limits = c(
        ifelse(min(table$value) < 0,
               (min(table$value) - 5),
               (min(table$value) + 5)),
        (max(table$rain) + 10)),
      sec.axis = sec_axis(trans = ~.*(1/parameters[["y_scale_ombrothermic_diagram"]]),
                          name = "Monthly average air temperature (°C)")) +
    scale_color_manual(values = c("red", "black", "blue", "darkgrey")) +
    labs(color = "") +
    theme_bw() +
    theme(legend.position = "bottom") +
    labs(caption = glue::glue({{source}},
                              ". Average from ",
                              {{year_start}},
                              " to ",
                              {{year_end}}
    ))


  # Output ----
  output <- list(table,
                 diagram)
  names(output) <- c("table",
                     "diagram")
  return(output)

}
