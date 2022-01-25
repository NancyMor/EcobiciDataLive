

RunEcobici <- function(path_file = "./extdata/dataEcobici/"){
  Ecobici <- ReadFiles(path_file = "./extdata/dataEcobici/")
  Ecobici <- CleanFormat(Ecobici)
  #Ecobici <- ValidateInput(Ecobici)
}
