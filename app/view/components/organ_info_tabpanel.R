box::use(
  shiny[...],
  htmlwidgets[JS]
)

box::use(
  constants = app/logic/constants[ORGAN_TAB],
  helpers = app/logic/helpers[TAB_ELEMENT_SELECTED]
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  tagList(
    div(
      class = "container",
      id="tab",
      div(
        class = "tabbable",
        tags$ul(
          class="nav nav-pills organ-nav-pills",
          `data-tabsetid`="organ-tabset",
          role="tablist",
          lapply(1:length(constants$ORGAN_TAB), function(x) {
            tags$li(
              class="nav-item organ-nav-link",
              role="presentation organ-list",
              tags$a(
                href=paste0("#tab-", constants$ORGAN_TAB[[x]]$tab_url, "-", x),
                onclick = JS(
                  helpers$TAB_ELEMENT_SELECTED(ns("active_tab"), constants$ORGAN_TAB[[x]]$tab_url)
                ),
                `data-toggle`="tab",
                `data-bs-toggle`="tab",
                `data-value`=constants$ORGAN_TAB[[x]]$name,
                class = paste0("nav-link", ifelse(constants$ORGAN_TAB[[x]]$tab_url == "brain", " active", "")),
                `aria-selected`=x==1,
                role="tab",
                span(class = "organ-tab-icon",
                     img(
                       src = paste0("static/icons/", constants$ORGAN_TAB[[x]]$icon),
                       alt = constants$ORGAN_TAB[[x]]$name
                     )
                ),
                constants$ORGAN_TAB[[x]]$name
              )
            )
          })
        ),
        div(
          class = "tab-content",
          `data-tabsetid` = "organ-tabset",
          lapply(1:length(constants$ORGAN_TAB), function(x) {
            div(class = paste0("tab-pane", ifelse(constants$ORGAN_TAB[[x]]$tab_url == "brain", " active show", "")),
                id = paste0("tab-", constants$ORGAN_TAB[[x]]$tab_url, "-", x),
                `data-value`=constants$ORGAN_TAB[[x]]$name,
                role="tabpanel",

                div(
                  style = "margin-top: 2rem;",
                  switch(constants$ORGAN_TAB[[x]]$tab_url,
                         "brain" = {
                           div(
                             class = "container",
                             h1("Brain"),
                             p("This is the brain tab.")
                           )
                         },
                         "heart" = {
                           div(
                             class = "container",
                             h1("Heart"),
                             p("This is the heart tab.")
                           )
                         },
                         "blood" = {
                           div(
                             class = "container",
                             h1("Blood"),
                             p("This is the blood tab.")
                           )
                         }
                  )
                )

            )
          })
        )
      )
    )
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    message("Server started - organ tab")

    observeEvent(input$active_tab, {
      message("Active tab: ")
      print(input$active_tab)
    }, ignoreNULL = FALSE)

  })
}
