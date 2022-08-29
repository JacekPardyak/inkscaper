is_url <- function(path){
  grepl("^https?://", path)
}

is_svg <- function(path){
  grepl("<\\/svg>\\s?$", path)
}

download_svg <- function(url){
  filename = tempfile("inx_", fileext = ".svg")
  utils::download.file(url, filename)
  return(filename)
}




inx_save <- function(input, output) {
  file.copy(input, output)
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
  command <- sprintf('python3 %s --output="%s" "%s"', paste(inkscape_extensions_path, inkscape_extension_name, sep = "/"), output, input_file_path)
  system(command, intern = TRUE)
  output
}


inx_extensions_list_win <- function(){
  path = system('inkscape --system-data-directory', intern = TRUE)
  inkscape_extensions_path = paste(path, "\\extensions", sep = "")
  inkscape_python_home  = paste(gsub("\\share\\inkscape", "", path, fixed = T), "\\bin", sep = "")
  inkscape_extension_names = list.files(path = inkscape_extensions_path, pattern = ".py")
  df <- data.frame(Extension = inkscape_extension_names, Description = NA)
  for (i in c(1:nrow(df))) {
    inkscape_extension_name = df$Extension[i]
    print(inkscape_extension_name)
    output = tempfile("inx_", fileext = ".txt")
    con  = tempfile(pattern = "inx_", fileext = ".bat")
    fmt = '@ECHO OFF
cd %s
python.exe "%s" --help  > %s'
    text = sprintf(fmt,
                   inkscape_python_home,
                   paste(inkscape_extensions_path, inkscape_extension_name, sep = "\\"),
                   output)
    writeLines(text, con)
    system(con)
    output
    inkscape_extension_description <- readLines(output)
    df$Description[i] <- paste(inkscape_extension_description, collapse = "\n")
  }

  df
}

#inx_extensions_list_win() %>% readr::write_csv("../inst/extdata/extensions.csv")


inx_extensions_list_linux <- function(){
  path = system('inkscape --system-data-directory', intern = TRUE)
  inkscape_extensions_path = paste(path, "/extensions", sep = "")
  inkscape_extension_names = list.files(path = inkscape_extensions_path, pattern = ".py")
  df <- data.frame(Extension = inkscape_extension_names, Description = NA)
  for (i in c(1:nrow(df))) {
    inkscape_extension_name = df$Extension[i]
    print(inkscape_extension_name)
    output = tempfile("inx_", fileext = ".txt")
    command <- sprintf('python %s --help  > %s', paste(inkscape_extensions_path, inkscape_extension_name, sep = "/"), output)
    system(command, intern = TRUE)
    inkscape_extension_description <- readLines(output)
    df$Description[i] <- paste(inkscape_extension_description, collapse = "\n")
  }
  df
}

inx_actions_list_win <- function(){
  output = tempfile("inx_", fileext = ".txt")
  con  = tempfile(pattern = "inx_", fileext = ".bat")
  fmt = '@ECHO OFF
inkscape --action-list > %s'
  text = sprintf(fmt, output)
  writeLines(text, con)
  system(con)
  text <- readLines(output)
  text <- gsub("<b0>", "°", x = text, useBytes = F, fixed = T)
  #dd[agrep("object-rotate-90-ccw", dd, useBytes = F, fixed = T)]
  writeLines(text, output)
  actions <- readr::read_delim(output, delim = ":", col_names = FALSE)
  names(actions) = c("Action", "Description")
  actions
}
#inx_actions_list_win() %>% readr::write_csv("./inst/extdata/actions.csv")


inx_actions_list_linux <- function(){
  output = tempfile("inx_", fileext = ".txt")
  fmt = 'inkscape --action-list > %s'
  text = sprintf(fmt, output)
  system(text)
  actions <- readr::read_delim(output, delim = ":", col_names = FALSE)
  names(actions) = c("Action", "Description")
  actions
}
