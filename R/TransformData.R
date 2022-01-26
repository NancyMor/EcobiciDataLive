#' Transform Ecobici variables
#'
#' @description
#' This function will transform and create new variables from Ecobici data.
#'
#' @param Ecobici list containing all Ecobici information.
#'
#' @return an object of class 'Ecobici' with a new variable for the length of the trip.
#'
#' @export
TransformData <- function(Ecobici) {
  ## LOAD data
  ecodata <- Ecobici$ecodata
  ## APPLY correct date format and ADD variable for length of the trip
  ecodata <- ecodata |>
    mutate_at(vars(fecha_arribo, fecha_retiro), as.Date, format="%d/%m/%Y") |>
    mutate(fecha = format(fecha_arribo,  "%Y-%m")) |>
    mutate(tiempo_uso = difftime(strptime(hora_arribo, "%H:%M:%S"),
                                 strptime(hora_retiro, "%H:%M:%S"),
                                 units = "mins") |> as.numeric())
  ## SAVE updated object
  Ecobici$ecodata <- ecodata
  return(Ecobici)
}
