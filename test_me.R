library(tidyverse)
library(sf)
"https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/w3c.svg" %>%
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


df = inx_actions_list()





