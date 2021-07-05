library(lubridate)
library(dplyr)
library(readxl)
library(funModeling)
library(data.table)


#1. Extraia a base geral de covid em Pernambuco disponível neste endereço: https://dados.seplag.pe.gov.br/apps/corona_dados.html.

covidPE19 <- read.csv2('bases_tratadas/basegeral.csv', sep = ';')

covid <- covidPE19


# 2. Calcule, para cada município do Estado, o total de casos confirmados e o total de óbitos por semana epidemiológica [atenção, você terá de criar uma variável de semana epidemiológica com base na data].

covid <- covid %>% 
  mutate(confirmados = ifelse(classe == 'CONFIRMADO', 1, 0)) %>%
  mutate(obito = ifelse(evolucao == 'OBITO', 1, 0))

covid$semana_epidemiologica <- epiweek(covid$dt_notificacao) # criando a semana epidemiológica

covid <- covid %>%
  select(municipio, confirmados, obito, semana_epidemiologica)


# calculando total de casos confirmados e óbitos por município e semana_epidemiologica

total_confirmados <- covid %>% 
  group_by(municipio, semana_epidemiologica) %>% 
  summarise(sum(confirmados),
            (sum(obito))) %>% 
  filter(municipio != "") # retirando valores nulos

# 3. 3. Enriqueça a base criada no passo 2 com a população de cada município, usando a tabela6579 do sidra ibge.

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



## 4. Calcule a incidência (casos por 100.000 habitantes) e letalidade (óbitos por 100.000 habitantes) por município a cada semana epidemiológica.


#incidência
total_confirmados$nConfirmadosPor100000 <- total_confirmados$sum(confirmados)*100000/populacaoPE$populacao

total_confirmados$nObitosPor100000 <- total_confirmados$(sum(obito))*100000/populacaoPE$populacao














