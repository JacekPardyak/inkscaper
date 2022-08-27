library(tidyverse)
library(sf)
"https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/w3c.svg" %>%
svg_to_dxf() %>%
  st_read() %>% ggplot() +
    geom_sf()

"https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/w3c.svg" %>%
inx_actions(actions = "select-all;object-flip-vertical", ext = ".svg") %>%
  svg_to_dxf() %>%
  st_read() %>% ggplot() +
  geom_sf()

"https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/italian-flag.svg" %>%
  svg_to_dxf() %>%
  st_read() %>% ggplot() +
  geom_sf()

"https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/italian-flag.svg" %>%
inx_actions(actions = "select-all;object-to-path", ext = ".svg") %>%
  svg_to_dxf() %>%
  st_read() %>% ggplot() +
  geom_sf()


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
input %>% inx_actions(actions = NA, ext = ".png") %>%
  png::readPNG() %>%
  grid::grid.raster()
input %>% inx_actions(actions = "select-by-id:MyStar;object-flip-vertical", ext = ".png") %>%
  png::readPNG() %>%
  grid::grid.raster()

