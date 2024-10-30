box::use(
  shiny[h1, moduleServer, NS, renderTable, renderUI, tableOutput, tagList, uiOutput],
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

    output$result_screen <- renderUI({
      tagList(
        h1("Shiny Part - Result Screen"),
        tableOutput(session$ns("table"))
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
