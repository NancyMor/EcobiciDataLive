#' Read Ecobici csv files
#'
#' @description
#' This function will read all csv files from an specified folder.
#'
#' @param path_file character string of the location of the files.
#'
#' @return an object of class 'Ecobici'.
#'
#' @export
ReadFiles <- function(path_file = "./extdata/dataEcobici/") {
  #CREATE a list to put in files
  file_names <- paste0(path_file, list.files(path_file))
  #READ csv files and save in list
  files_from_csv <- lapply(file_names,
                           function(file_name) read.csv(file_name))
  #INRTRODUCE a new class
  ecobici_class <- list(Files = files_from_csv)
  class(ecobici_class) <- 'ecobici'
  return(ecobici_class)
}
