library(funModeling)

censo_CURSO_2016 <- read.csv2('bases_originais/DM_CURSO.CSV', sep = '|')

status(censo_CURSO_2016)

(censoNASeed <- round(runif(10, 1, 50))) # criamos 10 valores aleatórios


## Hot deck
# imputação aleatória
censo_CURSO_2016$QT_VAGAS_NOTURNO_PRES[censoNASeed] <- NA # recolocamos os NA

(censo_CURSO_2016$QT_VAGAS_NOTURNO_PRES <- impute(censo_CURSO_2016$QT_VAGAS_NOTURNO_PRES, "random")) # fazemos a imputação aleatória



# tendência central
install.packages('Hmisc')
library(Hmisc) # biblio que facilita imputação de tendência central

censo_CURSO_2016$QT_VAGAS_NOTURNO_PRES <- impute(censo_CURSO_2016$QT_VAGAS_NOTURNO_PRES, fun = mean) # média

censo_CURSO_2016$QT_VAGAS_NOTURNO_PRES <- impute(censo_CURSO_2016$QT_VAGAS_NOTURNO_PRES, fun = median) # mediana


is.imputed(censo_CURSO_2016$QT_VAGAS_NOTURNO_PRES) # teste se o valor foi imputado
table(is.imputed(censo_CURSO_2016$QT_VAGAS_NOTURNO_PRES)) # tabela de imputação por sim / não


