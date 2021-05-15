library(ff)


# criando o arquivo ff

system.time(extracao3 <- read.csv.ffdf(file='bases_originais/Base_Oficial_2014.csv', sep = ';', header = FALSE)) 

class(extracao3) # veja a classe do objeto

object.size(extracao3) # a vantagem está no tamanho! 101648144 bytes contra 638856008 anteriores.


# Duas operações estatística (média e variância)

mean(enem2014$NU_NOTA_REDACAO) 
var(enem2014$NU_NOTA_REDACAO)


# Uma operação de inferência estatística

cor.test(enem2014$NU_NOTA_REDACAO, enem2014$renda_pc)
