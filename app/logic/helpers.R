#' @export
CREATE_SHINT_INPUT_FROM_JS <- function(input_id) {
  sprintf("Shiny.setInputValue('%s', Math.random());", input_id)
}

#' @export
TAB_ELEMENT_SELECTED <- function(input_id, tab_element) {
  sprintf("Shiny.setInputValue('%s', '%s');", input_id, tab_element)
}
