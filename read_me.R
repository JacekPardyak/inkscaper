library(tidyverse)
library(sf)
devtools::install_github("JacekPardyak/inkscaper")
library(inkscaper)

img = "https://upload.wikimedia.org/wikipedia/commons/3/30/Den_Haag_wapen.svg" %>%
  inx_actions(actions = NA, ext = ".png") %>%
  png::readPNG(native = TRUE) %>%
  grid::rasterGrob(interpolate=TRUE)
ggplot() +
  annotation_custom(img, xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=Inf)
ggsave("man/figures/Den_Haag_wapen.png")


svg_sf <- "https://upload.wikimedia.org/wikipedia/commons/3/30/Den_Haag_wapen.svg" %>%
  inx_svg2sf()
svg_sf

svg_sf %>%
  ggplot() +
  geom_sf()
ggsave("man/figures/Den_Haag_wapen_sf.png")


"https://geodata.nationaalgeoregister.nl/cbsgebiedsindelingen/wfs?request=GetFeature&service=WFS&version=2.0.0&typeName=cbs_gemeente_2022_gegeneraliseerd&outputFormat=json" %>%
  st_read() %>%
  filter(statnaam == "'s-Gravenhage") %>%
  st_transform(., st_crs("EPSG:4326")) %>% # change CRS to WGS 84
  inx_sf2svg() %>% # export to SVG
  inx_actions(actions = "select-all;transform-scale:1000", ext = ".svg") %>%
  inx_actions(actions = 'export-area-drawing', ext = ".svg") %>%
  inx_write("man/figures/Den_Haag_fill.svg")

"man/figures/Den_Haag_fill.svg" %>%
  inx_actions(actions = NA, ext = ".png") %>%
  png::readPNG(native = TRUE) %>%
  grid::rasterGrob(interpolate=TRUE) -> img
ggplot() +
  annotation_custom(img, xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=Inf)

"man/figures/Den_Haag_fill.svg" %>%
  inx_style(id = "path18", style = "fill:#FFFFFF;stroke:#000000;stroke-width:1") %>%
  inx_write("man/figures/Den_Haag_stroke.svg")

