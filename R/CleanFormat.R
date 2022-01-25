#' Clean Ecobici csv files
#'
#' @description
#' This function will read all csv files and clean and combine them.
#'
#' @param path_file character string of the location of the files.
#'
#' @return an object of class 'Ecobici'.
#'
#' @export
CleanFormat <- function(Ecobici) {
  csvdata <- Ecobici$Files
  #CLEAN each monthly data
  cleandata <- lapply(csvdata, cleanData)
  #COMBINE all months in one data.frame
  ecodata <- Reduce(rbind, cleandata)
  #SAVE all data
  Ecobici$ecodata <- ecodata
  #DROP original files to free memory
  Ecobici$Files <- NULL
  return(Ecobici)
}


#' @export
cleanData <- function(csvdata){
  cleandata <- csvdata |>
    janitor::clean_names() |>
    janitor::remove_empty(c("rows", "cols"))
  col_names <- c("genero_usuario", "edad_usuario", "bici",
                 "ciclo_estacion_retiro", "fecha_retiro", "hora_retiro",
                 "ciclo_estacion_arribo", "fecha_arribo" ,"hora_arribo")
  cleandata <- cleandata |>
    dplyr::rename_all(
      ~ stringr::str_replace_all(.x, 'i_|_1|pk', '')
      )
  cleandata <- cleandata |>
    dplyr::select(col_names)

  return(cleandata)
}
