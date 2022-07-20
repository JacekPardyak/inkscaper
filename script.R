library(tidyverse)
library(sf)

Sys.info()['sysname']  == "Windows"

# ------------------------------------
# svg <-> sf
logo <- inx_extension_win(input = "Red_Bird.svg", inkscape_extension_name = "dxf12_outlines.py") %>%
  st_read()

logo <- inx_extension_win(input = 'https://upload.wikimedia.org/wikipedia/commons/1/1b/Red_Bird.svg', inkscape_extension_name = "dxf12_outlines.py") %>%
  st_read()


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
inx_svg <- inx_dxf %>% inx_extension_win(inkscape_extension_name = "dxf_input.py")
inx_svg  %>% inx_source()


# ????

