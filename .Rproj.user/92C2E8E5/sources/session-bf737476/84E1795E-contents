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
      intro_screen_page(id = ns("intro"))
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
