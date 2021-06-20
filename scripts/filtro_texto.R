library(dplyr)
install.packages("fuzzyjoin")
library(fuzzyjoin)

aluno <- c("João", "Alice", "Antônio", "Juan", "Evelyn", "hudson", "Aline", "Ícaro", "José", "Bárbara")

sexo <- c("masculino", "feminino", "masculino", "masculino", "feminino","masculino", "feminino", "masculino","masculino", "feminino")

instituicao <- c("UNIVERSIDADE DE BRASÍLIA", "UNIVERSIDADE FEDERAL DO PIAUÍ", "UNIVERSIDADE FEDERAL DO PARANÁ", "UNIVERSIDADE FEDERAL DO RIO DE JANEIRO", "UNIVERSIDADE FEDERAL DA PARAÍBA", "UNIVERSIDADE FEDERAL DA BAHIA", "UNIVERSIDADE FEDERAL DE PERNAMBUCO", "UNIVERSIDADE FEDERAL DE UBERLÂNDIA", "UNIVERSIDADE FEDERAL DA BAHIA", "UNIVERSIDADE FEDERAL DE PERNAMBUCO")

situacao <- c("Cursando", "Cursando", "Desvinculado", "Transferido", "Matrícula trancada", "Cursando", "Cursando", "Cursando", "Desvinculado", "Transferido")

banco <- data.frame(aluno, sexo, instituicao, situacao)

  
aluno <- c("joao", "alice", "antonio", "juan", "Hevellyn", "hudson", "Aline", "icaro", "jose maria", "barbara")

turno <- c("matutino", "verspertino", "noturno", "matutino", "verspertino", "noturno", "matutino", "verspertino", "noturno", "noturno")

banco2 <- data.frame(aluno, turno)

banco3 <- fuzzyjoin::stringdist_join(banco, banco2, mode='left')

vinculo <- c("Cursando", "Matrícula trancada")

banco3 <- banco3 %>% mutate(evento = ifelse(grepl(paste(vinculo, collapse="|"), situacao), 'nao_evadido', 'evadido'))  
  
  
  
  



