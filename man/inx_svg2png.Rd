% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/inx_svg2png.R
\name{inx_svg2png}
\alias{inx_svg2png}
\title{Title}
\usage{
inx_svg2png(input)
}
\arguments{
\item{input}{Path or url of the SVG input file.}
}
\value{
PNG file.
}
\description{
Title
}
\examples{
library(ggplot2)
"https://upload.wikimedia.org/wikipedia/commons/3/30/Den_Haag_wapen.svg" \%>\%
  inx_svg2png() \%>\%
  png::readPNG(native = TRUE) \%>\%
  grid::rasterGrob(interpolate=TRUE) \%>\% {
    ggplot() +
      annotation_custom(., xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=Inf)}
}
