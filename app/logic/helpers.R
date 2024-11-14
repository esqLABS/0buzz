#' @export
CREATE_SHINT_INPUT_FROM_JS <- function(input_id) {
  sprintf("Shiny.setInputValue('%s', Math.random());", input_id)
}
