box::use(
  shiny[moduleServer, NS],
  ospsuite,
  dplyr[mutate, select, filter, row_number, case_when],
  magrittr[...],
  stringr[str_detect],
  ggplot2[...],
  lubridate[...]
)

get_plot <- function(simulation_results) {
  message("Generating time profile plot")


  df <- ospsuite::simulationResultsToTibble(simulation_results[[1]]) %>%
    select(Time, paths, simulationValues) %>%
    # Transform Paths to a more readable format
    mutate(paths = case_when(
                                            str_detect(paths, ".*PeripheralVenousBlood.*") ~ "Blood",
                                            str_detect(paths, ".*Brain.*") ~ "Brain",
                                            str_detect(paths, ".*Heart.*") ~ "Heart"
                                          ))

  # Remove data before the first non-zero simulationValue (keep last timepoint where simulationValue is 0)
  start_row <- which(df$simulationValues != 0)[1] - length(unique(df$paths))


  # Subset the data starting from that row
  df <- dplyr::filter(df, row_number() >= start_row) %>%
  # Transform minute number to time of the day
  mutate(Time = lubridate::as_datetime(Time * 60))

  # browser()
  # p <-
    ggplot(df, aes(x = Time, y = simulationValues, color = paths)) +
    geom_line() +
    scale_color_viridis_d() +
    scale_x_datetime(date_labels = "%H:%M", breaks = scales::breaks_width("2 hours"),
                     expand = expansion(c(1/24,0),c(0,0))) +
    scale_y_continuous(expand = expansion(c(0,0), c(0, 0.05))) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1),
          legend.position = "bottom")+
    labs(title = "Caffeine Concentration in Blood, Brain and Heart",
         x = "Time (h)",
         y = "Concentration (mg/L)")

}
