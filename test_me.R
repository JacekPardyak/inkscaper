library(tidyverse)
library(sf)
library(inkscaper)

system.file("shape/nc.shp", package="sf") %>%
  st_read() %>%
  inx_sf2svg() %>%
  inx_actions(actions = "select-all;transform-scale:50", ext = ".svg") %>%
  inx_actions(actions = 'export-area-drawing', ext = ".svg") %>%
  inx_actions(actions = NA, ext = ".png") %>%
  png::readPNG(native = TRUE) %>%
  grid::rasterGrob(interpolate=TRUE) -> img
ggplot() +
  annotation_custom(img, xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=Inf)

library(tidyverse)
library(sf)
devtools::install_github("JacekPardyak/inkscaper")
library(inkscaper)

img = "https://upload.wikimedia.org/wikipedia/commons/4/4f/SVG_Logo.svg" %>%
  inx_actions(actions = NA, ext = ".png") %>%
  png::readPNG(native = TRUE) %>%
  grid::rasterGrob(interpolate=TRUE)

ggplot() +
  annotation_custom(img, xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=Inf)

"https://upload.wikimedia.org/wikipedia/commons/4/4f/SVG_Logo.svg" %>%
  inx_svg2sf() %>%
  ggplot() +
  geom_sf()

"https://upload.wikimedia.org/wikipedia/commons/4/4f/SVG_Logo.svg" %>%
  inx_actions(actions = "select-all;object-to-path", ext = ".svg") %>%
  inx_svg2sf() %>%
  ggplot() +
  geom_sf()

# try transformations
"https://upload.wikimedia.org/wikipedia/commons/4/4f/SVG_Logo.svg" %>%
  xml2::read_xml()

"https://upload.wikimedia.org/wikipedia/commons/4/4f/SVG_Logo.svg" %>%
  inx_actions(actions = "select-all;object-to-path", ext = ".svg") %>%
  xml2::read_xml()


"https://upload.wikimedia.org/wikipedia/commons/4/4f/SVG_Logo.svg" %>%
  inx_actions(actions = "select-all;object-to-path", ext = ".svg") %>%
  inx_actions(actions = "select-by-id:base;transform-translate:-10,10", ext = ".svg") %>%
  xml2::read_xml()
# reference to the code of actions:
# https://gitlab.com/inkscape/inkscape/-/tree/master/src/actions

svg_sf <- "https://upload.wikimedia.org/wikipedia/commons/4/4f/SVG_Logo.svg" %>%
  inx_actions(actions = "select-all;object-to-path", ext = ".svg") %>%
  inx_actions(actions = "select-by-id:base;transform-translate:-20,10", ext = ".svg") %>%
  inx_actions(actions = "select-by-id:use26;delete-selection", ext = ".svg") %>%
  inx_svg2sf()
svg_sf %>%
  ggplot() +
  geom_sf()

system('inkscape --version')

# Logo Den Haag
img = "https://upload.wikimedia.org/wikipedia/commons/3/30/Den_Haag_wapen.svg" %>%
  inx_actions(actions = NA, ext = ".png") %>%
  png::readPNG(native = TRUE) %>%
  grid::rasterGrob(interpolate=TRUE)
ggplot() +
  annotation_custom(img, xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=Inf)

svg_sf <- "https://upload.wikimedia.org/wikipedia/commons/3/30/Den_Haag_wapen.svg" %>%
  inx_svg2sf()
svg_sf
svg_sf %>%
  ggplot() +
  geom_sf()

# -----------------------------------------------------------------
# sf to svg
"https://geodata.nationaalgeoregister.nl/cbsgebiedsindelingen/wfs?request=GetFeature&service=WFS&version=2.0.0&typeName=cbs_gemeente_2022_gegeneraliseerd&outputFormat=json" %>%
  st_read() %>%
  ggplot() +
  geom_sf()

