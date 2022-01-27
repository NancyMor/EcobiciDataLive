
input_path = 'C:/Users/Nan/Documents/EcobiciDataLive/Input'
output_path = 'C:/Users/Nan/Documents/EcobiciDataLive/Output'

RunEcobici <- function(input_path = NULL, output_path = NULL){
  ## READ inout files
  Ecobici <- ReadFiles(input_path)
  ## PREPARE data
  Ecobici <- CleanFormat(Ecobici)
  Ecobici <- TransformData(Ecobici)
  Ecobici <- ValidateInput(Ecobici)
  ## EXPORT results
  CreateHTML(Ecobici, output_path)
  createCSV(Ecobici, output_path)
}
