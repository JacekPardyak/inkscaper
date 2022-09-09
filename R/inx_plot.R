#' Function to send plot produced with `ggplot()` to Inkscape window.
#' Works only on Desktop.
#'
#' @param plot produced with `ggplot()`
#'
#' @return NULL
#' @export
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#' {ggplot(iris,
#' aes(x = Petal.Length,
#'     y = Petal.Width,
#'     colour = Sepal.Length,
#'     shape = Species)) +
#'     geom_point()} %>%
#' inx_plot()
#' }
inx_plot <- function(plot){
  input <- tempfile(pattern = "inx_", fileext = ".svg")
  ggsave(filename = input , plot = plot)
  fmt = 'inkscape --with-gui --actions="file-open-window:"%s"'
  command = sprintf(fmt, input)
  system(command, intern = T)
}
