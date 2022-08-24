#' Build a dataframe with the names and descriptions of the Inkscape verbs
#'
#' @return dataframe with the names and descriptions of the Inkscape verbs
#' @export
#'
#' @examples
#'\dontrun{
#'inx_verbs_list()
#'}
inx_verbs_list <- function(){
  if(Sys.info()['sysname']  == "Windows") {
    inx_verbs_list_win()
  } else{
    inx_verbs_list_linux()
  }
}
