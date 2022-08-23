#' Title
#'
#' @param input svg
#' @param actions actions from list
#' @param ext file output extension
#'
#' @return file for convertion
#' @export
#'
#' @examples
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
