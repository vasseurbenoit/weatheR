#' c_weather_anomaly
#'
#' @description To be correct, 30 years must be selected for the statistical
#' analysis.
#'
#' @param data Dataframe with the columns `date`, `rain`, `T_air_max` and
#' `T_air_min` respectively the date of the day, the rain (mm) and the maximum
#' and minimum temperature (°C).
#' @param year_start Start year to begin the statical analysis.
#' @param year_end End year to finish the statical analysis.
#' @param months Vector with the month to take into account.
#' @param day_start Start day to begin the statical analysis.
#' @param day_end End day to finish the statical analysis.
#' @param years A vector with a selection of years with potential anomaly.
#' Selected years must be out of the range of years selected between `year_start`
#' and `year_end`.
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
#' output <- c_weather_anomaly(data = weather_blue_grass_airport,
#'                             year_start = 1990,
#'                             year_end = 2019,
#'                             months = c(9,10,11,12,1,2,3),
#'                             day_start = 1,
#'                             day_end = 31,
#'                             years = c(2020,2021,2022,2023),
#'                             source = "Blue Grass Airport (Lexington)")
c_weather_anomaly <- function(data,
                              year_start,
                              year_end,
                              months,
                              day_start,
                              day_end,
                              years,
                              source){

  # Processing ----
  table <-
    data %>%
    mutate(year = year(date),
           month = month(date),
           day = day(date),
           T_air_avg = (T_air_max + T_air_min)/2) %>%
    filter(year >= {{year_start}},
           year < {{year_end}},
           month %in% {{months}},
           day >= {{day_start}},
           day < {{day_end}}) %>%
    group_by(year) %>%
    summarise(rain = sum(rain),
              T_air_avg = mean(T_air_avg)) %>%
    mutate(across(c("rain",
                    "T_air_avg"),
                  ~ round(x = .,
                          digits = 1))) %>%
    summarise(rain = mean(rain),
              T_air_avg = mean(T_air_avg)) %>%
    mutate(across(c("rain",
                    "T_air_avg"),
                  ~ round(x = .,
                          digits = 1)))


  # Ploting ----
  plot <-
    ggplot(data = data %>%
             filter(year %in% {{years}},
                    month %in% {{months}},
                    day >= {{day_start}},
                    day < {{day_end}}) %>%
             group_by(year) %>%
             summarise(rain = sum(rain),
                       T_air_avg = mean(T_air_avg)) %>%
             mutate(year = as.character(year)),
           aes(x = (rain/ table$rain) * 100,
               y = T_air_avg - table$T_air_avg)) +
    geom_point(aes(color = year)) +
    geom_vline(aes(xintercept = 100)) +
    geom_hline(aes(yintercept = 0)) +
    theme_bw() +
    xlab("Rain: ratio to the mean (%)") +
    ylab("Mean temperature: difference with the mean (°C)") +
    labs(color = "Year") +
    labs(caption = glue::glue({{source}},
                              ". ",
                              "Mean are calculated from ",
                              {{months[1]}},
                              "/",
                              {{day_start}},
                              "/",
                              {{year_start}},
                              "/",
                              " to ",
                              {{months[length(months)]}},
                              "/",
                              {{day_end}},
                              "/",
                              {{year_end}}
                              ))


  # Output ----
  output <- list(table,
                 plot)
  names(output) <- c("table",
                     "plot")
  return(output)

}
