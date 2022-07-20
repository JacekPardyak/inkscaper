library(tidyverse)
library(sf)

inkscape_python_home = "C:\\Program Files\\Inkscape\\bin\\"
inkscape_extension_path = "C:\\Program Files\\Inkscape\\share\\inkscape\\extensions\\dxf12_outlines.py"
input_file_path = "C:\\Users\\jacek\\inkscaper\\Red_Bird.svg"
output_file_path = "C:\\Users\\jacek\\inkscaper\\Red_Bird.dxf"
script_file = tempfile(pattern = "inx_", fileext = ".bat")

script <- '@ECHO OFF
cd %s
python.exe "%s" --output="%s"  "%s"'

script %>% sprintf(
        inkscape_python_home,
        inkscape_extension_path,
        output_file_path,
        input_file_path
        ) %>% writeLines(script_file)

system(script_file)


logo <- st_read("./Red_Bird.dxf")

logo %>% ggplot() +
  geom_sf()

Sys.info()['sysname']


#library(svgtools)
fpath <- system.file("extdata", "fig11.svg", package="svgtools")
svg <- svgtools::read_svg(file = fpath)
bitmap <- rsvg::rsvg(svg = 'Red_Bird.svg', width = 500)
magick::image_read(bitmap)
webp::write_webp(bitmap, "bitmap.webp", quality = 100)


# -------------------------------------------------------

png::readPNG()

inx_export_linux <- function(input, format) {
  if(tolower(format) == 'dxf'){
    output <- tempfile("inx", fileext = c(".dxf"))
    command <- sprintf('python /usr/share/inkscape/extensions/dxf12_outlines.py --output="%s" "%s"', output, input)
    system(command, intern = TRUE)
    output
  } else {
    if(tolower(format) == 'png'){
      output <- tempfile("inx", fileext = c(".png"))
      command <- sprintf('inkscape --without-gui --actions="export-filename:%s; export-do" %s', output, input)
      system(command, intern = TRUE)
      output
    } else {
      print('')
    }
  }
}

inx_export_windows <- function(input, format) {
  if(tolower(format) == 'dxf'){
    output <- tempfile("inx", fileext = c(".dxf"))
    command <- sprintf('python /usr/share/inkscape/extensions/dxf12_outlines.py --output="%s" "%s"', output, input)
    system(command, intern = TRUE)
    output
  } else {
    if(tolower(format) == 'png'){
      output <- tempfile("inx", fileext = c(".png"))
      command <- sprintf('inkscape --without-gui --actions="export-filename:%s; export-do" %s', output, input)
      system(command, intern = TRUE)
      output
    } else {
      print('')
    }
  }
}

library(dplyr)

# export to dxf

inx_extension <- function(input, inkscape_extension_name){
  input_file_path = paste(normalizePath(getwd()), input, sep = "\\")
  output_file_path = tempfile("inx", fileext = c(".dxf"))
  command = tempfile(pattern = "inx_", fileext = ".bat")
'@ECHO OFF
cd %s
python.exe "%s" --output="%s"  "%s"' %>% sprintf(
    Sys.getenv("inkscape_python_home"),
    paste(Sys.getenv("inkscape_extensions_path"), inkscape_extension_name, sep = "\\"),
    output_file_path,
    input_file_path
  ) %>% writeLines(command)

  system(command)
  output_file_path
}


logo <- inx_extension(input = "Red_Bird.svg", inkscape_extension_name = "dxf12_outlines.py") %>%
  st_read()

logo %>% ggplot() +
  geom_sf()

inx_action <- function(input, action){
  #input = "Red_Bird.svg"
  #action <- "export-filename"
  output <- tempfile("inx", fileext = c(".png"))

  command <- sprintf('inkscape --actions="%s:%s; export-do" %s', action, output, input)
  system(command, intern = TRUE)
  output
}

"Red_Bird.svg" %>% inx_action(action <- "export-filename") %>% magick::image_read()



# https://wiki.inkscape.org/wiki/Installing_Inkscape
#inx_install <- function(os){
#  if(Sys.info()['sysname']  == "Linux"){
#    system('sudo add-apt-repository universe')
#    system('sudo add-apt-repository ppa:inkscape.dev/stable')
#    system('sudo apt-get update')
#    system('sudo apt install inkscape')
#  }


}

# export to png

input <- "Red_Bird.svg"
output <- tempfile("inx", fileext = c(".png"))
command <- sprintf('inkscape --actions="export-filename:%s; export-do" %s', output, input)
system(command, intern = TRUE)
output
magick::image_read(output)

bitmap <- rsvg::rsvg(svg = input, width = 500)
magick::image_read(bitmap)


Sys.info()['sysname']  == "Windows"



unname(s) == unname(s)
class(s)
#== list(sysname)

is_windows <- function(){
  identical(.Platform$OS.type, 'windows')
}

is_windows()

.Platform$OS.type

#https://github.com/ropensci/magick/blob/master/R/utils.R
