library(tidyverse)
library(sf)
library(inkscaper)



input = system.file("extdata", "MyStar.svg", package = "inkscaper", mustWork = TRUE)
input %>% inx_actions(actions = NA, ext = ".png")# %>%
  png::readPNG() %>%
  grid::grid.raster()
input %>% inx_actions(actions = "select-by-id:MyStar;object-flip-vertical", ext = ".png") %>%
  png::readPNG() %>%
  grid::grid.raster()


input = system.file("extdata", "MyStar.svg", package = "inkscaper", mustWork = TRUE)
grid::grid.newpage()
input %>% inx_actions(actions = NA, ext = ".png") %>%
  png::readPNG() %>%
  grid::grid.raster()
grid::grid.newpage()
input %>% inx_actions(actions = "select-by-id:MyStar;object-flip-vertical", ext = ".png") %>%
  png::readPNG() %>%
  grid::grid.raster()


# ciekawe
# https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/eee.svg
# https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/decimal.svg


"https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/gallardo.svg" %>%
  inx_actions(actions = NA, ext = ".png") %>%
  png::readPNG() %>%
  grid::grid.raster()

"https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/gallardo.svg" %>%
  inx_actions(actions = "select-by-id:layer3,layer6;object-align:right | bottom", ext = ".png") %>%
  png::readPNG() %>%
  grid::grid.raster()


# cool but useless

"https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/heart.svg" %>%
  inx_actions(actions = NA, ext = ".png") %>%
  png::readPNG() %>%
  grid::grid.raster()

# actions

df <- system.file("extdata", "actions.csv", package = "inkscaper") %>%
  readr::read_csv()
df
input_file_path = system.file("extdata", "MyStar.svg", package = "inkscaper")
actions <- "export-do" #df$Action[1067]
actions <- "file-new" #df$Action[1067]

fmt = 'inkscape --batch-process --actions="%s" %s'
command <- sprintf(fmt, actions, input_file_path)
system(command, intern = TRUE)

system('inkscape --help-gapplication')

system('inkscape --shell --actions="about"')

system('inkscape --batch-process --actions="debug-info"', intern = FALSE)
system('inkscape --batch-process --actions="debug-info"', intern = TRUE)
system('inkscape --shell --actions="debug-info"', intern = F)
