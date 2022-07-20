# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

hello <- function() {
  print("Hello, world!")
}

inx_extension_win <- function(input, inkscape_extension_name, ext){
  path = system('inkscape --system-data-directory', intern = TRUE)
  inkscape_extensions_path = paste(path, "\\extensions", sep = "")
  inkscape_python_home  = paste(gsub("\\share\\inkscape", "", path, fixed = T), "\\bin", sep = "")
  if(is_url(input)) {
    input_file_path = download_svg(input)
  } else {
    input_file_path = tempfile("inx")
    file.copy(input, input_file_path)
  }
  output = tempfile("inx", fileext = ext)
  command = tempfile(pattern = "inx_", fileext = ".bat")
  '@ECHO OFF
cd %s
python.exe "%s" --output="%s"  "%s"' %>% sprintf(
  inkscape_python_home,
  paste(inkscape_extensions_path, inkscape_extension_name, sep = "\\"),
  output,
  input_file_path) %>% writeLines(command)
  system(command)
  output
}

inx_extension_linux <- function(input, inkscape_extension_name, ext){
  path = system('inkscape --system-data-directory', intern = TRUE)
  inkscape_extensions_path = paste(path, "/extensions", sep = "")
  if(is_url(input)) {
    input_file_path = download_svg(input)
  } else {
    input_file_path = tempfile("inx")
    file.copy(input, input_file_path)
  }
  output <- tempfile("inx", fileext = ext)
  command <- sprintf('python %s --output="%s" "%s"', paste(inkscape_extensions_path, inkscape_extension_name, sep = "/"), output, input_file_path)
  system(command, intern = TRUE)
  output
}

inx_extension <- function(input, inkscape_extension_name, ext){
  if(Sys.info()['sysname']  == "Windows") {
    inx_extension_win(input, inkscape_extension_name, ext)
  } else{
    inx_extension_linux(input, inkscape_extension_name, ext)
  }
}


