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
        id = ns("intro"),
        ethinicity_options = c("European", "White American", "Black American","Mexican American", "Asian", "Japanese"),
        metabolism_options = c("low", "normal", "high"),
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

      observeEvent(input$intro, {
        app_data$user_data <- input$intro
        print(input$intro)
      })

      observeEvent(app_data$destroy_intro_screen, {
        destroyModule()
      })

    })
  }
)
