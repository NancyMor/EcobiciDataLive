# #Path to download ecobici data
# url_path <- "https://www.ecobici.cdmx.gob.mx/sites/default/files/data/usages/"
#
# #Select data from January 2020 - December 2021
# year <- c("2020", "2021")
# month <- sprintf("%02d", 1:12)
#
# dates <- expand.grid(year, month)
# filenames <- paste(dates[, 1], dates[, 2], sep = "-")
#
# #Download all files from ecobici URL
# sapply(filenames, function(filename){
#   url_file_path <- paste0(url_path, filename, ".csv")
#   download_path <- paste0("./extdata/dataEcobici/", filename, ".csv")
#   download.file(url_file_path, download_path)
# })









# #FILE NAMES
# example <- csv_[1]]
# names(example)files[
# example <- example |> janitor::clean_names()
# names(example)
# namesclean <- lapply(csv_files, function(x) names(clean_names(x)))
# namesclean <- unique(unlist(namesclean))
# #NUMBER OF COLUMS
# cols <- lapply(csv_files, function(csv_file) length(csv_file))
# table(unlist(cols))
# #There are two files which are inconsistent with the rest.
# csv_one_column <- csv_files[[12]]
# csv_ten_column <- csv_files[[8]]
# names(example)
# names(csv_ten_column)
