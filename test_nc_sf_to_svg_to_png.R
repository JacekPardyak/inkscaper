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
