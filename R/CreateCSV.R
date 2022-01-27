

createCSV <- function(Ecobici, output_path){
  validation <- Ecobici$validation
  output_file <- paste0(output_path, "/validationData.csv")
  write.csv(validation, file = output_file, row.names = FALSE)
}
