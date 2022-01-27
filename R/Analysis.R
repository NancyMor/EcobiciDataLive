
input_path = 'C:/Users/Nan/Documents/EcobiciDataLive/Input'
output_path = 'C:/Users/Nan/Documents/EcobiciDataLive/Output'

RunEcobici <- function(input_path = NULL, output_path = NULL){
  ## READ input files
  Ecobici <- ReadFiles(input_path)
  ## PREPARE data
  Ecobici <- CleanFormat(Ecobici)
  Ecobici <- TransformData(Ecobici)
  Ecobici <- ValidateInput(Ecobici)
  ## SUMMARY results
  Ecobici <- CreateTables(Ecobici)
  ## EXPORT results
  CreateHTML(Ecobici, output_path)
  createCSV(Ecobici, output_path)
}

#CODE PROFILING
#profiling <- profvis::profvis(RunEcobici(input_path, output_path))
#htmlwidgets::saveWidget(profiling, "../profile_results.html")
