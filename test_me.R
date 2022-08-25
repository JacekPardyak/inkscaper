library(tidyverse)
library(sf)
"https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/w3c.svg" %>%
svg_to_dxf() %>%
  st_read() %>% ggplot() +
    geom_sf()

"https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/w3c.svg" %>%
  download_svg() %>%
inx_verbs(actions = "EditSelectAll;ObjectFlipVertically;", ext = ".svg") %>%
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


verbs = inx_verbs_list()
verbs$GUI = NA
verbs$WARNING = NA

# 1 - 657
# 650 -

for(i in c(650:nrow(verbs))){
#  i = 1
  verb = verbs$Verb[i]
  print(verb)
  output = tempfile("inx_", fileext = ".txt")
  con  = tempfile(pattern = "inx_", fileext = ".bat")
  fmt = '@ECHO OFF
inkscape --verb=%s > %s'
  text = sprintf(fmt, verb, output)
  writeLines(text, con)
  res <- system(con, intern = T)
  verbs$WARNING[i] = paste(res, collapse = "\n")
  verbs$GUI[i] = agrepl(pattern = "WARNING", x = ifelse(length(res) > 0, res[[1]], res), fixed=TRUE)
  }

verbs %>% write_csv("./inst/extdata/verbs1.csv")

command_1 <- 'inkscape --batch-process --actions="select-by-id:rectangle1,rectangle2;AlignBothBottomRight;export-filename:aligned_rect1.png;export-do;" align_me.svg'
command_2 <- 'inkscape --batch-process --actions="select-by-id:rectangle2,rectangle1;AlignBothBottomLeft;export-filename:aligned_rect2.png;export-do;" align_me.svg'
command_3 <- 'inkscape --batch-process --actions="select-by-id:rectangle2,rectangle1;FileNew;export-filename:aligned_rect2.png;export-do;" align_me.svg'

system(command_1, intern = T)
system(command_2, intern = T)
system(command_3, intern = T)

command_2 <- 'inkscape --batch-process --actions="select-by-id:MyStar;AlignBothBottomLeft;export-filename:aligned_start2.png;export-do;" align_me.svg'

command_4 <- 'inkscape --batch-process --actions="select-by-id:MyStar;ObjectFlipVertically;export-filename:out2.svg;export-do;" MyStar.svg'
system(command_4, intern = TRUE)


inx_verbs <- function(input, ext, actions){
 # if(is_url(input)) {
#    input_file_path = download_svg(input)
#  } else {
#    input_file_path = tempfile("inx_")
#    file.copy(input, input_file_path)
#  }
  output = tempfile("inx_", fileext = ext)
  actions = paste(actions, "export-filename:%s;export-do;", sep = ";")
  actions = sprintf(actions, output)
  fmt = 'inkscape --batch-process --actions="%s;" %s'
  command <- sprintf(fmt, actions, input)
  system(command, intern = TRUE)
  output
}

inx_verbs(input = "MyStar.svg", actions = "select-by-id:MyStar;ObjectFlipVertically;", ext = ".svg") %>%
  svg_to_dxf() %>%
    st_read() %>% ggplot() +
    geom_sf()

command_1 <- 'inkscape --batch-process --actions="select-by-id:;;export-filename:aligned_rect1.png;export-do;" align_me.svg'



inx_verbs(input = "align_me.svg", actions = "", ext = ".png") %>%
  png::readPNG() %>%
  grid::grid.raster()

inx_verbs(input = "align_me.svg", actions = "select-by-id:rectangle1,rectangle2;AlignBothBottomRight;", ext = ".png") %>%
  png::readPNG() %>%
  grid::grid.raster()

inx_verbs(input = "align_me.svg", actions = "select-by-id:rectangle1,rectangle2;AlignBothBottomLeft;", ext = ".png") %>%
  png::readPNG() %>%
  grid::grid.raster()
