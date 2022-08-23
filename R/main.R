inx_extension_win_ <- function(input, inkscape_extension_name, ext){
  path = system('inkscape --system-data-directory', intern = TRUE)
  inkscape_extensions_path = paste(path, "\\extensions", sep = "")
  inkscape_python_home  = paste(gsub("\\share\\inkscape", "", path, fixed = T), "\\bin", sep = "")
  if(is_url(input)) {
    input_file_path = download_svg(input)
  } else {
    input_file_path = ""
    file.copy(input, input_file_path)
  }
  output = tempfile("inx_", fileext = ext)
  con  = tempfile(pattern = "inx_", fileext = ".bat")
  fmt = '@ECHO OFF
cd %s
python.exe "%s" --output="%s"  "%s"'
  text = sprintf(fmt,
  inkscape_python_home,
  paste(inkscape_extensions_path, inkscape_extension_name, sep = "\\"),
  output,
  input_file_path)
  writeLines(text, con)
  system(con)
  output
}

inx_extension_win <- function(input, inkscape_extension_name, ext){
  path = system('inkscape --system-data-directory', intern = TRUE)
  inkscape_extensions_path = paste(path, "\\extensions", sep = "")
  inkscape_python_home  = paste(gsub("\\share\\inkscape", "", path, fixed = T), "\\bin", sep = "")
  if(is_url(input)) {
    input_file_path = download_svg(input)
  } else {
    input_file_path = tempfile("inx_")
    file.copy(input, input_file_path)
  }
  output = tempfile("inx_", fileext = ext)
  con  = tempfile(pattern = "inx_", fileext = ".bat")
  fmt = '@ECHO OFF
cd %s
python.exe "%s" --output="%s"  "%s"'
  text = sprintf(fmt,
                 inkscape_python_home,
                 paste(inkscape_extensions_path, inkscape_extension_name, sep = "\\"),
                 output,
                 input_file_path)
  writeLines(text, con)
  system(con)
  output
}

inx_extension_linux <- function(input, inkscape_extension_name, ext){
  path = system('inkscape --system-data-directory', intern = TRUE)
  inkscape_extensions_path = paste(path, "/extensions", sep = "")
  if(is_url(input)) {
    input_file_path = download_svg(input)
  } else {
    input_file_path = tempfile("inx_")
    file.copy(input, input_file_path)
  }
  output <- tempfile("inx_", fileext = ext)
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



#svg_to_dxf <- function(input){
#  inx_extension(input, inkscape_extension_name = "dxf12_outlines.py", ext = ".dxf")
#}
