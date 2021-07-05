library(lubridate)
library(dplyr)
library(readxl)
library(funModeling)
library(data.table)
library(fuzzyjoin)
library(stringr)
library(tidyverse)


covidPE19 <- read.csv2('bases_tratadas/basegeral.csv', sep = ';')

covid <- covidPE19


# 1.  
covid <- covid %>% 
  mutate(confirmados = ifelse(classe == 'CONFIRMADO', 1, 0)) %>%
  mutate(obito = ifelse(evolucao == 'OBITO', 1, 0))

covid <- covid %>%
  select(municipio, confirmados, obito,dt_notificacao)


covid$semana_epidemiologica <- epiweek(covid$dt_notificacao) # criando a semana epidemiológica

covid <- data.table(covid)

covid_1<-covid[,sum(obito), by=data.table(semana_epidemiologica, municipio)]
covid_2<-covid[,sum(confirmados), by=data.table(semana_epidemiologica, municipio)]

covid_3 <- left_join(covid_1, covid_2, by = 'municipio')
covid_3 <- merge(covid_1, covid_2)


# criando variável com casos confirmados e óbitos

covid_2$V1 

str(covid_2)

total_casos_obitos <- covid %>% 
  select(municipio, confirmados, obito)%>% 
  group_by(municipio)
  

baseC <- fuzzyjoin::stringdist_join(total_casos_obitos, populacao, mode='left')
  
basec <- left_join(total_casos_obitos, populacao)


str(populacao)
class(populacao)


total_obito <- total_confirmados %>% 
  filter(municipio != "")



  #QUESTÃO 3

IBGE_populacao <- read_excel('bases_tratadas/tabela6579.xlsx', sheet = 1)

pe = '(PE)'

populacaoPE <- IBGE_populacao %>% 
mutate(pernambuco = ifelse(grepl(paste(pe, collapse="|"), `Tabela 6579 - População residente estimada`), '1', '0')) %>% 
  filter(pernambuco=="1") %>% 
  select(`Tabela 6579 - População residente estimada`, '...2') %>% 
  rename(populacao = ...2) %>% 
  rename(municipio = `Tabela 6579 - População residente estimada`) %>% 
  mutate(municipio = stringi::stri_trans_general(populacaoPE$municipio, "Latin-ASCII"),
       municipio = stringr::str_to_lower(string = municipio),
       municipio = str_remove(string = municipio, pattern = " \\(pe\\)"),
       populacao = as.numeric(populacao))


base_join <- fuzzyjoin::stringdist_join(total_confirmados, populacaoPE, by = "municipio")


# 4. Calcule a incidência (casos por 100.000 habitantes) e letalidade (óbitos por 100.000 habitantes) por município a cada semana epidemiológica.


#incidência
total_confirmados$nConfirmadosPor100000 <- total_confirmados$sum(confirmados)*100000/populacaoPE$populacao

total_confirmados$nObitosPor100000 <- total_confirmados$(sum(obito))*100000/populacaoPE$populacao















    