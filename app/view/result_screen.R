box::use(
  bslib[page_fillable, layout_columns],
  shiny[div, h1, moduleServer, NS, renderTable, renderUI, tableOutput, tagList, uiOutput, renderPlot, plotOutput, fluidRow, column],
)

box::use(
  app/view/components/organ_info_tabpanel,
  app/logic/plot[get_plot],
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
    organ_info_tabpanel$server("organ_info_tabpanel")


    output$plot <- renderPlot({
      get_plot(app_data$simulation_results)
    })


    output$result_screen <- renderUI({
      tagList(
        div(
          style = "margin-top: 2rem;",
          organ_info_tabpanel$ui(session$ns("organ_info_tabpanel"))
        ),
        fluidRow(column(plotOutput(session$ns("plot")), width = 10, offset = 1))
      )
    })

    output$table <- renderTable({
      data.frame(
        "Name" = c("John Doe", "Jane Doe"),
        "Age" = c(23, 25)
      )
    })
  })
}
