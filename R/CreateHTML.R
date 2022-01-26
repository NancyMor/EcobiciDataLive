

CreateHTML <- function(Ecobici, output_path){
  ecodata <- Ecobici$ecodata
  save(ecodata, file = "./extdata/Ecobici_HTML.Rda")
  output_file <- paste0(output_path, "/DescriptiveStatistics.html")
  rmarkdown::render("./rmd/DescriptiveStatistics.Rmd", output_file = output_file)
}



