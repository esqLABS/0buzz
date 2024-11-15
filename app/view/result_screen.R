box::use(
  bslib[page_fillable, layout_column_wrap, card, card_body],
  shiny[div, h1, h3, img, moduleServer, NS, renderTable, renderUI, renderPlot, plotOutput, tableOutput, tagList, uiOutput, observeEvent],
  shiny.destroy[destroyModule, makeModuleServerDestroyable, makeModuleUIDestroyable],
  htmlwidgets[JS],
  # ggiraph[girafeOutput, renderGirafe]
)

box::use(
  app/view/components/organ_info_tabpanel,
  app/view/edit_modal,
  app/logic/helpers[CREATE_SHINT_INPUT_FROM_JS],
  app/logic/plot[get_plot]
)

#' @export
ui <- function(id) {
    ns <- NS(id)
    tagList(
      uiOutput(ns("result_screen"))
    )
}

#' @export
server <- function(id, app_data) {
    moduleServer(id, function(input, output, session) {
      message("Server started - result screen")
      organ_info_tabpanel$server("organ_info_tabpanel", app_data)

      observeEvent(input$edit, {
        message("Edit modal open")
        edit_modal$ui(session$ns("edit"))
        edit_modal$server("edit", app_data)
      })


      # output$plot <- renderGirafe({
      #   app_data$destroy_intro_screen <- TRUE # remove loading screen
      #   get_plot(app_data)
      # })

      output$plot <- renderPlot({
        app_data$destroy_intro_screen <- TRUE # remove loading screen
        get_plot(app_data)
      })

      output$result_screen <- renderUI({
        tagList(
          div(class = "container app-title",
              h3(
                "Caffeine App"
              ),
              img(
                onclick = JS(CREATE_SHINT_INPUT_FROM_JS(session$ns("edit"))),
                src = "static/icons/edit.png"
              )
          ),
          layout_column_wrap(
            width = 1/2,
            heights_equal = "row",
            div(class = "container", style = "margin-top: 1rem;",
                card(
                  height = 300,
                  full_screen = TRUE,
                  card_body(
                    # girafeOutput(session$ns("plot"))
                    plotOutput(session$ns("plot"))
                    )
                )
            ),
            div(
              style = "margin-top: 1rem;",
              organ_info_tabpanel$ui(session$ns("organ_info_tabpanel"))
            )
          )
        )
      })

    })
}
