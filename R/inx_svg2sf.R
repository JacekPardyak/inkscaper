#' Title
#'
#' @param input Path or url of the SVG input file.
#'
#' @return Simple feature collection of geometry type LINESTRING.
#' @export
#'
#' @examples
#' library(ggplot2)
#' library(sf)
#' sf_from_svg <- "https://upload.wikimedia.org/wikipedia/commons/3/30/Den_Haag_wapen.svg" %>%
#' inx_svg2sf()
#' sf_from_svg
#' sf_from_svg %>%
#' ggplot() +
#' geom_sf()
inx_svg2sf <- function(input){
  inx_extension(input, inkscape_extension_name = "dxf12_outlines.py", ext = ".dxf") %>%
  sf::st_read()
}
