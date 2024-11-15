box::use(
  shiny[moduleServer, NS],
  ospsuite,
  dplyr[mutate, select, filter, row_number, case_when],
  magrittr[...],
  stringr[str_detect],
  lubridate[...]
)


load_simulation <- function() {
  message("Initializing Simulation")
  simulation <- ospsuite::loadSimulation("app/logic/coffee-sim.pkml")
  ospsuite::setOutputInterval(simulation, 0, 24 * 60 - 1, resolution = 1 / 2)
  ospsuite::setOutputs(
    c(
      "Organism|PeripheralVenousBlood|Caffeine|Plasma (Peripheral Venous Blood)",
      "Organism|Brain|Intracellular|Caffeine|Concentration",
      "Organism|Heart|Intracellular|Caffeine|Concentration"
    ),
    simulation
  )
  return(simulation)
}


get_simulation_results <- function(simulation){
  results <- ospsuite::runSimulations(simulation)

  df <- ospsuite::simulationResultsToTibble(results[[1]]) %>%
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
  df <- filter(df, row_number() >= start_row) %>%
    # Transform minute number to time of the day
    mutate(Time = as_datetime(Time * 60))
}
