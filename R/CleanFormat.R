#' Clean Ecobici csv files
#'
#' @description
#' This function will take the uploaded csv files, make the corresponding data cleaning to then join them in a single table.
#'
#' @param Ecobici list containing all Ecobici csv files.
#'
#' @return an object of class 'Ecobici' with a data frame containing the joined and cleaned version of the Ecobici files.
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


#' Clean a single Ecobici csv file
#'
#' @description
#' This function will take a csv file and apply the correct format to each column.
#'
#' @param Ecobici data frame of an Ecobici csv file.
#'
#' @return a data frame with clean names and columns in the right order.
#'
#' @export
cleanData <- function(csvdata){
  ## MODIFY column names so that they are in lower case and REMOVE empty columns an rows
  cleandata <- csvdata |>
    janitor::clean_names() |>
    janitor::remove_empty(c("rows", "cols"))

  ## REMOVE special characters from column
  cleandata <- cleandata |>
    dplyr::rename_all(
      ~ stringr::str_replace_all(.x, 'i_|_1|pk', '')
      )

  ## REORDER columns
  col_names <- c("genero_usuario", "edad_usuario", "bici",
                 "ciclo_estacion_retiro", "fecha_retiro", "hora_retiro",
                 "ciclo_estacion_arribo", "fecha_arribo" ,"hora_arribo")
  cleandata <- cleandata |>
    dplyr::select(col_names)

  return(cleandata)
}
