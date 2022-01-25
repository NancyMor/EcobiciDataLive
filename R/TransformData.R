#' Transform variables
#'
#' @description
#' This function will transform variables in existing data.
#'
#' @param Ecobici list containing all Ecobici information.
#'
#' @return an object of class 'Ecobici'.
#'
#' @export
TransformData <- function(Ecobici) {
  ecodata <- Ecobici$ecodata
  ecodata <- ecodata |>
    mutate_at(vars(fecha_arribo, fecha_retiro), as.Date, format="%d/%m/%Y") |>
    mutate(fecha = format(fecha_arribo,  "%Y-%m")) |>
    mutate(tiempo_uso = difftime(strptime(hora_arribo, "%H:%M:%S"),
                                 strptime(hora_retiro, "%H:%M:%S"),
                                 units = "mins") |> as.numeric())
}
