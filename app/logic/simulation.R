box::use(
  shiny[moduleServer, NS],
  ospsuite
)


load_simulation <- function(){
  message("Initializing Simulation")
  simulation <- ospsuite::loadSimulation("app/logic/coffee-sim.pkml")
  ospsuite::setOutputInterval(simulation, 0, 24*60-1, resolution = 1/2)
  return(simulation)
}
