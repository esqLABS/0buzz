box::use(
  bslib[page],
  shiny[moduleServer, NS, observeEvent, reactiveValues],
)
box::use(
  # Import the component
  app/view/intro_screen,
  app/view/result_screen,
  app/logic/simulation[load_simulation],
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
      user_data = NULL
    )

    simulation <- load_simulation()

    intro_screen$server("intro_screen", app_data)

    observeEvent(app_data$user_data, {
      # Indicate calculation start
      message("Starting long calculation...")

      # Imitate a long calculation
      Sys.sleep(7)  # 7-second delay to imitate processing

      # Update status after calculation completes
      message("User data received. Destroying intro screen.")
      app_data$destroy_intro_screen <- TRUE
      result_screen$server("result_screen")
    })

  })
}
