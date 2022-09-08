#' Title
#'
#' @param input Path or url of the SVG input file.
#'
#' @return PNG file.
#' @export
#'
#' @examples
#' library(ggplot2)
#' "https://upload.wikimedia.org/wikipedia/commons/3/30/Den_Haag_wapen.svg" %>%
#'   inx_svg2png() %>%
#'   png::readPNG(native = TRUE) %>%
#'   grid::rasterGrob(interpolate=TRUE) %>% {
#'     ggplot() +
#'       annotation_custom(., xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=Inf)}
inx_svg2png <- function(input){
  input %>% inx_actions(actions = NA, ext = ".png")
}

