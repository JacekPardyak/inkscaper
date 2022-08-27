library(tidyverse)
library(sf)





"align_me.svg" %>%
inx_actions(actions = NA, ext = ".png") %>%
  png::readPNG() %>%
  grid::grid.raster()

"align_me.svg" %>%
  inx_actions(actions =  "select-by-id:rectangle1,rectangle2;object-align:left | top", ext = ".png") %>%
  png::readPNG() %>%
  grid::grid.raster()

"align_me.svg" %>%
  inx_actions(actions = "select-by-id:rectangle2,rectangle1;object-align:right | bottom", ext = ".png") %>%
  png::readPNG() %>%
  grid::grid.raster()

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
df <- tibble(t = seq(0, 2*pi, 0.1)) %>%
  mutate( x = 16*sin(t)^3 ) %>%
  mutate( y = 13*cos(t)-5*cos(2*t)-2*cos(3*t)-cos(4*t))

df <- df %>% bind_rows(df %>% slice(1)) %>% select(x, y) %>% as.matrix() %>% list() %>%
  st_polygon() %>% st_sfc()
df
df %>% ggplot() +
  geom_sf()
output = tempfile("inx_", fileext = ".dxf")
df %>% st_write(output, driver = "DXF")
inx_extension(output, inkscape_extension_name = "dxf_input.py", ext = ".svg")
