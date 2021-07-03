library(dplyr)
library(zoo)
library(Hmisc)

# 1. Extraia a base geral de covid em Pernambuco disponível neste endereço: https://dados.seplag.pe.gov.br/apps/corona_dados.html

covidPE <- read.csv2('bases_originais/basegeral.csv', sep = ';')


# 2. Corrija os NAs da coluna sintomas através de imputação randômica 

covidPE$sintomas[which(covidPE$sintomas == "")] <- NA

(covidPE$sintomas <- impute(covidPE$sintomas, "random"))
is.imputed(covidPE$sintomas)


#3. Calcule, para cada município do Estado, o total de casos confirmados e negativos


# Organizando a base de dados
# Modificando a classe da variável data (dt_notificacao)

covidPE$dt_notificacao <- as.Date(covidPE$dt_notificacao, format = "%Y-%m-%d") # antecipando a alteração necessária à resolução da questão 5

# Criando novas variáveis

sintoma = 'TOSSE'

covidPE <- covidPE %>% 
  mutate(confirmados = ifelse(classe == 'CONFIRMADO', 1, 0)) %>% 
  mutate(negativo = ifelse(classe == 'CONFIRMADO', 1, 0)) %>% 
  mutate(tosse = ifelse(grepl(paste(sintoma, collapse="|"), sintomas), '1', '0')) %>% mutate (conf_tosse = ifelse(confirmados == '1' &  tosse == '1', 1, 0))%>% 
  mutate (neg_tosse = ifelse(negativo == '1' &  tosse == '1', 1, 0))

# calculando para cada município do Estado, o total de casos confirmados e negativos

covidPE_agrupado <- covidPE %>% 
  select(municipio, confirmados, negativo) %>% 
  group_by(municipio) %>% 
  summarise(across(everything(), list(sum))) 


# 4. Crie uma variável binária se o sintoma inclui tosse ou não e calcule quantos casos confirmados e negativos tiveram tosse como sintoma

# A variável binária foi criada anteriormente em "organizando a base de dados"

casos_tosse <- covidPE %>% 
  group_by(tosse) %>% 
  summarise(sum(confirmados),
            (sum(negativo)))


# 5. Agrupe os dados para o Estado, estime a média móvel de 7 dias de confirmados e negativos

# Agrupando casos

covidMM <- covidPE %>% 
  select(dt_notificacao, confirmados, negativo) %>% 
  group_by(dt_notificacao) %>% 
  summarise(across(everything(), list(sum)))


# Estimando a média móvel de casos confirmados e negativos no período de 7 dias 

covidPEMM <- covidMM %>% 
  mutate(confirmadosMM7 = round(rollmean(x = confirmados_1, 7, align = "right", fill = NA), 2)) %>% 
  mutate(negativosMM7 = round(rollmean(x = negativo_1, 7, align = "right", fill = NA), 2))
