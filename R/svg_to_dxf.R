#' Title
#'
#' @param input file or url of the SVG
#'
#' @return file name
#' @export
#'
#' @examples
#' library(tidyverse)
#' library(sf)
#' input = system.file("extdata", "R_logo.svg", package = "inkscaper", mustWork = TRUE)
#' input %>%
#' svg_to_dxf() %>%
#' st_read() %>%
#' ggplot() +
#'   geom_sf()
#'
#' "https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/tiger.svg" %>%
#' svg_to_dxf() %>%
#' st_read() %>%
#' ggplot() +
#'   geom_sf()
svg_to_dxf <- function(input){
  inx_extension(input, inkscape_extension_name = "dxf12_outlines.py", ext = ".dxf")
}
