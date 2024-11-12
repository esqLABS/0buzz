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
      intake_data = NULL
    )


    simulation <- load_simulation()

    intro_screen$server("intro_screen", app_data)

    # When user characteristics are received, apply them to the simulation
    observeEvent(app_data$user_data, {
      set_individual(simulation, app_data$user_data)
    })

    # When user modifies caffeine intakes, update the simulation
    observeEvent(app_data$intakes, {
      set_intakes(simulation, app_data$intakes)
    })

    observeEvent(c(app_data$user_data, app_data$intakes), {
      req(app_data$user_data)
      req(app_data$intakes)
      # Indicate calculation start
      message("Running simulation...")
      # ospsuite:::runSimulation(simulation)
      Sys.sleep(2)

      message("User data received. Destroying intro screen.")
      app_data$destroy_intro_screen <- TRUE
      result_screen$server("result_screen")
    })

  })
}
