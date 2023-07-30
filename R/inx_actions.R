#' Run Inkscape actions
#'
#' @param input Path or url of the SVG input file.
#' @param actions vector of actions to be performed. Check vignetes for details.
#' @param ext file format of the output (ex. ".svg", ".png", ...)
#'
#' @return path of the outcome
#' @export
#'
#' @examples
#' library(ggplot2)
#' system.file("extdata", "Den_Haag_wapen.svg", package = "inkscaper") %>%
#' inx_actions(actions = NA, ext = ".png") %>%
#' png::readPNG(native = TRUE) %>%
#' grid::rasterGrob(interpolate=TRUE) -> img
#' ggplot() +
#' annotation_custom(img, xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=Inf)


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

