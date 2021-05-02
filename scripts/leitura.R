library(microbenchmark)

install.packages('readxl')
library(readxl)

 
install.packages("foreign")
library(foreign)

# exporta em formato nativo do R
saveRDS(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.rds")

# exporta em formato tabular (.csv) - padrÃ£o para interoperabilidade
write.csv2(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.csv")

# exporta em formato excel (.xlsx, .xls)
write.table(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.xlsx", sep="\t")


# carrega base de dados em formato nativo R
sinistrosRecife <- readRDS('bases_tratadas/sinistrosRecife.rds')

# carrega base de dados em formato tabular (.csv) - padrÃ£o para interoperabilidade
sinistrosRecife <- read.csv2('bases_tratadas/sinistrosRecife.csv', sep = ';')

# Carrega base de dados em formato excel (.xlsx)
sinistrosRecife <-read_excel(("bases_tratadas/sinistrosRecife.xlsx"),sheet=1)



# compara os dois processos de exportaÃ§Ã£o, usando a funÃ§Ã£o microbenchmark

microbenchmark(a <- saveRDS(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.rds"), b <- write.csv2(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.csv"), c <- write.table(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.xlsx", sep="\t"), times = 30L)

microbenchmark(a <- readRDS('bases_tratadas/sinistrosRecife.rds'), b <- read.csv2('bases_tratadas/sinistrosRecife.csv', sep = ';'), c <- read_excel(("bases_tratadas/sinistrosRecife.xlsx"),sheet=1), times = 10L)

# Quanto a vantagens e desvantagens dos formatos nativo e plano com interoperabilidade, observa-se que o primeiro gera arquivos menores e por isso exige menor custo computacional, por outro lado, ele só pode lido em software específico (R). Já o segundo tipo apresenta maiores arquivos que implica maior custo computacional, porém para sua operacionalização vários softwares podem ser utilizados.






