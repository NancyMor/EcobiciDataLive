
output_path = 'C:/Users/Nan/Documents/EcobiciDataLive/Output'

RunEcobici <- function(path_file = "./extdata/dataEcobici/"){
  Ecobici <- ReadFiles(path_file = "./extdata/dataEcobici/")
  Ecobici <- CleanFormat(Ecobici)
  #Ecobici <- ValidateInput(Ecobici)
  Ecobici <- TransformData(Ecobici)

}
