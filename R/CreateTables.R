
CreateTables <- function(Ecobici){
  ecodata <- Ecobici$ecodata

  use_by_gender <- ecodata |>
    group_by(genero_usuario, fecha) |>
    summarise(n = n(), .groups = "drop") |>
    arrange(fecha)

  use_by_gender_per <- ecodata |>
    group_by(genero_usuario, fecha) |>
    summarise(n = n(), .groups = "drop") |>
    group_by(fecha) |>
    mutate(freq = (n / sum(n))) |>
    arrange(fecha) |>
    select(-n)

  tiempo_uso <- ecodata |>
    group_by(tiempo_uso_class) |>
    summarise(n = n()) |>
    mutate(porcentaje = sprintf("%1.2f%%", n/sum(n) * 100))

  summaryTables <- list('use_by_gender' = use_by_gender,
                        'use_by_gender_per' = use_by_gender_per,
                        'tiempo_uso' = tiempo_uso)

  Ecobici$summaryTables <- summaryTables
  return(Ecobici)
}
