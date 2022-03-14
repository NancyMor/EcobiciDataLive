#' Read Ecobici csv files
#'
#' @description
#' This function will read all csv files from an specified folder.
#'
#' @param input_path character string of the location of the files.
#'
#' @return a list.
#'
#' @export
ReadFiles <- function(input_path = NULL) {
  #CREATE a list to put in files
  file_names <- paste0(input_path, '/', list.files(input_path))
  #READ csv files and save in list
  files_from_csv <- lapply(file_names, function(file_name) read.csv(file_name))
  #CREATE List and return data
  ecobici_data <- list(Files = files_from_csv)
  return(ecobici_data)
}
