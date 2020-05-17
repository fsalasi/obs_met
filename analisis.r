# library imports
library(tidyverse)

# import aemet data
data = read.csv("aemet_data.csv", row.names = 1)
data = data %>% mutate(fechahora=as.POSIXct(fechahora, format="%Y-%m-%d %H:%M:%S"))

# plot data
data %>% ggplot(aes(x = fechahora, y = tinst)) + 
  geom_line(aes(y = tmax, color = "tmax"), size = 2) + 
  geom_line(aes(y = tmin, color = "tmin"), size = 2) + 
  geom_ribbon(aes(ymin=tmin,ymax=tmax), fill="grey") + 
  geom_point() + 
  theme_light() + theme(legend.position = c(0.90,0.11), legend.title = element_blank(), legend.background = element_blank()) +  
  xlab("") + ylab ("Temperatura (ºC)") + ggtitle("Temperaturas en est. AEMET Andújar")
  