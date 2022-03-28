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
    dplyr::mutate_at(dplyr::vars(fecha_arribo, fecha_retiro), as.Date,
                     format = "%d/%m/%Y") |>
    dplyr::mutate(fecha_month = format(fecha_arribo,  "%Y-%m")) |>
    dplyr::mutate(tiempo_uso_mins = difftime(strptime(hora_arribo, "%H:%M:%S"),
                                                strptime(hora_retiro, "%H:%M:%S"),
                                                units = "mins") |> as.numeric()) |>
    dplyr::mutate(tiempo_uso_hrs = tiempo_uso_mins/60) |>
    dplyr::mutate(tiempo_uso_class = ifelse(tiempo_uso_mins <= 45, "<= 45 min",
                                            ifelse(tiempo_uso_mins > 45 & tiempo_uso_mins <= 60, "45-60 min",
                                            "> 60 min"))) |>
    dplyr::mutate(tiempo_uso_class = factor(tiempo_uso_class, levels = c("<= 45 min", "45-60 min", "> 60 min")))

  #ADD stacked data
  core_vars <- c("genero_usuario" , "edad_usuario", "bici", "fecha_month", "tiempo_uso_mins",
                 "tiempo_uso_hrs", "tiempo_uso_class")
  arribo_vars <- grep("arribo", names(ecodata), value = TRUE)
  retiro_vars <- grep("retiro", names(ecodata), value = TRUE)

  ecodata_arribo <- ecodata |>
    dplyr::select(c(core_vars, arribo_vars)) |>
    rename(ciclo_estacion = ciclo_estacion_arribo,
           fecha = fecha_arribo,
           hora = hora_arribo) |>
    mutate(tipo_estacion = "arribo")
  ecodata_retiro <- ecodata |>
    dplyr::select(c(core_vars, retiro_vars)) |>
    rename(ciclo_estacion = ciclo_estacion_retiro,
           fecha = fecha_retiro,
           hora = hora_retiro)|>
    mutate(tipo_estacion = "retiro")

  ecodataStack <- rbind(ecodata_arribo, ecodata_retiro)


  Ecobici$ecodata <- ecodata
  Ecobici$ecodataStack <- ecodataStack
  return(Ecobici)
}
