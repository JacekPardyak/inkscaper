#' Title
#'
#' @param input svg file
#'
#' @return svg source xml
#' @export
#'
#' @examples
#' input = system.file("extdata", "R_logo.svg", package = "inkscaper", mustWork = TRUE)
#' input %>% inx_source()
inx_source <- function(input) {
  output <- tempfile("inx_", fileext = c(".xml"))
  input %>% readLines(warn = FALSE) %>% writeLines(output)
  XML::xmlParse(output)
}
