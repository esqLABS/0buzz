box::use(
  ospsuite,
  rlang,
  dplyr[case_match],
  purrr
)

set_intakes <- function(simulation, intakes) {
  message("Setting Caffein intakes")

  # Get all relevant paths
  time_paths <- purrr::map(ospsuite::getAllParametersMatching("**|Start time", simulation), "path")
  dose_paths <- purrr::map(ospsuite::getAllParametersMatching("**|Dose", simulation), "path")
  volume_paths <- purrr::map(ospsuite::getAllParametersMatching("Applications|Coffee Drinks|Solution|Application_*|ProtocolSchemaItem|Amount of water", simulation), "path")

  # Keep only enabled intakes
  enabled_intakes <- purrr::keep(intakes, ~ .x$selected)

  # For each enabled intake
  # Add the caffeine and water content to the intake
  # Set the intake in the simulation
  for (i in seq_along(enabled_intakes)) {

    caffein_dose <- enabled_intakes[[i]]$type[[1]]$caffeine
    water_volume <-enabled_intakes[[i]]$type[[1]]$water
    time <- enabled_intakes[[i]]$time

    # Set the caffeine dose
    ospsuite::setParameterValuesByPath(
      parameterPaths = dose_paths[[i]],
      values = caffein_dose,
      unit = "mg",
      simulation = simulation
    )

    # Set the time of intake
    ospsuite::setParameterValuesByPath(
      parameterPaths = time_paths[[i]],
      values = convert_time_to_min(time),
      unit = "min",
      simulation = simulation
    )

    # Set the volume of water
    ospsuite::setParameterValuesByPath(
      parameterPaths = volume_paths[[i]],
      values = water_volume,
      unit = "ml",
      simulation = simulation
    )
  }

  # Set remaining intakes to 0
  for (j in (i+1):length(dose_paths)) {
    if (j > length(dose_paths)) break

    ospsuite::setParameterValuesByPath(
      parameterPaths = dose_paths[[j]],
      values = 0,
      unit = "mg",
      simulation = simulation
    )

    ospsuite::setParameterValuesByPath(
      parameterPaths = time_paths[[j]],
      values = 0,
      unit = "min",
      simulation = simulation
    )

    ospsuite::setParameterValuesByPath(
      parameterPaths = volume_paths[[j]],
      values = 0,
      unit = "ml",
      simulation = simulation
    )
  }
}


convert_time_to_min <- function(time){
  # Convert time to minutes from midnight
  time <- as.POSIXct(time, format = "%H:%M")

  hour <- as.numeric(format(time, "%H"))
  minute <- as.numeric(format(time, "%M"))

  hour * 60 + minute
}
