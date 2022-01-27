createCSV <- function(Ecobici, output_path){
  ecodata <- Ecobici$ecodata
  output_file <- paste0(output_path, "/ecobiciData.csv")
  write.csv(ecodata, file = output_file)
}
