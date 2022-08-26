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
inx_actions(actions = "", ext = ".png") %>%
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
input %>% inx_actions(actions = "select-by-id:MyStar;object-flip-vertical", ext = ".png") %>%
  png::readPNG() %>%
  grid::grid.raster()

# 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
#install.packages(
#system("sudo add-apt-repository universe")
#system("sudo add-apt-repository ppa:inkscape.dev/stable")
#system("sudo apt update")
#system("sudo apt install inkscape")
system("inkscape --version", intern = TRUE)

<<<<<<< HEAD
=======
if(!(require(sf))){
  system('apt-get -y update && apt-get install -y  libudunits2-dev libgdal-dev libgeos-dev libproj-dev')
  system('sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable')
  system('sudo apt-get update')
  system('sudo apt-get install libudunits2-dev libgdal-dev libgeos-dev libproj-dev')
  #library(remotes)
  #install_github("r-spatial/sf")
  install.packages('sf')
}
>>>>>>> bdcbfee60751cf0ba1d88931cc5dd82643a82fb4
