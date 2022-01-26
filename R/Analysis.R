

RunEcobici <- function(path_file = "./extdata/dataEcobici/"){
  load("../../Ecobici.Rda")
  Ecobici <- ReadFiles(path_file = "./extdata/dataEcobici/")
  Ecobici <- CleanFormat(Ecobici)
  Ecobici <- TransformData(Ecobici)
  Ecobici <- ValidateInput(Ecobici)
}
