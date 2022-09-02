library(tidyverse)
library(sf)
devtools::install_github("JacekPardyak/inkscaper")
library(inkscaper)

# SVG text to SVG path

"man/figures/Den_Haag_text.svg" %>% xml2::read_xml()

"man/figures/Den_Haag_text.svg" %>%
  inx_actions(actions = "select-all;export-text-to-path", ext = ".svg") %>%
  xml2::read_xml()

"man/figures/Den_Haag_text.svg" %>%
  inx_actions(actions = "select-all;export-text-to-path", ext = ".svg") %>%
  inx_write("man/figures/Den_Haag_path.svg")

# we can parse the output SVG:

"man/figures/Den_Haag_path.svg" %>% xml2::read_xml()

# to be completely sure we can traverse the XML tree up to the first path
doc = "man/figures/Den_Haag_path.svg" %>% xml2::read_xml()
paths = xml2::xml_path(xml2::xml_find_all(doc, "//*[name()='path']"))
xml2::xml_find_all(doc, paths[[1]])

#

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

# GIF animation from SVG
library(gganimate)
size = 2000
svg_sf <- "https://upload.wikimedia.org/wikipedia/commons/4/44/Haags_logo.svg" %>%
  inx_svg2sf() %>% st_union() %>% st_polygonize() %>% first()
pos <- svg_sf %>% st_sample(size) %>% st_union() %>%
  st_sfc() %>% st_sf() %>% mutate(states = 1)
neg <- svg_sf %>% st_bbox() %>% st_as_sfc() %>%
  st_difference(svg_sf) %>% st_sample(size) %>%
  st_union() %>% st_sfc() %>% st_sf() %>% mutate(states = 2)
anim <- pos %>%
  bind_rows(neg) %>%
  ggplot() +
  geom_sf() +
  transition_states(states) +
  theme_void()
animate(anim)
anim_save("man/figures/Den_Haag_animated.gif")

# RGL surface from SVG

library(rgl)

result <- "https://upload.wikimedia.org/wikipedia/commons/4/44/Haags_logo.svg" %>%
  inx_svg2sf() %>% st_union() %>%
  st_polygonize() %>% st_sfc() %>% st_sf()
grid_spacing = .1
grid <- result %>% st_make_grid(what = "centers", cellsize = c(grid_spacing, grid_spacing)) %>%
  st_sf()
heights <- st_join(grid, (result %>% select(geometry) %>% mutate(Z = 5))) %>% replace(is.na(.), 0)
z <- heights %>% st_coordinates() %>% as_tibble() %>%
  bind_cols(heights %>% st_drop_geometry()) %>%
  mutate(X = round(X,1)) %>%
  mutate(Y = round(Y,1)) %>% pivot_wider(names_from = Y, values_from = Z) %>%
  column_to_rownames("X") %>% as.matrix()
x <- 1:nrow(z)
y <- 1:ncol(z)

colors <- c("#FFFFFF", NA, NA, NA, NA, "#00555a") #"#ECB176",
color <- colors[ z - min(z) + 1 ] # assign colors to heights for each point
#color = col
surface3d(x, y, z, color, back = "lines")

htmlwidgets::saveWidget(rglwidget(width = 520, height = 520),
                        file = "man/figures/Den_Haag_surface.html",
                        libdir = "libsR",
                        selfcontained = TRUE)
rgl.viewpoint(-20, -20)
rgl.snapshot("man/figures/Den_Haag_surface.png")

