#' ASCII art
#'
#' @param image The path of the file to be processed
#' @param chars Character
#' @return Character
#' @export
#'
#' @examples
#' system.file("extdata", "R_logo.svg", package = "inkscaper") %>%
#' inx_svg2png() %>% magick::image_read() %>% image_ascii() %>% print()
image_ascii <- function(image, chars = c("B", "S", "#", "&", "@", "\u20AC", "%", "*", "!", ":", ".")) {
  new_width = 100
  scale = 0.5
  image %>%
    magick::image_resize(., magick::geometry_size_pixels(new_width, as.integer(magick::image_info(.)$height / magick::image_info(.)$width * new_width * scale), preserve_aspect = FALSE)) %>%
    magick::image_convert(., type = 'grayscale') %>% magick::image_data() %>% as.integer() %>% {. %/% 25} %>%
    {. + 1} %>% sapply(., function(x) {chars[x]}) %>%
    matrix(., ncol = new_width) %>%
    apply(., 1, function(x) paste(x, collapse = ""))
}
