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
#' library(tidyverse)
#' library(sf)
#' # empty plot - attempt to convert SVG containing native {rect} objects
#' "https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/italian-flag.svg" %>%
#' svg_to_dxf() %>%
#' st_read() %>% ggplot() +
#'   geom_sf()
#' # right plot - attempt to convert SVG containing paths from native {rect} objects
#' "https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/italian-flag.svg" %>%
#' inx_actions(actions = list('select-all', 'object-to-path'), ext = ".svg") %>%
#' svg_to_dxf() %>%
#' st_read() %>% ggplot() +
#'   geom_sf()
inx_actions <- function(input, actions, ext) {
  if(is_url(input)) {
    input_file_path = download_svg(input)
  } else {
    input_file_path = tempfile("inx_")
    file.copy(input, input_file_path)
  }
  output <- tempfile("inx_", fileext = ext)
  command <- paste('inkscape --actions="', paste(actions, collapse = "; "), '; export-filename:%s; export-do" %s', sep = "")
  command <- sprintf(command, output, input_file_path)
  system(command, intern = TRUE)
  output
}
