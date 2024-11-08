box::use(
  shiny[moduleServer, NS],
  ospsuite
)


load_simulation <- function(){
  message("Initializing Simulation")
  return(ospsuite::loadSimulation("app/logic/coffee-sim.pkml"))
}
