box::use(
  shiny.destroy[destroyModule, makeModuleServerDestroyable, makeModuleUIDestroyable],
  shiny[...],
  bslib[accordion, accordion_panel],
  stats[runif]
)

box::use(
  app/view/react[edit_intake_data, edit_user_data],
  app/logic/constants[DRINK_TYPES, POPULATIONS, METABOLISM, UNITS]
)

#' @export
ui <- makeModuleUIDestroyable(
  function(id) {
    ns <- NS(id)
    tagList(
      showModal(
        modalDialog(
          title = "Edit Selection",
          size = "xl",
          class = "modal-container-edit-data",
          accordion(
            id = ns("accordion"),
            multiple = FALSE,
            accordion_panel(
              title = "Health Factors",
              tagList(
                uiOutput(ns("user_content"))
              )
            ),
            accordion_panel(
              title = "Caffeine Intake",
              tagList(
                uiOutput(ns("intake_content"))
              )
            )
          ),
          footer = tagList(
            div(
              class="modal-window-btn-group-footer",
              actionButton(ns("cancel"), "Cancel", class = "cancel-btn"),
              actionButton(ns("run_analysis"), "Run Analysis", disabled = TRUE, class = "run-analysis-btn")
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

      observeEvent(input$cancel, {
        removeModal()
      })


      output$user_content <- renderUI({
        tagList(
          edit_user_data(
            id = session$ns("edit_user_data"),
            init_shiny_data = app_data$user_data,
            ethinicity_options = POPULATIONS,
            metabolism_options = METABOLISM,
            coffee_type_options = DRINK_TYPES,
            unit_options = UNITS
          )
        )
      })

      output$intake_content <- renderUI({
        tagList(
          edit_intake_data(
            id = session$ns("edit_intake_data"),
            init_shiny_data = app_data$intake_data,
            coffee_type_options = DRINK_TYPES
          )
        )
      })


      observeEvent(c(input$edit_intake_data, input$edit_user_data), {
        updateActionButton(session, "run_analysis", disabled = FALSE)
      })

      observeEvent(input$run_analysis, {

        if(isTruthy(input$edit_user_data)) {
          app_data$user_data <- input$edit_user_data
        }
        if(isTruthy(input$edit_intake_data)) {
          app_data$intake_data <- input$edit_intake_data$intakes
        }

        removeModal()
      })


    })
  })

