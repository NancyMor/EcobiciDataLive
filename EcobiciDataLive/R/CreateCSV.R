

createCSV <- function(Ecobici, output_path){
  validation <- Ecobici$validation
  summaryTables <- Ecobici$summaryTables

  ## WRITE Validation
  output_file <- paste0(output_path, "/validationData.csv")
  write.csv(validation, file = output_file, row.names = FALSE)

  ## WRITE all summary tables
  lapply(1:length(summaryTables), function(n_table){
    output_file <- paste0(output_path, "/", names(summaryTables)[[n_table]], ".csv")
    write.csv(summaryTables[[n_table]], file = output_file, row.names = FALSE)
  }) |> invisible()
}
