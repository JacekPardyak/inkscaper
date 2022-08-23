library(dplyr)
library(sf)
"https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/w3c.svg" %>%
svg_to_dxf() %>%
  st_read() %>% ggplot() +
    geom_sf()

"https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/italian-flag.svg" %>%
  svg_to_dxf() %>%
  st_read() %>% ggplot() +
  geom_sf()

"https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/italian-flag.svg" %>%
inx_actions(actions = list('select-all', 'object-to-path'),
            ext = ".svg") %>%
  svg_to_dxf() %>%
  st_read() %>% ggplot() +
  geom_sf()


system('inkscape --action-list > actions.txt', intern = TRUE)
actions <- readLines('actions.txt')
for(action in actions){
  print(action)
}

output <- tempfile("inx_", fileext = ".txt")
command <- paste('inkscape --actions="', paste(actions, collapse = "; "), '; export-filename:%s; export-do" %s', sep = "")
command <- sprintf(command, output, input_file_path)
system(command, intern = TRUE)
