install.packages("funModeling")
library(funModeling) 
library(tidyverse) 

censo_ies <- read.csv2('bases_originais/DM_IES.CSV', sep = '|')

glimpse(censo_ies) # olhada nos dados
staus(censo_ies) # estrutura dos dados (missing etc)
freq(censo_ies) # frequência das variáveis fator(esta base não possui variável fator)
plot_num(censo_ies) # exploração das variáveis numéricas
profiling_num(censo_ies) # estatísticas das variáveis numéricas

