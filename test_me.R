library(tidyverse)
library(sf)




input = system.file("extdata", "MyStar.svg", package = "inkscaper", mustWork = TRUE)
input %>% inx_actions(actions = NA, ext = ".png")# %>%
  png::readPNG() %>%
  grid::grid.raster()
input %>% inx_actions(actions = "select-by-id:MyStar;object-flip-vertical", ext = ".png") %>%
  png::readPNG() %>%
  grid::grid.raster()


input = system.file("extdata", "MyStar.svg", package = "inkscaper", mustWork = TRUE)
grid::grid.newpage()
input %>% inx_actions(actions = NA, ext = ".png") %>%
  png::readPNG() %>%
  grid::grid.raster()
grid::grid.newpage()
input %>% inx_actions(actions = "select-by-id:MyStar;object-flip-vertical", ext = ".png") %>%
  png::readPNG() %>%
  grid::grid.raster()


# ciekawe
# https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/eee.svg
# https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/decimal.svg


"https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/gallardo.svg" %>%
  inx_actions(actions = NA, ext = ".png") %>%
  png::readPNG() %>%
  grid::grid.raster()

"https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/gallardo.svg" %>%
  inx_actions(actions = "select-by-id:layer3,layer6;object-align:right | bottom", ext = ".png") %>%
  png::readPNG() %>%
  grid::grid.raster()


# cool but useless

"https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/heart.svg" %>%
  inx_actions(actions = NA, ext = ".png") %>%
  png::readPNG() %>%
  grid::grid.raster()

# heart

st_circ
CIRCULARSTRING


df <- tibble(t = seq(0, 2*pi, 0.1)) %>%
  mutate( x = 16*sin(t)^3 ) %>%
  mutate( y = 13*cos(t)-5*cos(2*t)-2*cos(3*t)-cos(4*t))

df <- df %>% bind_rows(df %>% slice(1)) %>% select(x, y) %>% as.matrix() %>%
  st_linestring() %>% st_sfc() %>% st_sf()
df
df
df %>% ggplot() +
  geom_sf()
output = tempfile("inx_", fileext = ".dxf")
df %>% st_write(dsn = output, driver ="DXF", delete_dsn = TRUE)
inx_extension(output, inkscape_extension_name = "dxf_input.py", ext = ".svg") %>%
  inx_source()


inx_extension(output, inkscape_extension_name = "dxf_input.py", ext = ".svg") %>%
  inx_actions(actions = 'export-area-drawing', ext = ".svg") %>%
  inx_actions(actions = NA, ext = ".png") %>%
  png::readPNG() %>%
  grid::grid.raster()

CURVEPOLYGON(COMPOUNDCURVE(CIRCULARSTRING(0 0,2 0, 2 1, 2 3, 4 3),(4 3, 4 5, 1 4, 0 0)), CIRCULARSTRING(1.7 1, 1.4 0.4, 1.6 0.4, 1.6 0.5, 1.7 1) )

POINT(c(2,3))

?st_inscribed_circle()


nc %>% ggplot() +
  geom_sf()

inx_dxf <- tempfile("inx", fileext = c(".dxf"))
nc %>%
  sf::st_geometry() %>%
  sf::st_write(dsn = inx_dxf, driver ="DXF", delete_dsn = TRUE)
inx_svg <- inx_dxf %>% inx_extension(inkscape_extension_name = "dxf_input.py", ext = ".svg") %>%
  inx_actions(actions = 'export-area-drawing', ext = ".svg")
inx_svg  %>% inx_source()
inx_svg %>%
  inx_actions(actions = NA, ext = ".png") %>%
  png::readPNG() %>%
  grid::grid.raster()

nc_t = st_transform(nc, 'EPSG:2264')
x = st_inscribed_circle(st_geometry(nc_t))


# -------------------------------------------------------------



inx_svg
output <- tempfile("inx_", fileext = c(".xml"))
inx_svg %>% readLines(warn = FALSE) %>% writeLines(output)
yy <- XML::xmlParse(output)
yy
xx <-XML::xmlTreeParse(output)
xx

inx_svg
xml <- xml2::read_xml(inx_svg)
xml <- xml2::xml_ns_strip(xml)
svg <- xml2::xml_find_first(xml, "//svg")

?xml2::xml_path()

/svg/g/path[2]

xml2::xml_path(xml2::xml_find_all(xml, ".//path"))


XML::xpathSApply(doc = yy, path ="//doc")
?XML::xpathSApply

xx$doc$file
xx$doc$children$svg

XML::xmlValue(doc$doc)

XML::xpathApply(doc, "//path")

xmlValue([[1]])


invisible(replaceNodes(doc[["//sequence/text()"]], newXMLTextNode( newSeq)))
doc
