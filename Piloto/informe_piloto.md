Informe Piloto
================
Francisco Salas
22/05/2020

### Descripción

Este es el informe piloto del proyecto de análisis de datos de
observación de las estaciones de AEMET.

### Presentación de gráficos

En el siguiente gráfico se pueden observar las temperaturas máximas,
mínimas, y las muestras instantáneas disponibles, para la estación
meteorológica de AEMET en Andújar (Jaén), de los días 15 a 21 de mayo.

![](../informe_files/figure-gfm/temp_plor-1.png)<!-- -->

### Código fuente

El código utilizado para el análisis se adjunta a continuación.

``` r
# library imports
library(tidyverse)

# import aemet data
data = read.csv("aemet_data.csv", row.names = 1)
data = data %>% mutate(fechahora=as.POSIXct(fechahora, format="%Y-%m-%d %H:%M:%S"))
data_spread = data
data_gathered = data %>% gather(key = "temp_type", value = "value", -fechahora)

# plot data
ggplot() + 
  geom_ribbon(data = data_spread, aes(x = fechahora, ymin=tmin, ymax=tmax), fill = "grey") + 
  geom_line(data = (data_gathered %>% filter(temp_type != "tinst")), aes(x = fechahora, y = value, color = temp_type), size = 1) +
  geom_point(data = (data_gathered %>% filter(temp_type == "tinst")), aes(x = fechahora, y = value, color = temp_type), show.legend = FALSE) +
  theme_light() + 
  theme(legend.position = c(0.11,0.85), legend.title = element_blank(), legend.background = element_blank()) +  
  scale_color_manual(values=c("#FFF684", "#DA3612", "#00D8FF")) +
  scale_x_datetime(date_breaks = "1 days", date_labels = "%b %d") +
  xlab("") + ylab ("Temperatura (ºC)") + ggtitle("Temperaturas en est. AEMET Andújar")
```
