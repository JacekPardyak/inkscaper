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
#' grid::grid.newpage()
#' input %>% inx_actions(actions = NA, ext = ".png") %>%
#' png::readPNG() %>%
#' grid::grid.raster()
#' grid::grid.newpage()
#' input %>% inx_actions(actions = "select-by-id:MyStar;object-flip-vertical", ext = ".png") %>%
#' png::readPNG() %>%
#' grid::grid.raster()

inx_actions <- function(input, actions, ext){
   if(is_url(input)) {
      input_file_path = download_svg(input)
    } else {
      input_file_path = tempfile("inx_")
      file.copy(input, input_file_path)
    }
  output = tempfile("inx_", fileext = ext)
  actions <- ifelse(is.na(actions),
                    "export-filename:%s;export-do",
                    paste(actions, "export-filename:%s;export-do", sep = ";")
  )
  actions = sprintf(actions, output)
  fmt = 'inkscape --batch-process --actions="%s" %s'
  command <- sprintf(fmt, actions, input_file_path)
  system(command, intern = TRUE)
  output
}

