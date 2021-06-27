install.packages('lubridate')
library('lubridate')

#Criação de objeto de data e tempo com conversão para três formatos de data e tempo

# Conversão para data
vida_lilly1 <- as.Date(c("2016-12-22", "2021-06-26")) 

# Conversão para POSIXct
vida_lilly2 <- as.POSIXct(c("2016-12-22 22:09", "2021-06-26 20:58"))

# Conversão para POSIXlt
vida_lilly3 <- as.POSIXlt(c("2016-12-22 22:09", "2021-06-26 20:58"))

#Extração de componentes e operação

# Extração de componente (abreviação do dia)
wday(vida_lilly3, label = T, abbr = T)

# semana ISO 8601
isoweek(vida_lilly3)

# Extração da sequência dos dias compreendidos entre duas datas
(lilly <- seq(as.Date('2016-12-22 22:09'), as.Date('2021-06-26 20:58'), by = "day") )






