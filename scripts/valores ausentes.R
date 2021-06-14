library(funModeling)

censo_CURSO_2016 <- read.csv2('bases_originais/DM_CURSO.CSV', sep = '|')

status(censo_CURSO_2016) #identificando valores ausentes

x <- as.data.frame(abs(is.na(censo_CURSO_2016))) # cria a matrix sombra
head(x) # observa a matriz sombra

y <- x[which(sapply(x, sd) > 0)] # mantém apenas variáveis que possuem NA
cor(y) # observa a correlação entre variáveis

