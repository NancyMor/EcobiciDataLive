
input_path = './extdata/dataEcobici/'

RunEcobici <- function(input_path = NULL, output_path = NULL){
  ## READ input files
  Ecobici <- ReadFiles(input_path)
  ## PREPARE data
  Ecobici <- CleanFormat(Ecobici)
  Ecobici <- TransformData(Ecobici)
  Ecobici <- AddModulesLocation(Ecobici)
  Ecobici <- ValidateInput(Ecobici)
  ## SUMMARY results
  #Ecobici <- CreateTables(Ecobici)
  ## EXPORT results
  CreateHTML(Ecobici, output_path)
  #createCSV(Ecobici, output_path)
}

