# R wrapper for Inkscape

The [inkscaper](https://github.com/JacekPardyak/inkscaper) package provide a modern and simple toolkit for Scalable Vector Graphics (SVG) processing in R. It wraps the [Inkscape](https://inkscape.org/) which is a Free and open source vector graphics editor for GNU/Linux, Windows and macOS.

## Installing `inkscape`

To install Inkscape on your platform follow the instruction available at: [https://inkscape.org/](https://inkscape.org/) 

## Installing `inkscaper` R package

```{r}
library(devtools)
install_github("JacekPardyak/inkscaper")
library(inkscaper)
```

## Primary packages

```{r}
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

![](man/figures/Den_Haag_wapen.png)

## SVG to Simple Features

The same SVG can be converted to Simple Features supported by the `sf` package:

```{r}
svg_sf <- "https://upload.wikimedia.org/wikipedia/commons/3/30/Den_Haag_wapen.svg" %>%
  inx_svg2sf()
svg_sf
```
```
Simple feature collection with 17930 features and 6 fields
Geometry type: LINESTRING
Dimension:     XY
Bounding box:  xmin: 0.163338 ymin: 0.117232 xmax: 239.0348 ymax: 152.7147
CRS:           NA
First 10 features:
     Layer PaperSpace SubClasses Linetype EntityHandle Text                       geometry
1  Layer 1         NA       <NA>     <NA>         <NA> <NA> LINESTRING (120.204 23.7929...
2  Layer 1         NA       <NA>     <NA>         <NA> <NA> LINESTRING (62.2936 23.5891...
3  Layer 1         NA       <NA>     <NA>         <NA> <NA> LINESTRING (62.07911 16.457...
4  Layer 1         NA       <NA>     <NA>         <NA> <NA> LINESTRING (36.55571 16.559...
5  Layer 1         NA       <NA>     <NA>         <NA> <NA> LINESTRING (36.87745 22.366...
6  Layer 1         NA       <NA>     <NA>         <NA> <NA> LINESTRING (36.9547 23.1356...
7  Layer 1         NA       <NA>     <NA>         <NA> <NA> LINESTRING (36.6928 23.4590...
8  Layer 1         NA       <NA>     <NA>         <NA> <NA> LINESTRING (35.69779 23.589...
9  Layer 1         NA       <NA>     <NA>         <NA> <NA> LINESTRING (12.7476 23.5892...
10 Layer 1         NA       <NA>     <NA>         <NA> <NA> LINESTRING (9.015017 23.486...
```

```{r}
svg_sf %>%
  ggplot() +
  geom_sf()
ggsave("man/figures/Den_Haag_wapen_sf.png")  
```

![](man/figures/Den_Haag_wapen_sf.png)


## Simple Features to SVG

Simple Features geometry can be converted to SVG:

```{r}
"https://geodata.nationaalgeoregister.nl/cbsgebiedsindelingen/wfs?request=GetFeature&service=WFS&version=2.0.0&typeName=cbs_gemeente_2022_gegeneraliseerd&outputFormat=json" %>%
  st_read() %>%
  filter(statnaam == "'s-Gravenhage") %>%
  st_transform(., st_crs("EPSG:4326")) %>% # change CRS to WGS 84
  inx_sf2svg() %>% # export to SVG
  inx_actions(actions = "select-all;transform-scale:1000", ext = ".svg") %>%
  inx_actions(actions = 'export-area-drawing', ext = ".svg") %>%
  inx_write("man/figures/Den_Haag_fill.svg")  
```

![](man/figures/Den_Haag_fill.svg)

and the SVG further modified:

```{r}
"man/figures/Den_Haag_fill.svg" %>%
  inx_style(id = "path18", style = "fill:#FFFFFF;stroke:#000000;stroke-width:1") %>%
  inx_write("man/figures/Den_Haag_stroke.svg")
```

![](man/figures/Den_Haag_stroke.svg)

## Closing

This is the first version of the package. If you have a comment, request or bug report, don't hesitate.

The popup is something normal and needed by Inkscape, and it can hang at times (just kill the child process and continue).

On non-GUI systems some Inkscape actions will not work, period.

I'm testing on Windows 10 and Ubuntu 22.04 Inkscape 1.2.1.

Work on vignettes is still ongoing, but they are already available in the `vignettes`.

