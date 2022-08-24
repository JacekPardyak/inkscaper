#' Build a dataframe with the names and descriptions of the Inkscape extensions
#'
#' @return dataframe with the names and descriptions of the Inkscape extensions
#ls
' @export
#'
#' @examples
#' inx_extensions_list()
inx_extensions_list <- function(){
  if(Sys.info()['sysname']  == "Windows") {
    inx_extensions_list_win()
  } else{
    inx_extensions_list_linux()
  }
}
