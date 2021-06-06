library(dplyr)

count(enem_pe, NO_MUNICIPIO_RESIDENCIA)

enem_pe %>% group_by(TP_SEXO) %>% summarise(avg = mean(nota_media))

enem_pe_GUS <- enem_2014 %>% 
  filter(NO_MUNICIPIO_RESIDENCIA == 'GARANHUNS') %>% 
  select(nota_media, renda_pc, TP_SEXO)
