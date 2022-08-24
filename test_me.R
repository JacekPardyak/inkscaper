library(tidyverse)
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


verbs = inx_verbs_list()
verbs$GUI = NA
verbs$WARNING = NA

for(i in c(1:1000)){
#  i = 1
  verb = verbs$Verb[i]
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


command_1 <- 'inkscape --batch-process --actions="select-by-id:rectangle1,rectangle2;AlignBothBottomRight;export-filename:aligned_rect1.png;export-do;" align_me.svg'
command_2 <- 'inkscape --batch-process --actions="select-by-id:rectangle2,rectangle1;AlignBothBottomLeft;export-filename:aligned_rect2.png;export-do;" align_me.svg'
command_3 <- 'inkscape --batch-process --actions="select-by-id:rectangle2,rectangle1;FileNew;export-filename:aligned_rect2.png;export-do;" align_me.svg'

system(command_1, intern = T)
system(command_2, intern = T)
system(command_3, intern = T)
?system
