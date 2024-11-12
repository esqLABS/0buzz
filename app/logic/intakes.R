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
  volume_paths <- purrr::map(ospsuite::getAllParametersMatching("**|Volume of water/body weight", simulation), "path")

  # Keep only enabled intakes
  enabled_intakes <- purrr::keep(intakes, ~ .x$selected)

  # For each enabled intake
  # Add the caffeine and water content to the intake
  # Set the intake in the simulation
  for (i in seq_along(enabled_intakes)) {
    # Get the coffee stats
    coffee_stats <- get_coffee_stats(enabled_intakes[[i]]$type)
    # add stats to the list
    enabled_intakes[[i]]$caffeine <- coffee_stats$caffeine
    enabled_intakes[[i]]$water <- coffee_stats$water

    # Set the caffeine dose
    ospsuite::setParameterValuesByPath(
      parameterPaths = dose_paths[[i]],
      values = enabled_intakes[[i]]$caffeine,
      unit = "mg",
      simulation = simulation
    )

    # Set the time of intake
    ospsuite::setParameterValuesByPath(
      parameterPaths = time_paths[[i]],
      values = convert_time_to_min(enabled_intakes[[i]]$time),
      unit = "min",
      simulation = simulation
    )

    # Set the volume of water
    # TODO
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
      unit = "l/kg",
      simulation = simulation
    )
  }
}


get_coffee_stats <- function(coffee_type) {
  # Based on coffee type, return the caffein content (in mg) and the amount of water (in mL)
  stats <- case_match(
    coffee_type,
    "Espresso" ~ list(list(caffeine = 64, water = 30)),
    "Americano" ~ list(list(caffeine = 77, water = 150)),
    "Cappuccino" ~ list(list(caffeine = 75, water = 180)),
    "Latte" ~ list(list(caffeine = 63, water = 220)),
    "Mocha" ~ list(list(caffeine = 95, water = 240)),
    "Macchiato" ~ list(list(caffeine = 71, water = 30)),
    "Ristretto" ~ list(list(caffeine = 75, water = 22)),
    "Long Black" ~ list(list(caffeine = 77, water = 120)),
    "Flat White" ~ list(list(caffeine = 77, water = 160)),
    "Affogato" ~ list(list(caffeine = 64, water = 30)),
    "Irish" ~ list(list(caffeine = 77, water = 150)),
    "Turkish" ~ list(list(caffeine = 95, water = 240)),
    "Greek" ~ list(list(caffeine = 95, water = 240)),
    "Vietnamese" ~ list(list(caffeine = 77, water = 150)),
    "Iced" ~ list(list(caffeine = 77, water = 150)),
    "Decaf" ~ list(list(caffeine = 2, water = 240))
  )

  return(stats[[1]])
}

convert_time_to_min <- function(time){
  # Convert time to minutes from midnight
  time <- as.POSIXct(time, format = "%H:%M")

  hour <- as.numeric(format(time, "%H"))
  minute <- as.numeric(format(time, "%M"))

  hour * 60 + minute
}
