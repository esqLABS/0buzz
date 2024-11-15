box::use(
  shiny[moduleServer, NS],
  ospsuite,
  ggplot2[...],
  scales[breaks_width],
)

get_plot <- function(app_data) {
  message("Generating time profile plot")

    ggplot(app_data$simulation_results, aes(x = Time, y = simulationValues, color = paths)) +
    geom_line() +
    scale_color_viridis_d() +
    scale_x_datetime(date_labels = "%H:%M", breaks = breaks_width("2 hours"),
                     expand = expansion(c(1/24,0),c(0,0))) +
    scale_y_continuous(expand = expansion(c(0,0), c(0, 0.05))) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1),
          legend.position = "bottom")+
    labs(title = "Caffeine Concentration in Blood, Brain and Heart",
         x = "Time (h)",
         y = "Concentration (mg/L)",
         color = "")

}
