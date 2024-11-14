box::use(
  shiny[moduleServer, NS],
  ospsuite
)

get_plot <- function(simulation_results){
  message("Generating time profile plot")
  dc <- ospsuite::DataCombined$new()

  pc <- ospsuite::DefaultPlotConfiguration$new()
  pc$xUnit <- "h"
  pc$legendPosition <- "outsideTopRight"
  pc$xAxisTicks <- 0:24

  dc$addSimulationResults(simulation_results[[1]])

  return(ospsuite::plotIndividualTimeProfile(dc,defaultPlotConfiguration = pc))

}


