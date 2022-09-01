#' Write the file in your working directory
#'
#' @param input The path of the file to be copied
#' @param output The name of the file in the working directory
#'
#' @return Logical
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
