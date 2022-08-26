library(tidyverse)
library(sf)
"https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/w3c.svg" %>%
svg_to_dxf() %>%
  st_read() %>% ggplot() +
    geom_sf()

"https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/w3c.svg" %>%
inx_verbs(actions = "EditSelectAll;ObjectFlipVertically;", ext = ".svg") %>%
  svg_to_dxf() %>%
  st_read() %>% ggplot() +
  geom_sf()

"https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/italian-flag.svg" %>%
  svg_to_dxf() %>%
  st_read() %>% ggplot() +
  geom_sf()

"https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/italian-flag.svg" %>%
inx_actions(actions = list('select-all', 'object-to-path'),
            ext = ".svg") %>%
  svg_to_dxf() %>%
  st_read() %>% ggplot() +
  geom_sf()


verbs = inx_verbs_list()
verbs$GUI = NA
verbs$WARNING = NA

command_1 <- 'inkscape --batch-process --actions="select-by-id:rectangle1,rectangle2;object-align:left;export-filename:aligned_rect1.png;export-do" align_me.svg'
#command_2 <- 'inkscape --batch-process --actions="select-by-id:rectangle2,rectangle1;AlignBothBottomLeft;export-filename:aligned_rect2.png;export-do;" align_me.svg'
#command_3 <- 'inkscape --batch-process --actions="select-by-id:rectangle2,rectangle1;FileNew;export-filename:aligned_rect2.png;export-do;" align_me.svg'

system(command_1, intern = T)
system(command_2, intern = T)
system(command_3, intern = T)

command_2 <- 'inkscape --batch-process --actions="select-by-id:MyStar;AlignBothBottomLeft;export-filename:aligned_start2.png;export-do;" align_me.svg'

command_4 <- 'inkscape --batch-process --actions="select-by-id:MyStar;ObjectFlipVertically;export-filename:out2.svg;export-do;" MyStar.svg'
system(command_4, intern = TRUE)



inx_verbs(input = "align_me.svg", actions = "", ext = ".png") %>%
  png::readPNG() %>%
  grid::grid.raster()

inx_verbs(input = "align_me.svg", actions = "select-by-id:rectangle1,rectangle2;object-align:left | top", ext = ".png") %>%
  png::readPNG() %>%
  grid::grid.raster()

inx_verbs(input = "align_me.svg", actions = "select-by-id:rectangle2,rectangle1;object-align:right | bottom", ext = ".png") %>%
  png::readPNG() %>%
  grid::grid.raster()
