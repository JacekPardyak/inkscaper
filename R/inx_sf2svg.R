#' Title
#'
#' @param geom simple features
#'
#' @return file name
#' @export
#'
#' @examples
#' library(sf)
#' filename <- system.file("shape/nc.shp", package="sf")
#' nc <- st_read(filename)
#' inx_sf2svg(nc)
inx_sf2svg <- function(geom){
  inx_dxf <- tempfile("inx_", fileext = c(".dxf"))
  geom %>%
  sf::st_geometry() %>%
  sf::st_write(dsn = inx_dxf, driver ="DXF") #, delete_dsn = TRUE
  inx_svg <- inx_dxf %>% inx_extension(inkscape_extension_name = "dxf_input.py", ext = ".svg") %>%
  inx_actions(actions = 'export-area-drawing', ext = ".svg")
}


