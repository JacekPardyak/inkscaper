library(tidyverse)
library(sf)
system('inkscape --version', intern = TRUE)
# > "Inkscape 1.1.1 (3bf5ae0d25, 2021-09-20)"
# w starszych wersjach inkscape gorzej

library(inkscaper)
url <- 'https://upload.wikimedia.org/wikipedia/commons/e/ef/Station_Clock.svg'
logo <- inx_extension(input = url, inkscape_extension_name = "dxf12_outlines.py", ext =".dxf") %>%
  st_read()
logo %>% ggplot() +
  geom_sf()


library(rsvg)
library(grid)


"./test/Station_Clock.svg" %>%
  rsvg() %>%
  grid.raster()


url <- 'test/Station_Clock_Paths.svg'
logo <- inx_extension(input = url, inkscape_extension_name = "dxf12_outlines.py", ext =".dxf") %>%
  st_read()
logo %>% ggplot() +
  geom_sf()


collection <- logo %>%
  select(geometry) %>% st_union() %>% st_polygonize() %>%
  first() #%>%

collection %>% ggplot() +
  geom_sf()

result <- st_sfc() %>% st_sf(geometry = .)
for (i in c(1:length(collection))) {
  row = collection %>% nth(i) %>%
    st_sfc()  %>% st_sf(geometry = .) %>% mutate(facet = i)
  result <- row %>% bind_rows(result)
}


result %>% ggplot() +
  geom_sf() +
  geom_sf_label(aes(label = facet))

result %>% filter(!facet %in% c(2, 3, 4, 6, 8, 9, 12, 14, 15, 16, 17, 18, 19, 20, 21, 24)) %>% ggplot() +
  geom_sf() +
  geom_sf_label(aes(label = facet)) +
  theme_void()


url <- 'https://media.inkscape.org/media/resources/file/inkscape-flat-logo-2color-text.svg'
logo <- inx_extension(input = url, inkscape_extension_name = "dxf12_outlines.py", ext =".dxf") %>%
  st_read()
logo %>% ggplot() +
  geom_sf()

# baba na rurze
url <- 'https://upload.wikimedia.org/wikipedia/commons/6/66/Silhouette_of_Stripper_on_a_Pole.svg'
logo <- inx_extension(input = url, inkscape_extension_name = "dxf12_outlines.py", ext =".dxf") %>%
  st_read()
logo %>% ggplot() +
  geom_sf()

url <- './test/Silhouette_of_Stripper_on_a_Pole.svg'
logo <- inx_extension(input = url, inkscape_extension_name = "dxf12_outlines.py", ext =".dxf") %>%
  st_read()
logo %>% ggplot() +
  geom_sf()

library(plotly)
logo <- logo %>% mutate(EntityHandle = row_number())
fig <- plot_ly(logo)

fig


logo <- logo %>%
  select(geometry)

tmp <- logo %>% slice(1:128) %>%
  select(geometry) %>% st_union() %>% st_polygonize() %>%
  first() %>%
  first() %>% st_sfc()  %>% st_sf(geometry = .)

tmp %>% ggplot() +
  geom_sf()


tmp <- logo %>% slice(129:220) %>%
  select(geometry) %>% st_union() %>% st_polygonize() %>%
  first() %>%
  first() %>% st_sfc()  %>% st_sf(geometry = .)
