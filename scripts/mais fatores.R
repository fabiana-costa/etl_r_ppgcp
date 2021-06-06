install.packages('ade4')
library(ade4)

install.packages('arules')
library(arules)

install.packages('forcats')
library(forcats)

censo_CURSO_2016 <- read.table('bases_originais/DM_CURSO.CSV', sep = '|', header = TRUE)
str(censo_CURSO_2016)

# conversão em fatores



for(i in 17:19) {censo_CURSO_2016[,i] <- as.factor(censo_CURSO_2016[,i])}

str(censo_CURSO_2016)

# filtro por tipo de dado

factorsCenso <- unlist(lapply(censo_CURSO_2016, is.factor))  
censoFactor <- censo_CURSO_2016[ , factorsCenso]
str(censoFactor)

censoFactor <- discretize(censoFactor, method = "interval", breaks = 3, labels = c('mais frequente', 'segundo mais frequente', 'outros'))

# One Hot Encoding
censoDummy <- acm.disjonctif(censoFactor)

# Discretização
inteirosCenso <- unlist(lapply(censo_CURSO_2016, is.integer))  
censoInteiros <- censo_CURSO_2016[, inteirosCenso]
str(censoInteiros)

censoInteiros$QT_VAGAS_ANUAL_EAD <- discretize(censoInteiros$QT_VAGAS_ANUAL_EAD, method = "interval", breaks = 3, labels = c('mais frequente', 'segundo mais frequente', 'outros'))

