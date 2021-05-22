library(ff)
library(ffbase)


ResultadoFinal2011 <- read.csv.ffdf(file='bases_originais/situacaofinalalunos2011.csv', sep = ';', header = T)

ResultadoFinal2012 <- read.csv.ffdf(file='bases_originais/situacaofinalalunos2012.csv', sep = ';', header = T)

ResultadoFinal2013 <- read.csv.ffdf(file='bases_originais/situacaofinalalunos2013.csv', sep = ';', header = T)

ResultadoFinal2014 <- read.csv.ffdf(file='bases_originais/situacaofinalalunos2014.csv', sep = ';', header = T)

ResultadoFinal2015 <- read.csv.ffdf(file='bases_originais/situacaofinalalunos2015.csv', sep = ';', header = T)

ResultadoFinal2016 <- read.csv.ffdf(file='bases_originais/situacaofinalalunos2016.csv', sep = ';', header = T)

ResultadoFinal2017 <- read.csv.ffdf(file='bases_originais/situacaofinalalunos2017.csv', sep = ';', header = T)

ResultadoFinal2018 <- read.csv.ffdf(file='bases_originais/situacaofinalalunos2018.csv', sep = ';', header = T)

ResultadoFinal2019 <- read.csv.ffdf(file='bases_originais/situacaofinalalunos2019.csv', sep = ';', header = T)

ResultadoFinal2020 <- read.csv.ffdf(file='bases_originais/situacaofinalalunos2020.csv', sep = ';', header = T)


situacao_final_alunos <- ffdfrbind.fill(ResultadoFinal2011,ResultadoFinal2012,ResultadoFinal2013,ResultadoFinal2014,ResultadoFinal2015,ResultadoFinal2016,ResultadoFinal2017,ResultadoFinal2018,ResultadoFinal2019,ResultadoFinal2020)

ls()

rm(list=(ls()[ls()!="situacao_final_alunos"]))

saveRDS(situacao_final_alunos, "bases_tratadas/situacao_final_alunos.rds")

