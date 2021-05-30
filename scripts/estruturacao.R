library(data.table)
library(dplyr)
library(tidyverse)

# Base de dados referente ao censo das IES em 2016
censo_ies_2016 <- read.csv2('bases_originais/DM_IES.CSV', sep = '|')


# Filtrando apenas universidades públicas federais situadas no nordeste e selecionando variáveis
nordeste <- censo_ies_2016 %>% filter(NO_REGIAO_IES == "Nordeste",
                                 CO_CATEGORIA_ADMINISTRATIVA ==1,
                                 CO_ORGANIZACAO_ACADEMICA == 1) %>% 
  select("SGL_IES", "QT_TEC_TOTAL", "IN_CAPITAL_IES")


# filtra dados para garantir que todos os países tenham mesmo nro de casos
ies_nordeste <- nordeste %>% group_by(SGL_IES) %>% mutate(row = row_number()) %>% select(QT_TEC_TOTAL, IN_CAPITAL_IES, row)


# Criando matriz das IES, agrupando pela sigla, criando uma nova linha com index e selecionando apenas algumas variáveis
censo_ies_NE <- ies_nordeste %>% pivot_wider(names_from = row, values_from = "QT_TEC_TOTAL") %>% remove_rownames %>% column_to_rownames(var="SGL_IES")
