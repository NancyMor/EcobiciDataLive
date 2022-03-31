library(dplyr)
library(tidyr)
library(ggplot2)
library(leaflet)
library(EcobiciDataLive)

#8FB585
#B4CDAD
#c6adcd
#b08dba

Ecobici <- ReadFiles('extdata/dataEcobici/')
names(Ecobici$Files[[6]]) <- names(Ecobici$Files[[1]])
## PREPARE data
Ecobici <- CleanFormat(Ecobici)
Ecobici <- TransformData(Ecobici)
Ecobici <- ValidateInput(Ecobici)

ecodata <- Ecobici$ecodata
dim(ecodata)
ecodata_filt <- ecodata |> filter(genero_usuario %in% c("M", "F"))
dim(ecodata_filt)
(dim(ecodata) - dim(ecodata_filt)) / dim(ecodata)

prop.table(table(ecodata_filt$genero_usuario))

ecodata_filt <- ecodata_filt |>
  mutate(edad_usuario = as.numeric(edad_usuario))

summary(ecodata_filt$edad_usuario)

ecodata_filt |> ggplot(aes(edad_usuario)) +
  geom_histogram(color = 'white', fill = '#8FB585', alpha = 0.9) +
  geom_vline(xintercept = 34, colour = '#b08dba', linetype = 2, size = 1) +
  theme_minimal()


# fidings por género ------------------------------------------------------

ecodata_filt <- ecodata_filt |>
  mutate(hora_arribo = strptime(hora_arribo, "%H:%M:%S"))

ecodata_filt <- ecodata_filt |>
  mutate(cat_arribo = ifelse(hora_arribo < strptime('04:00:00', "%H:%M:%S"), '00-04',
                                 ifelse(hora_arribo < strptime('08:00:00', "%H:%M:%S"), '04-08',
                                        ifelse(hora_arribo < strptime('12:00:00', "%H:%M:%S"), '08-12',
                                               ifelse(hora_arribo < strptime('16:00:00', "%H:%M:%S"), '12-16',
                                                      ifelse(hora_arribo < strptime('20:00:00', "%H:%M:%S"), '16-20',
                                                             '20-24'))))))

tabla_horario <- ecodata_filt |>
  group_by(cat_arribo) |>
  tally() |>
  ungroup() |>
  mutate(prop = n/sum(n))

tabla_horario_genero <- ecodata_filt |>
  group_by(genero_usuario, cat_arribo) |>
  tally() |>
  ungroup() |>
  group_by(genero_usuario) |>
  mutate(prop = n/sum(n))


# tiempo acumulado de uso -------------------------------------------------

length(unique(ecodata_filt$bici))
## 5696 bicis diferentes

uso_acum <- ecodata_filt |>
  mutate(bici_num = as.numeric(bici)) |>
  group_by(bici) |>
  summarise(tiempo_acum = sum(tiempo_uso_mins) / 60,
            tiempo_prom = mean(tiempo_uso_mins),
            num_viajes = n())

summary(uso_acum)

ggplot(uso_acum, aes(num_viajes)) +
  geom_histogram(colour = 'white', fill = '#8FB585', alpha = 0.9, bins = 50) +
  theme_minimal() +
  labs(title = 'Número de viajes por Ecobici',
       x = 'número de viajes', y = 'frecuencia') +
  geom_vline(xintercept = 764.0, colour = '#8E5E9C', size = 1, linetype = 1) +
  geom_vline(xintercept = 702.3, colour = '#8E5E9C', size = 1, linetype = 1)

ggplot(uso_acum, aes(tiempo_acum)) +
  geom_histogram(colour = 'white', fill = '#8FB585', alpha = 0.9, bins = 50) +
  theme_minimal() +
  labs(title = 'Tiempo acumulado de uso de las Ecobicis',
       x = 'horas', y = 'frecuencia') +
  geom_vline(xintercept = 201.7653, colour = '#8E5E9C', size = 1, linetype = 1) +
  geom_vline(xintercept = 189.6561, colour = '#8E5E9C', size = 1, linetype = 1)

ggplot(uso_acum, aes(tiempo_prom)) +
  geom_histogram(colour = 'white', fill = '#8FB585', alpha = 0.9, bins = 50) +
  theme_minimal() +
  labs(title = 'Duración promedio de los viajes',
       x = 'minutos', y = 'frecuencia') +
  geom_vline(xintercept = 15.739, colour = '#8E5E9C', size = 1, linetype = 1) +
  geom_vline(xintercept = 16.382, colour = '#8E5E9C', size = 1, linetype = 1)

bici_supervivencia <- ecodata_filt |>
  mutate(bici_num = as.numeric(bici)) |>
  group_by(bici) |>
  arrange(hora_arribo) |>
  mutate(uso_bici = cumsum(tiempo_uso_mins),
         num_viajes = 1:n())

uso_acum |>
  ggplot(aes(tiempo_acum, tiempo_prom)) +
  geom_point()

bici_supervivencia |>
  filter(bici_num == 8645) |>
  ggplot(aes(num_viajes, uso_bici)) +
  geom_point()

bici_regreso <- ecodata_filt |>
  filter(ciclo_estacion_retiro == ciclo_estacion_arribo)

modulos_genero <- ecodata_filt |>
  group_by(genero_usuario, ciclo_estacion_retiro) |>
  tally() |>
  ungroup() |>
  spread(genero_usuario, n, fill = 0) |>
  mutate(tot = F + M,
    prop_f = F / tot,
    prop_tot = tot / sum(tot),
    id = as.numeric(ciclo_estacion_retiro))
## revisar a qué módulos corresponden los que no tienen mujeres y los que tienen más mujeres


mes_circulacion <- ecodata_filt |>
  mutate(mes_arribo = months(fecha_arribo)) |>
  dplyr::select(bici, mes_arribo) |>
  unique()

bicis_pormes <- mes_circulacion |>
  group_by(mes_arribo) |>
  tally()

ggplot(bicis_pormes, aes(mes_arribo, n)) +
  geom_bar(stat = 'identity')

bicis_circulacion <- mes_circulacion |>
  group_by(bici) |>
  tally()

table(bicis_circulacion$n) |> prop.table()

rutas <- ecodata_filt |>
  mutate(ruta = paste0(ciclo_estacion_retiro, '-', ciclo_estacion_arribo)) |>
  group_by(ruta) |>
  tally()


# modulos -----------------------------------------------------------------

modulos <- read.csv('extdata/modules.csv') |>
  left_join(modulos_genero)


qpal <- colorQuantile("Blues", modulos$tot, n = 9)
fpal <- colorQuantile("Blues", modulos$prop_f, n = 9)


leaflet(data = modulos) %>% addTiles() %>%
  addCircleMarkers(~lon, ~lat, popup = ~as.character(id),
                   label = ~as.character(id), radius = 4,
                   color = ~qpal(tot),
                   stroke = FALSE, fillOpacity = 0.8)
