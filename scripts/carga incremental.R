library(dplyr)

# carregando base de dados original
atendimentoEmlurb <- read.csv2('http://dados.recife.pe.gov.br/dataset/93273993-d92c-4162-8c4a-66c930590c31/resource/5c59ee3b-ec1b-4acf-b266-fe9d3306322d/download/156_cco_2021.csv', sep = ';', encoding = 'UTF-8')


# carregando base de dados para atualização
novo_atendimentoEmlurb <- read.csv2('http://dados.recife.pe.gov.br/dataset/93273993-d92c-4162-8c4a-66c930590c31/resource/5c59ee3b-ec1b-4acf-b266-fe9d3306322d/download/156_cco_2021.csv', sep = ';', encoding = 'UTF-8')


# comparação usando a chave substituta
# criando a chave substituta
atendimentoEmlurb$chaveSubstituta = apply(atendimentoEmlurb[, c(6,9,10)], MARGIN = 1, FUN = function(i) paste(i, collapse = ""))


novo_atendimentoEmlurb$chaveSubstituta = apply(novo_atendimentoEmlurb[, c(6,9,10)], MARGIN = 1, FUN = function(i) paste(i, collapse = ""))


# criando base de comparação
atendimentoEmlurb_Incremento <- (!novo_atendimentoEmlurb$chaveSubstituta %in% atendimentoEmlurb$chaveSubstituta)


# retorna vetor com incremento
atendimentoEmlurb[atendimentoEmlurb_Incremento,]

# junta base original e incremento
atendimentoEmlurb_final <- rbind(atendimentoEmlurb, atendimentoEmlurb[atendimentoEmlurb_Incremento,])



