#' Get a list of Inkscape actions and put them in a tibble
#'
#' @return tibble with action names and descriptions
#' @export
#'
#' @examples
#' inx_actions_list()
inx_actions_list <- function(){
  if(Sys.info()['sysname']  == "Windows") {
    inx_actions_list_win()
  } else{
    inx_actions_list_linux()
  }
}
