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
    dplyr::mutate_at(vars(fecha_arribo, fecha_retiro), as.Date,
                     format = "%d/%m/%Y") |>
    dplyr::mutate(fecha = format(fecha_arribo,  "%Y-%m")) |>
    dplyr::mutate(tiempo_uso_mins = difftime(strptime(hora_arribo, "%H:%M:%S"),
                                                strptime(hora_retiro, "%H:%M:%S"),
                                                units = "mins") |> as.numeric()) |>
    dplyr::mutate(tiempo_uso_hrs = tiempo_uso_mins/60) |>
    dplyr::mutate(tiempo_uso_class = ifelse(tiempo_uso_mins <= 45, "<= 45 min",
                                            ifelse(tiempo_uso_mins > 45 & tiempo_uso_mins <= 60, "45-60 min",
                                            "> 60 min")))

  Ecobici$ecodata <- ecodata
  return(Ecobici)
}
