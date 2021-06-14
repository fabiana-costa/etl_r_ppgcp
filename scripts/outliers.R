library(dplyr)
library(data.table)
install.packages('plotly')
library(plotly)


# carregar dados covid19 Pernambuco
covid19PE <- fread('https://dados.seplag.pe.gov.br/apps/basegeral.csv')

covid19PEMun <- covid19PE %>% count(municipio, sort = T, name = 'casos') %>% mutate(casos2 = sqrt(casos), casosLog = log10(casos))

## outliers em variáveis
# distância interquartil

plot_ly(y = covid19PEMun$casosLog, type = "box", text = covid19PEMun$municipio, boxpoints = "all", jitter = 0.3)
