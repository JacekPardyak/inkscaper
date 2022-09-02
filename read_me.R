library(tidyverse)
library(sf)
devtools::install_github("JacekPardyak/inkscaper")
library(inkscaper)
# Basic text

"man/figures/Den_Haag_text.svg" %>% xml2::read_xml()

"man/figures/Den_Haag_text.svg" %>%
  inx_actions(actions = "select-all;object-to-path", ext = ".svg") %>%
  xml2::read_xml()

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
  inx_svg2sf() %>% st_union() %>% st_sfc() %>% st_sf()

result %>% ggplot() +
  geom_sf()

grid_spacing = 10
grid <- result %>% st_make_grid(what = "centers", cellsize = c(grid_spacing, grid_spacing)) %>%
  st_sf()
```

```{r}
heights <- st_join(grid, (result %>% select(geometry) %>% mutate(Z = 1))) %>% replace(is.na(.), 0)
z <- heights %>% st_coordinates() %>% as_tibble() %>%
  bind_cols(heights %>% st_drop_geometry()) %>%
  mutate(X = round(X,1)) %>%
  mutate(Y = round(Y,1)) %>% pivot_wider(names_from = Y, values_from = Z) %>%
  column_to_rownames("X") %>% as.matrix()
```

```{r, test-rgl, webgl=TRUE}
x <- 1:nrow(z)
y <- 1:ncol(z)

colorlut <- c("#F2F2F2",  "#E34234") #"#ECB176",
col <- colorlut[ z - min(z) + 1 ] # assign colors to heights for each point

surface3d(x, y, z, color = col, back = "lines")

htmlwidgets::saveWidget(rglwidget(width = 520, height = 520),
                        file = "/tmp/surfaceR.html",
                        libdir = "libsR",
                        selfcontained = TRUE
)

