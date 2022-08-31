library(tidyverse)
library(sf)
library(inkscaper)
nc <- system.file("shape/nc.shp", package="sf") %>% st_read()

"https://geodata.nationaalgeoregister.nl/cbsgebiedsindelingen/wfs?request=GetFeature&service=WFS&version=2.0.0&typeName=cbs_gemeente_2022_gegeneraliseerd&outputFormat=json" %>%
  st_read() %>%
#  filter(statnaam == "'s-Gravenhage") %>%
  st_transform(crs = st_crs(nc)) %>% # this is important . transform-scale < 1 doesnt work - gives 0
  inx_sf2svg() %>%
  inx_actions(actions = "select-all;transform-scale:5000", ext = ".svg") %>%
  inx_actions(actions = 'export-area-drawing', ext = ".svg") %>%
  inx_write("my_file.svg")

"my_file.svg" %>%
  inx_actions(actions = NA, ext = ".png") %>%
  png::readPNG(native = TRUE) %>%
  grid::rasterGrob(interpolate=TRUE) -> img
ggplot() +
  annotation_custom(img, xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=Inf)

library(xml2)
x <- "my_file.svg" %>% read_xml()
paths = xml_path(xml_find_all(x, "//*[name()='path']"))
node <- xml_find_all(x, paths[[5]]) # xml_find_all(x, "/*/*[4]/*")
xml_attr(node, "style")
xml_attr(node, "style") = "fill:#CCCCCA;stroke:#d60000;stroke-width:5" #fill:#1a1a1a;stroke:#d60000;stroke-width:0.100012;stroke-linecap:round
xml_attr(node, "style")
x %>% write_xml("my_file_out.svg")
"my_file_out.svg" %>%
  inx_actions(actions = NA, ext = ".png") %>%
  png::readPNG(native = TRUE) %>%
  grid::rasterGrob(interpolate=TRUE) -> img
ggplot() +
  annotation_custom(img, xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=Inf)



