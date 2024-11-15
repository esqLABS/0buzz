box::use(
  shiny[moduleServer, NS],
  ospsuite,
  ggplot2[...],
  scales[breaks_width],
  gghighlight,
  stringr[str_detect, regex, str_to_title],
  lubridate[as_datetime, hm],
  purrr[map, list_rbind]
)

box::use(
  app / logic / intakes[convert_time_to_min],
)

get_plot <- function(app_data) {
  message("Generating time profile plot")

  intakes_df <-
    map(app_data$intake_data, \(x){
      data.frame(
        name = names(x$type),
        time = as_datetime(hm(x$time))
      )
    }) |>
    list_rbind()

  # p <-
    ggplot() +
    geom_line(
      data = app_data$simulation_results,
      aes(x = Time, y = simulationValues, color = paths),
      linewidth = 1.5
    ) +
    gghighlight::gghighlight(stringr::str_detect(string = paths, stringr::regex(app_data$active_tab, ignore_case = T)),
      use_group_by = FALSE,
      use_direct_label = FALSE,
      unhighlighted_params = list(colour = NULL, alpha = 0.2)
    ) +
    # geom_point_interactive(
    #   data = intakes_df,
    #   aes(x = time, tooltip = paste0(format(time, "%H:%M"), ": ", name)),
    #   y = Inf,
    #   size = 2,
    #   hover_nearest = TRUE
    # ) +
    scale_color_viridis_d() +
    scale_x_datetime(
      date_labels = "%H:%M", breaks = breaks_width("2 hours"),
      expand = expansion(c(1 / 24, 0), c(0, 0))
    ) +
    scale_y_continuous(expand = expansion(c(0, 0), c(0, 0.05))) +
    theme_minimal() +
    theme(
      axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1),
      legend.position = "bottom"
    ) +
    coord_cartesian(clip = "off") +
    labs(
      title = paste("Caffeine Concentration in", str_to_title(app_data$active_tab)),
      x = "Time (h)",
      y = "Concentration (µmol/L)",
      color = ""
    )

  # girafe(
  #   ggobj = p,
  #   options = list(
  #     opts_toolbar(
  #       saveaspng = FALSE,
  #       hidden = c("selection", "zoom", "misc")
  #     ),
  #     opts_sizing(rescale = TRUE, width = 1),
  #     opts_hover_inv(css = "opacity:0.1;"),
  #     opts_hover(css = "stroke-width:2;")
  #   )
  # )
}
