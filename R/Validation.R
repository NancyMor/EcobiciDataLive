#' Ecobici Input Data Validation
#'
#' @description
#' This function will validate data from Ecobici data that has been uploaded and transformed
#' previously. There are specific conditions that the data should have to continue with the next
#' steps of the analysis.
#'
#' @param Ecobici list containing all Ecobici information.
#'
#' @return an object of class 'Ecobici' with a new table called validation indicating which conditions were met.
#'
#' @export
#'
ValidateInput <- function(Ecobici){
  ecodata <- Ecobici$ecodata

  ## CHECK that no more than 5% the data has length of use greater than 0
  flag_length <- ifelse(sum(ecodata$tiempo_uso_mins <= 0, na.rm = TRUE) / nrow(ecodata) > 0.05, 1, 0)
  ## if it's no more than 5%, delete the cases, else stop the analysis
  if(flag_length == 0) {
    ecodata <- ecodata %>%
      filter(tiempo_uso_mins > 0 & !is.na(tiempo_uso_mins))
  } else {
    stop('More than 5% of the data has a length of use that is not positive.')
  }

  ## CHECK that fecha_retiro is the same as fecha_arribo
  flag_date <- ifelse(sum(ecodata$fecha_arribo != ecodata$fecha_retiro) / nrow(ecodata) > 0.05,
                      1, 0)
  ## if it's no more than 5%, delete the cases, else stop the analysis
  if(flag_date == 0) {
    ecodata <- ecodata %>%
      filter(fecha_arribo == fecha_retiro)
  } else {
    stop('More than 5% of the data has different fecha de retiro and fecha de arribo')
  }

  ## CHECK that gender is binary
  flag_gender <- ifelse(sum(unique(ecodata$genero_usuario) %in% c('F', 'M')) != 2,
                      1, 0)
  if(flag_date == 1) {
    warning('Gender variable is not binary. Check input data.')
  }

  ## CHECK that age is a positive number less than 100
  flag_age <- ifelse(min(ecodata$edad_usuario) <= 0 | max(ecodata$edad_usuario) > 100,
                        1, 0)
  if(flag_date == 1) {
    warning('Age variable is not positive or is greater than 100.')
  }

  ## CREATE validation table
  Ecobici$validation <- data.frame(variable = c('Duración del viaje', 'Fecha', 'Género', 'Edad'),
                                   status = !as.logical(c(flag_length, flag_date,
                                                       flag_gender, flag_age)))
  #SAVE validated data
  Ecobici$ecodata <- ecodata
  return(Ecobici)
}
