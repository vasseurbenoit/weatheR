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
#' @param month_start Start month to begin the statical analysis.
#' @param month_end End month to finish the statical analysis.
#' @param day_start Start day to begin the statical analysis.
#' @param day_end End day to finish the statical analysis.
#' @param years A vector with a selection of years with potential anomaly.
#' Selected years must be out of the range of years selected between `year_start`
#' and `year_end`.
#' @param source Source of the data.
#' @param plot_type 1 rain in ratio to mean, 2 rain in absolute value
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
#'                             month_start = 5,
#'                             month_end = 9,
#'                             day_start = 1,
#'                             day_end = 31,
#'                             years = c(2020,2021,2022,2023),
#'                             source = "Blue Grass Airport (Lexington)")
c_weather_anomaly <- function(data,
                              year_start,
                              year_end,
                              month_start,
                              month_end,
                              day_start,
                              day_end,
                              years,
                              source,
                              plot_type = 1){

  # Processing ----
  table <-
    data %>%
    mutate(year = year(date),
           month = month(date),
           day = day(date),
           T_air_avg = (T_air_max + T_air_min)/2) %>%
    filter(year >= {{year_start}},
           year < {{year_end}},
           month >= {{month_start}},
           month < {{month_end}},
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
    if(plot_type == 1){

      ggplot(data = data %>%
               filter(year %in% {{years}},
                      month >= {{month_start}},
                      month < {{month_end}},
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
        xlab("Ratio to the historical mean of precipitation (%)") +
        ylab("Temperature difference from the historical mean (°C)") +
        labs(caption = glue::glue({{source}},
                                  ". ",
                                  "Historical mean are calculated from ",
                                  {{month_start}},
                                  "/",
                                  {{day_start}},
                                  "/",
                                  {{year_start}},
                                  "/",
                                  " to ",
                                  {{month_end}},
                                  "/",
                                  {{day_end}},
                                  "/",
                                  {{year_end}}
        ))

    } else {

      ggplot(data = data %>%
               filter(year %in% {{years}},
                      month >= {{month_start}},
                      month < {{month_end}},
                      day >= {{day_start}},
                      day < {{day_end}}) %>%
               group_by(year) %>%
               summarise(rain = sum(rain),
                         T_air_avg = mean(T_air_avg)) %>%
               mutate(year = as.character(year)),
             aes(x = rain - table$rain,
                 y = T_air_avg - table$T_air_avg)) +
        geom_point(aes(color = year)) +
        geom_vline(aes(xintercept = 100)) +
        geom_hline(aes(yintercept = 0)) +
        theme_bw() +
        xlab("Precipitation difference from the historical mean (mm)") +
        ylab("Temperature difference from the historical mean (°C)") +
        labs(caption = glue::glue({{source}},
                                  ". ",
                                  "Historical mean are calculated from ",
                                  {{month_start}},
                                  "/",
                                  {{day_start}},
                                  "/",
                                  {{year_start}},
                                  "/",
                                  " to ",
                                  {{month_end}},
                                  "/",
                                  {{day_end}},
                                  "/",
                                  {{year_end}}
        ))

    }


  # Output ----
  output <- list(table,
                 plot)
  names(output) <- c("table",
                     "plot")
  return(output)

}
