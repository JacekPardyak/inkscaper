library(xml2)
#' Title
#'
#' @param input SVG file
#' @param id element id
#' @param style new style
#'
#' @return svg file
#' @export
#'
#' @examples
#' library(tidyverse)
#' library(xml2)
#' # plot the original file
#' system.file("extdata", "rectangle.svg", package = "inkscaper") %>%
#' inx_actions(actions = NA, ext = ".png") %>%
#' png::readPNG(native = TRUE) %>%
#' grid::rasterGrob(interpolate=TRUE) -> img
#' ggplot() +
#' annotation_custom(img, xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=Inf)
#' # modify style and plot
#' system.file("extdata", "rectangle.svg", package = "inkscaper") %>%
#' inx_style(id = "rect788", style = "fill:#FFFFFF;stroke:#000000;stroke-width:1") %>%
#' inx_actions(actions = NA, ext = ".png") %>%
#' png::readPNG(native = TRUE) %>%
#' grid::rasterGrob(interpolate=TRUE) -> img
#' ggplot() +
#' annotation_custom(img, xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=Inf)
inx_style <- function(input, id, style){
  output = tempfile("inx_", fileext = ".svg")
  x <-  input %>% read_xml()
  xpath = sprintf("//*[@id='%s']", id) #paths = xml_path(xml_find_all(x, "//*[name()='path']"))
  node = xml_find_all(x, xpath)
  xml_attr(node, "style") = style
  xml_attr(node, "style")
  x %>% write_xml(output)
  output
}
