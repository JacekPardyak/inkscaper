# R wrapper for Inkscape

The [inkscaper](https://github.com/JacekPardyak/inkscaper) package provide a modern and simple toolkit for Scalable Vector Graphics (SVG) processing in R. It wraps the [Inkscape](https://inkscape.org/) which is a Free and open source vector graphics editor for GNU/Linux, Windows and macOS.

## Installing `inkscape`

To install Inkscape on your platform follow the instruction available at: [https://inkscape.org/](https://inkscape.org/) 

## Installing `inkscaper` R package

```{r}
library(devtools)
install_github("JacekPardyak/inkscaper")
library(inkscaper)
library(tidyverse)
library(sf)
```

## SVG to PNG

The original SVG rendered by the browser as:

![](https://upload.wikimedia.org/wikipedia/commons/3/30/Den_Haag_wapen.svg)

can be exported to PNG with Inkscape:

```{r}
img = "https://upload.wikimedia.org/wikipedia/commons/3/30/Den_Haag_wapen.svg" %>%
  inx_actions(actions = NA, ext = ".png") %>%
  png::readPNG(native = TRUE) %>%
  grid::rasterGrob(interpolate=TRUE)
ggplot() +
  annotation_custom(img, xmin=-Inf, xmax=Inf, ymin=-Inf, ymax=Inf)
ggsave("man/figures/Den_Haag_wapen.png")
```

## SVG to Simple Features

The same SVG can be converted to Simple Features supported by the `sf` package:

```{r}
svg_sf <- "https://upload.wikimedia.org/wikipedia/commons/3/30/Den_Haag_wapen.svg" %>%
  inx_svg2sf()
svg_sf
svg_sf %>%
  ggplot() +
  geom_sf()
```
