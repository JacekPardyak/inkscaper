#' @importFrom magrittr %>%
#' @export
magrittr::`%>%`

is_url <- function(path){
  grepl("^https?://", path)
}

is_svg <- function(path){
  # svg files ending in "</svg>" with or without whitespace following it
  grepl("<\\/svg>\\s?$", path)
}

download_svg <- function(url){
  filename = tempfile("inx", fileext = ".svg")
  download.file(url, filename)
  return(filename)
}


inx_source <- function(input) {
  if(!require(XML)) {install.packages('XML')}
  output <- tempfile("inx", fileext = c(".xml"))
  input %>% readLines(warn = FALSE) %>% writeLines(output)
  XML::xmlParse(output)
}
