#' Run Inkscape extension
#'
#' @param input The path of the input file
#' @param inkscape_extension_name The name of the Inkscape extension
#' @param ext The extension of the output file
#'
#' @return The output file
#' @export
#'
#' @examples
#' library(ggplot2)
#' "https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/italian-flag.svg" %>%
#' inx_extension("lorem_ipsum.py", ".svg") %>%
#' inx_actions(actions="", ".png") %>% png::readPNG() -> img
#' ggplot() +
#' annotation_raster(img, -Inf, Inf, -Inf, Inf)
inx_extension <- function(input, inkscape_extension_name, ext){
  if(Sys.info()['sysname']  == "Windows") {
    inx_extension_win(input, inkscape_extension_name, ext)
  } else{
    inx_extension_linux(input, inkscape_extension_name, ext)
  }
}
