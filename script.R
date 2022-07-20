library(tidyverse)
library(sf)

Sys.info()['sysname']  == "Windows"

# ------------------------------------
# svg <-> sf
logo <- inx_extension(input = "Red_Bird.svg", inkscape_extension_name = "dxf12_outlines.py", ext =".dxf") %>%
  st_read()

logo <- inx_extension(input = 'https://upload.wikimedia.org/wikipedia/commons/1/1b/Red_Bird.svg', inkscape_extension_name = "dxf12_outlines.py", ext =".dxf") %>%
  st_read()
logo %>% ggplot() +
  geom_sf()

# ------------------------------------
# sf <-> svg
filename <- system.file("shape/nc.shp", package="sf")
nc <- st_read(filename)
nc %>% ggplot() +
  geom_sf()

inx_dxf <- tempfile("inx", fileext = c(".dxf"))
nc %>%
  sf::st_geometry() %>%
  sf::st_write(dsn = inx_dxf, driver ="DXF", delete_dsn = TRUE)
inx_svg <- inx_dxf %>% inx_extension_win(inkscape_extension_name = "dxf_input.py", ext = ".svg")
inx_svg  %>% inx_source()

browseURL(inx_svg)

tmp <- inx_extension(input = 'C:/Users/Jacek Pardyak/AppData/Local/Temp/RtmpkPsect/inx29602d856acc.svg', inkscape_extension_name = "dxf12_outlines.py", ext =".dxf") %>%
  st_read()
tmp %>% ggplot() +
  geom_sf()

# ????

inx_extension(input = 'https://upload.wikimedia.org/wikipedia/commons/1/1b/Red_Bird.svg', inkscape_extension_name = "generate_voronoi.py")
