#' Apply style to a node
#'
#' @param input SVG file
#' @param id element id
#' @param style new style
#'
#' @return svg file
#' @export
#'
#' @examples
#' library(ggplot2)
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
  x <-  input %>% xml2::read_xml()
  xpath = sprintf("//*[@id='%s']", id) #paths = xml_path(xml_find_all(x, "//*[name()='path']"))
  node = xml2::xml_find_all(x, xpath)
  xml2::xml_attr(node, "style") = style #xml2::xml_attr(node, "style")
  x %>% xml2::write_xml(output)
  output
}
