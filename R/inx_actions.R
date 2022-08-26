#' Title
#'
#' @param input svg
#' @param actions actions from list
#' @param ext file output extension
#'
#' @return file for conversion
#' @export
#'
#' @examples
#' input = system.file("extdata", "MyStar.svg", package = "inkscaper", mustWork = TRUE)
#' inx_actions(input = input, actions = "select-by-id:MyStar;object-flip-vertical", ext = ".png")

inx_actions <- function(input, actions, ext){
   if(is_url(input)) {
      input_file_path = download_svg(input)
    } else {
      input_file_path = tempfile("inx_")
      file.copy(input, input_file_path)
    }
  output = tempfile("inx_", fileext = ext)
  actions = paste(actions, "export-filename:%s;export-do;", sep = ";")
  actions = sprintf(actions, output)
  fmt = 'inkscape --batch-process --actions="%s" %s'
  command <- sprintf(fmt, actions, input_file_path)
  system(command, intern = TRUE)
  output
}
# inx_verbs(input = "MyStar.svg", actions = "select-by-id:MyStar;ObjectFlipVertically;", ext = ".svg") %>% svg_to_dxf() %>% st_read() %>% ggplot() + geom_sf()
# library(tidyverse)
# library(sf)
#
# inx_verbs(input = input, actions = "", ext = ".png") %>%
# png::readPNG() %>%
# grid::grid.raster()
