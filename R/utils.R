is_url <- function(path){
  grepl("^https?://", path)
}

is_svg <- function(path){
  grepl("<\\/svg>\\s?$", path)
}

download_svg <- function(url){
  filename = tempfile("inx_", fileext = ".svg")
  utils::download.file(url, filename)
  return(filename)
}


#inx_source <- function(input) {
#  if(!require(XML)) {install.packages('XML')}
#  output <- tempfile("inx_", fileext = c(".xml"))
#  input %>% readLines(warn = FALSE) %>% writeLines(output)
#  XML::xmlParse(output)
#}
