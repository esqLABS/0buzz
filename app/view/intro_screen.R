box::use(
  shiny.destroy[destroyModule, makeModuleServerDestroyable, makeModuleUIDestroyable],
  shiny[moduleServer, NS, observeEvent, tagList],
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
        ethinicity_options = c("Option 1", "Option 2", "Option 3"),
        metabolism_options = c("low", "normal", "high"),
        init_shiny_data = list(
          ethnicity = "Option 1",
          gender = "male", # Options: 'male', 'female'
          age = 25,
          height = 1.70,
          weight = 70,
          metabolism = "high", # Options: 'low', 'normal', 'high'
          smoker = TRUE,
          intakes = list(
            list(
              type = "Coffee Type 1",
              time = "11:11",
              selected = FALSE
            ),
            list(
              type = "Coffee Type 2",
              time = "12:12",
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
        print(input$stepper_userdata) #! dev
      })

      # Observe Intake Data changes
      observeEvent(input$stepper_intake, {
        app_data$intake_data <- input$stepper_intake
        app_data$destroy_intro_screen <- TRUE
        print(input$stepper_intake) #! dev
      })

      # Remove loader when calcularion finished
      observeEvent(app_data$destroy_intro_screen, {
        destroyModule()
      })

    })
  }
)
