box::use(
  bslib[page],
  shiny[moduleServer, NS, observeEvent, reactiveValues, req],
  ospsuite[runSimulation]
)
box::use(
  # Import the component
  app/view/intro_screen,
  app/view/result_screen,
  app/logic/simulation[load_simulation],
  app/logic/individual[set_individual],
  app/logic/intakes[set_intakes]
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  page(
    intro_screen$ui(ns("intro_screen")),
    result_screen$ui(ns("result_screen"))
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    message("Main Server")
    # Dummy test structure
    app_data <- reactiveValues(
      destroy_intro_screen = NULL,
      user_data = NULL,
      characteristics_ready = FALSE,
      intakes_ready = FALSE
      )

    simulation <- load_simulation()

    intro_screen$server("intro_screen", app_data)

    # When user characteristics are received, apply them to the simulation
    observeEvent(app_data$user_data, {
      app_data$characteristics_ready = FALSE
      set_individual(simulation, app_data$user_data)
      app_data$characteristics_ready = TRUE
    })

    # When user modifies caffeine intakes, update the simulation
    # observeEvent(app_data$user_data$intakes,{
    observeEvent(app_data$user_data$intakes,{
      app_data$intakes_ready = FALSE
    #   set_intakes(simulation, app_data$user_data$intakes)
      set_intakes(simulation, app_data$user_data$intakes)
      app_data$intakes_ready = TRUE
    })

    observeEvent(c(app_data$characteristics_ready, app_data$intakes_ready), {

      req(app_data$characteristics_ready)
      req(app_data$intakes_ready)
      # Indicate calculation start
      message("Starting long calculation...")

      # Imitate a long calculation
      # ospsuite:::runSimulation(simulation)
      Sys.sleep(2)

      # Update status after calculation completes
      message("User data received. Destroying intro screen.")
      app_data$destroy_intro_screen <- TRUE
      result_screen$server("result_screen")
    })

  })
}
