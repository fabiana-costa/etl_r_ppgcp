library(data.table)


enem_2014 <- read.csv2('bases_originais/Base_Oficial_2014.csv', sep = ';')


object.size(enem_2014) # 638856008 bytes


str(enem_2014) # 'data.frame':	1275285 obs. of  103 variables


# extração via amostragem com read.csv

# ler apenas as primeiras 20 linhas
amostra1 <- read.csv2('bases_originais/Base_Oficial_2014.csv', sep = ';', header = FALSE, nrows=20)  

amostra1Classes <- sapply(amostra1, class) # encontra a classe da amostra amostra

# fazemos a leitura passando as classes de antemão, a partir da amostra
system.time(extracao1 <- data.frame(read.csv2('bases_originais/Base_Oficial_2014.csv', sep = ';', header = FALSE, colClasses=amostra1Classes) ) )  

str(extracao1)

# extração via função fread, que já faz amostragem automaticamente
system.time(extracao2 <- fread('bases_originais/Base_Oficial_2014.csv', sep = ';')) 

str(extracao2)


