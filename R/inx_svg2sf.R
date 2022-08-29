#' Title
#'
#' @param input file or url of the SVG
#'
#' @return simple features
#' @export
#'
#' @examples
#' library(tidyverse)
#' library(sf)
#' input = system.file("extdata", "R_logo.svg", package = "inkscaper", mustWork = TRUE)
#' input %>%
#' inx_svg2sf() %>%
#' ggplot() +
#'   geom_sf()
#'
#' "https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/tiger.svg" %>%
#' inx_svg2sf() %>%
#' ggplot() +
#'   geom_sf()
inx_svg2sf <- function(input){
  inx_extension(input, inkscape_extension_name = "dxf12_outlines.py", ext = ".dxf") %>%
  sf::st_read()
}