"https://geodata.nationaalgeoregister.nl/cbsgebiedsindelingen/wfs?request=GetFeature&service=WFS&version=2.0.0&typeName=cbs_gemeente_2017_gegeneraliseerd&outputFormat=json" %>%
  st_read() %>%
  filter(statnaam == "'s-Gravenhage") %>%
  inx_sf2svg() %>%
  inx_actions(actions = "export-area-drawing", ext = ".svg") %>%
  inx_actions(actions = "select-all;transform-scale:0.1", ext = ".svg") %>%
  inx_write("my_file.svg")
"my_file.svg" %>%
  inx_actions(actions = NA, ext = ".png") %>%
  png::readPNG(native = TRUE) %>%
  grid::rasterGrob(interpolate=TRUE) -> img
ggplot() +
  annotation_custom(img, xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=Inf)


"https://geodata.nationaalgeoregister.nl/cbsgebiedsindelingen/wfs?request=GetFeature&service=WFS&version=2.0.0&typeName=cbs_gemeente_2022_gegeneraliseerd&outputFormat=json" %>%
  st_read() %>%
  st_cast("MULTILINESTRING") %>%
  filter(statnaam == "'s-Gravenhage") %>%
  inx_sf2svg() %>%
  inx_actions(actions = "select-all;transform-scale:0.001", ext = ".svg") %>%
  xml2::read_xml()

"https://geodata.nationaalgeoregister.nl/cbsgebiedsindelingen/wfs?request=GetFeature&service=WFS&version=2.0.0&typeName=cbs_gemeente_2022_gegeneraliseerd&outputFormat=json" %>%
  st_read() %>%
  filter(statnaam == "'s-Gravenhage") %>%
  inx_sf2svg() %>%
  inx_actions(actions = "select-all;transform-scale:0.1", ext = ".svg") %>%
  inx_actions(actions = "export-area-drawing", ext = ".svg") %>%
  inx_write("my_file.svg")

"https://geodata.nationaalgeoregister.nl/cbsgebiedsindelingen/wfs?request=GetFeature&service=WFS&version=2.0.0&typeName=cbs_gemeente_2022_gegeneraliseerd&outputFormat=json" %>%
  st_read() %>%
  filter(statnaam == "'s-Gravenhage") %>%
  inx_sf2svg() %>%
  #  inx_actions(actions = "select-all;transform-scale:1", ext = ".svg") %>%
  #  inx_actions(actions = "export-area-drawing", ext = ".svg") %>%
  inx_actions(actions = NA, ext = ".png") %>%
  png::readPNG(native = TRUE) %>%
  grid::rasterGrob(interpolate=TRUE) -> img
ggplot() +
  annotation_custom(img, xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=Inf)


tmp %>%
  xml2::read_xml()
tmp  %>%
  ggplot() +
  geom_sf()

%>%


  inx_write("my_file.svg")

library(xml2)
x <- "my_file.svg" %>% xml2::read_xml()
ns <- xml_ns(x)
ns
doc <- xml_children(x)[[4]]
xml_attrs(doc)
xml_attrs(doc, ns)
doc_doc <- xml_children(doc)[[1]]
xml_attrs(doc_doc)
xml_attrs(doc_doc, ns)

xml_attr(doc_doc, "style") <- "fill:#CCCCCA;stroke-width:0.001"
xml_attr(doc_doc, "style")


x <- read_xml("<root id='1'><child id ='a' /><child id='b' d='b'/></root>")
xml_attr(x, "id")
xml_attrs(x)

xml_attrs(x, ns = character())
xml_attrs(x, ns = "xmlns:svg")
xml_attrs(x, ns = character())
xml_attrs(x)
children <- xml_children(x)
bees <- xml_find_all(x, "//*[name()='g']")
#xml2::xml_find_all(x, "//*[name()='path']")
paths = xml2::xml_find_all(x, "//*[name()='path']")
paths[5]
xml_attrs(paths[5])['style']
xml_attr(xml_find_all(x, "//*[name()='g']//*[name()='path']"), "style")
xml_attr(xml_find_all(x, "//*[name()='g']//*[name()='path']"), "style") = "fill:#CCCCCA;stroke-width:0.001"

xml_attr(x, "//svg")

?xml2_example

