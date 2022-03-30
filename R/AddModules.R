#' Add Ecobici modules
#'
#' @description
#' This function will add ecobici modules information to dataset.
#'
#' @param Ecobici dataframe with all info plus modules.
#'
#' @return a dataframe.
#'
#' @export
#'
AddModulesLocation <- function(Ecobici){
  ecodata <- Ecobici$ecodataStack

  #READ modules information
  modules <- readr::read_csv("./extdata/modules.csv") |>
    select(c("id", "zipCode"))
             #"districtName", "stationType", "lat", "lon"))


  #MERGE modules with ecodata info
  ecodataModule <- ecodata |> left_join(ecodata, modules, by = c("ciclo_estacion"))

}
