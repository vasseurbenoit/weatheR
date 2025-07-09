#' c_ombrothermic_diagram
#'
#' @description Plot ombrothermic diagram for a set of weather data.
#' @description On the y scale, one temperature unit equals two rain unit. To
#' be correct, 30 years must be selected for the statistical analysis.
#'
#' @param data Dataframe with the columns `date`, `rain`, `T_air_max` and
#' `T_air_min` respectively the date of the day, the rain (mm) and the maximum
#' and minimum temperature (`r stringi::stri_c("\u00b0")`C).
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
#' @importFrom stringi stri_c
#' @importFrom stringr str_replace_all
#' @export
#'
#' @examples
#' output <- c_ombrothermic_diagram(data = weather_blue_grass_airport,
#'                                  year_start = 1991,
#'                                  year_end = 2020,
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
    pivot_longer(cols = c("T_air_avg",
                          "T_air_min",
                          "T_air_max",
                          "freezing_day"),
                 names_to = "variable",
                 values_to = "value") %>%
    mutate(
      variable = str_replace_all(
        string = variable,
        pattern = "T_air_avg",
        replacement = stri_c("Average air\ntemperature (\u00b0C)")
      ),
      variable = str_replace_all(
        string = variable,
        pattern = "T_air_min",
        replacement = stri_c("Minimum air\ntemperature (\u00b0C)")
      ),
      variable = str_replace_all(
        string = variable,
        pattern = "T_air_max",
        replacement = stri_c("Maximum air\ntemperature (\u00b0C)")
      ),
      variable = str_replace_all(
        string = variable,
        pattern = "freezing_day",
        replacement = "Number of\nfreezing day"
      )
    )

  # Ploting ----
  diagram <-
    ggplot(
      data = table %>%
        mutate(month = factor(month,
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
               variable = factor(variable,
                                 c(stri_c("Maximum air\ntemperature (\u00b0C)"),
                                   stri_c("Average air\ntemperature (\u00b0C)"),
                                   stri_c("Minimum air\ntemperature (\u00b0C)"),
                                   "Number of\nfreezing day")))
    ) +
    geom_col(aes(x = month, y = rain), fill = "lightblue") +
    geom_point(aes(x = month,
                   y = value *
                     weatheR::parameters[["y_scale_ombrothermic_diagram"]],
                   color = variable),
               size = 3) +
    geom_line(aes(x = month,
                  y = value *
                    weatheR::parameters[["y_scale_ombrothermic_diagram"]],
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
                          name = stri_c("Monthly average air temperature (\u00b0C)"))
    ) +
    scale_color_manual(values = c("red", "black", "blue", "darkgrey")) +
    labs(color = "") +
    theme_bw() +
    theme(text = element_text(size = 14),
          axis.title =  element_text(face = "bold"),
          legend.title = element_text(face = "bold"),
          legend.position = "right",
          legend.box = "vertical") +
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
