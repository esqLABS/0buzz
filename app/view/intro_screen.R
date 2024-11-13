box::use(
  shiny.destroy[destroyModule, makeModuleServerDestroyable, makeModuleUIDestroyable],
  shiny[moduleServer, NS, tagList, observeEvent],
)
box::use(
  app/view/react[intro_screen_page], # Import the component.
)

#' @export
ui <- makeModuleUIDestroyable(
  function(id) {
    ns <- NS(id)
    tagList(
      intro_screen_page(
        id = ns("stepper"),
        ethinicity_options = c("European", "White American", "Black American","Mexican American", "Asian", "Japanese"),
        metabolism_options = c("low", "normal", "high"),
        coffee_type_options = list(
          `espresso` = list(
            water = 100,
            caffein = 10
          ),
          `latte` = list(
            water = 200,
            caffein = 20
          ),
          `cappuccino` = list(
            water = 300,
            caffein = 30
          )
        ),
        unit="metric",
        unit_options = c("metric", "imperial"),
        init_shiny_data = list(
          ethnicity = "European",
          gender = "male", # Options: 'male', 'female'
          age = 25,
          height = 1.70,
          weight = 70,
          metabolism = "high", # Options: 'low', 'normal', 'high'
          smoker = TRUE,
          intakes = list(
            list(
              type = "Americano",
              time = "08:00",
              selected = FALSE
            ),
            list(
              type = "Espresso",
              time = "10:00",
              selected = TRUE
            )
          )
        )
      )
    )
  }
)

#' @export
server <- makeModuleServerDestroyable(
  function(id, app_data) {
    moduleServer(id, function(input, output, session) {
      message("Server started - modal")

      # Observe User Data changes
      observeEvent(input$stepper_userdata, {
        app_data$user_data <- input$stepper_userdata
        print(app_data$user_data) #! dev
      })

      # Observe Intake Data changes
      observeEvent(input$stepper_intake, {
        app_data$intake_data <- input$stepper_intake$intakes
        app_data$destroy_intro_screen <- TRUE
        print(app_data$intake_data) #! dev
      })

      # Remove loader when calcularion finished
      observeEvent(app_data$destroy_intro_screen, {
        destroyModule()
      })

    })
  }
)
