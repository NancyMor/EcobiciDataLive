
input_path = 'C:/Users/Nan/Documents/EcobiciDataLive/Input'
output_path = 'C:/Users/Nan/Documents/EcobiciDataLive/Output'

RunEcobici <- function(input_path = NULL, output_path = NULL){
  Ecobici <- ReadFiles(input_path)
  Ecobici <- CleanFormat(Ecobici)
  Ecobici <- TransformData(Ecobici)
  Ecobici <- ValidateInput(Ecobici)
  CreateHTML(Ecobici, output_path)
  createCSV(Ecobici, output_path)
}
