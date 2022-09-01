library(tidyverse)
library(sf)
library(inkscaper)

x = "https://geodata.nationaalgeoregister.nl/cbsgebiedsindelingen/wfs?request=GetFeature&service=WFS&version=2.0.0&typeName=cbs_gemeente_2022_gegeneraliseerd&outputFormat=json" %>%
  st_read() %>%
  filter(statnaam == "'s-Gravenhage") %>%
  st_transform(., st_crs("EPSG:4326")) %>% # change CRS to WGS 84
  inx_sf2svg() %>% # export to SVG
  inx_actions(actions = "select-all;transform-scale:300", ext = ".svg") %>%
  inx_actions(actions = 'export-area-drawing', ext = ".svg") %>%
  inx_write("my_file.svg")

"my_file.svg" %>%
  inx_actions(actions = NA, ext = ".png") %>%
  png::readPNG(native = TRUE) %>%
  grid::rasterGrob(interpolate=TRUE) -> img
ggplot() +
  annotation_custom(img, xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=Inf)

library(xml2)
inx_style <- function(input, id, style){
#  input = "my_file.svg"
#  id = "path18"
#  style = "fill:#FFFFFF;stroke:#000000;stroke-width:1"
  output = tempfile("inx_", fileext = ".svg")
  x <-  input %>% read_xml()
  xpath = sprintf("//*[@id='%s']", id) #paths = xml_path(xml_find_all(x, "//*[name()='path']"))
  node = xml_find_all(x, xpath)
  xml_attr(node, "style") = style
  xml_attr(node, "style")
  x %>% write_xml(output)
  output
}

inx_style(input = "my_file.svg", id = "path18", style = "fill:#FFFFFF;stroke:#000000;stroke-width:1") %>%
  inx_write("my_file_out.svg")

"my_file_out.svg" %>%
  inx_actions(actions = NA, ext = ".png") %>%
  png::readPNG(native = TRUE) %>%
  grid::rasterGrob(interpolate=TRUE) -> img
ggplot() +
  annotation_custom(img, xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=Inf)

system.file("extdata", "rectangle.svg", package = "inkscaper")

system.file("extdata", "rectangle.svg", package = "inkscaper") %>%
  inx_actions(actions = NA, ext = ".png") %>%
  png::readPNG(native = TRUE) %>%
  grid::rasterGrob(interpolate=TRUE) -> img
ggplot() +
  annotation_custom(img, xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=Inf)

