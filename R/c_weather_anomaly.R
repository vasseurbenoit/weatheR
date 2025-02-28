#' c_weather_anomaly
#'
#' @description To be correct, 30 years must be selected for the statistical
#' analysis.
#'
#' @param data Dataframe with the columns `date`, `rain`, `T_air_max` and
#' `T_air_min` respectively the date of the day, the rain (mm) and the maximum
#' and minimum temperature (°C).
#' @param year_start Starting year to begin the statical analysis.
#' @param year_end End year to finish the statical analysis.
#' @param months Vector with the month to take into account.
#' @param day_start Start day to begin the statical analysis.
#' @param day_end End day to finish the statical analysis.
#' @param years A vector with a selection of years with potential anomaly.
#' Selected years must be out of the range of years selected between `year_start`
#' and `year_end`.
#' @param source Source of the data.
#' @param plot_type 1 rain in ratio to mean, 2 rain in absolute value
#'
#' @return List with `data_thirthy_years_avg`, `data_selected_years` and
#' `plot_selected_years`, the df with the thirthy years average temperature and
#' rainfall, the df with the average temperature and rainfall of the selected
#' years and the plot of the selected years.
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
                              source,
                              plot_type = 1){

  # Processing ----
  data_thirthy_years_avg <-
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
  if(plot_type == 1){

    ## Data
    data_selected_years <-
      data %>%
      filter(year %in% {{years}},
             month %in% {{months}},
             day >= {{day_start}},
             day < {{day_end}}) %>%
      group_by(year) %>%
      summarise(rain = sum(rain),
                T_air_avg = mean(T_air_avg)) %>%
      mutate(year = as.character(year),
             ratio_precipitation_historical_mean_percentage =
               rain/ data_thirthy_years_avg$rain * 100,
             difference_temperature_historical_mean =
               T_air_avg - data_thirthy_years_avg$T_air_avg)

    ## Plot
    plot_selected_years <-
      ggplot(data = data_selected_years,
             aes(x = ratio_precipitation_historical_mean_percentage,
                 y = difference_temperature_historical_mean)) +
      geom_point(aes(color = year)) +
      geom_vline(aes(xintercept = 100)) +
      geom_hline(aes(yintercept = 0)) +
      theme_bw() +
      theme(text = element_text(size = 14),
            axis.title =  element_text(face = "bold"),
            legend.title = element_text(face = "bold"),
            legend.position = "right",
            legend.box = "vertical") +
      xlab("Ratio of the precipitation to the historical mean (%)") +
      ylab("Temperature difference from the historical mean (°C)") +
      labs(color = "Year") +
      labs(caption = glue::glue({{source}},
                                ". ",
                                "Historical mean are calculated from ",
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

  } else {

    ## Data
    data_selected_years <-
      data %>%
      filter(year %in% {{years}},
             month %in% {{months}},
             day >= {{day_start}},
             day < {{day_end}}) %>%
      group_by(year) %>%
      summarise(rain = sum(rain),
                T_air_avg = mean(T_air_avg)) %>%
      mutate(year = as.character(year),
             difference_precipitation_historical_mean =
               rain - data_thirthy_years_avg$rain,
             difference_temperature_historical_mean =
               T_air_avg - data_thirthy_years_avg$T_air_avg)

    ## Plot
    plot_selected_years <-
      ggplot(data = data_selected_years,
             aes(x = difference_precipitation_historical_mean,
                 y = difference_temperature_historical_mean)) +
      geom_point(aes(color = year)) +
      geom_vline(aes(xintercept = 0)) +
      geom_hline(aes(yintercept = 0)) +
      theme_bw() +
      xlab("Precipitation difference from the historical mean (mm)") +
      ylab("Temperature difference from the historical mean (°C)") +
      labs(color = "Year") +
      labs(caption = glue::glue({{source}},
                                ". ",
                                "Historical mean are calculated from ",
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

  }


  # Output ----
  output <- list(data_thirthy_years_avg,
                 data_selected_years,
                 plot_selected_years)
  names(output) <- c("data_thirthy_years_avg",
                     "data_selected_years",
                     "plot_selected_years")
  return(output)

}
