#' Create summary tables
#'
#' @description
#' This function will create the summary tables necessary for the report.
#'
#' @param Ecobici list containing all Ecobici information.
#'
#' @return an object of class 'Ecobici' with an additional element containing the summary tables.
#'
#' @export
CreateTables <- function(Ecobici){
  ecodata <- Ecobici$ecodata
  ## CREATE table with number of users by date and gender
  use_by_gender <- ecodata |>
    group_by(genero_usuario, fecha) |>
    summarise(n = n(), .groups = "drop") |>
    arrange(fecha)
  ## CREATE table of percentage of users by gender per date
  use_by_gender_per <- ecodata |>
    group_by(genero_usuario, fecha) |>
    summarise(n = n(), .groups = "drop") |>
    group_by(fecha) |>
    mutate(freq = (n / sum(n))) |>
    arrange(fecha) |>
    select(-n)
  ## CREATE table of percentage of users by category of time of use
  tiempo_uso <- ecodata |>
    group_by(tiempo_uso_class) |>
    summarise(n = n()) |>
    mutate(porcentaje = sprintf("%1.2f%%", n/sum(n) * 100))
  ## SAVE tables
  summaryTables <- list('use_by_gender' = use_by_gender,
                        'use_by_gender_per' = use_by_gender_per,
                        'tiempo_uso' = tiempo_uso)

  Ecobici$summaryTables <- summaryTables
  return(Ecobici)
}
