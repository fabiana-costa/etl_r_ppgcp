library(dplyr)
  

# carrega a base de snistros de transito do site da PCR (2019 a 2021)


sinistrosRecife2019Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/3531bafe-d47d-415e-b154-a881081ac76c/download/acidentes-2019.csv', sep = ';', encoding = 'UTF-8')

sinistrosRecife2020Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/fc1c8460-0406-4fff-b51a-e79205d1f1ab/download/acidentes_2020-novo.csv', sep = ';', encoding = 'UTF-8')

sinistrosRecife2021Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/2caa8f41-ccd9-4ea5-906d-f66017d6e107/download/acidentes_2021-jan.csv', sep = ';', encoding = 'UTF-8')

# observando a estrutura dos dados

str(sinistrosRecife2019Raw)
str(sinistrosRecife2020Raw)
str(sinistrosRecife2021Raw)


# tratando as bases (tornando compatível o número de colunas e nomes das variáveis em todas as bases)


sinistrosRecife2019Raw_selecionado <- sinistrosRecife2019Raw %>% 
  select(-endereco_cruzamento, -numero_cruzamento, -referencia_cruzamento) %>% 
  rename(data = DATA)

str(sinistrosRecife2019Raw_selecionado)


# junta as bases de dados com comando rbind 

sinistrosRecifeRaw <- rbind(sinistrosRecife2019Raw_selecionado, sinistrosRecife2020Raw, sinistrosRecife2021Raw)

# observa a estrutura dos dados
str(sinistrosRecifeRaw)


# modifca a data para formato date
sinistrosRecifeRaw$data <- as.Date(sinistrosRecifeRaw$data, format = "%Y-%m-%d")

# modifica para fator as variaveis 'natureza do sinistro', 'situacao' e 'endereco'

sinistrosRecifeRaw$natureza_acidente <- as.factor(sinistrosRecifeRaw$natureza_acidente)

sinistrosRecifeRaw$situacao <- as.factor(sinistrosRecifeRaw$situacao)

sinistrosRecifeRaw$endereco <- as.factor(sinistrosRecifeRaw$endereco)


naZero <- function(x) {
  x <- ifelse(is.na(x), 0, x)
}


# exporta em formato nativo do R
saveRDS(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.rds")

# exporta em formato tabular (.csv) - padrão para interoperabilidade
write.csv2(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.csv")
