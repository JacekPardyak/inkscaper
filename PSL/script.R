# --------------------------------------------------------------
# in R
files = list.files("./PSL/", pattern = ".svg", full.names = T)
for (file in files) {
  fmt = 'inkscape --actions="export-type:emf;export-do" %s'
  command <- sprintf(fmt, file)
  system(command, intern = TRUE)
}
