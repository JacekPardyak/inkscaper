#' Title
#'
#' @param input Path of the file to be copied
#'
#' @return Name of the file in Working Directory
#' @export
#'
#' @examples
#' input = system.file("extdata", "R_logo.svg", package = "inkscaper")
#' inx_write(input, "my_file.svg")
inx_write <- function(input, output) {
  if(Sys.info()['sysname']  == "Windows") {
    output = paste(getwd(), output, sep = "/")
  } else{
    output = paste(getwd(), output, sep = "\\")
  }
  file.copy(input, output, overwrite = TRUE)
}
