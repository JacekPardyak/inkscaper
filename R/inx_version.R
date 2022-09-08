#' Write the file in your working directory
#'
#' @return Logical
#' @export
#'
#' @examples
#' inx_version()
inx_version <- function() {
  system('inkscape --version', intern = TRUE)
}

