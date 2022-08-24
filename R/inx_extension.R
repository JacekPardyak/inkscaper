#' Title
#'
#' @param input file path
#' @param name of the inkscape_extension_name
#' @param ext - extension of the output file
#'
#' @return a ouput file
#' @export
#'
#' @examples
#' library(tidyverse)
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
