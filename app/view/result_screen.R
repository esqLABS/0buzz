box::use(
  bslib[page_fillable, layout_columns],
  shiny[div, h1, moduleServer, NS, renderTable, renderUI, tableOutput, tagList, uiOutput],
)

box::use(
  app/view/components/organ_info_tabpanel
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  tagList(
    uiOutput(ns("result_screen")),
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    message("Server started - result screen")
    organ_info_tabpanel$server("organ_info_tabpanel")

    output$result_screen <- renderUI({
      tagList(
        div(
          style = "margin-top: 2rem;",
          organ_info_tabpanel$ui(session$ns("organ_info_tabpanel"))
        )
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
