library(dplyr)
library(tidyverse)

Dataset_Port_and_Eng <- read.csv2('bases_originais/Dataset_Port_and_Eng_1.csv', sep = ';', header = T, encoding = 'UTF-8')

tributacao <- read.csv2('bases_originais/base_geral.csv', sep = ';', header = T, encoding = 'UTF-8')

juncao <- left_join(tributacao, Dataset_Port_and_Eng, by = c('id' = 'X.U.FEFF.Ibge'))





