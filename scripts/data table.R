library(data.table)
library(dplyr)

enem_2014 <- read.csv2('bases_originais/Base_Oficial_2014.csv', sep = ';')

enem_pe <- enem_2014 %>% 
  filter(COD_UF_RESIDENCIA == 26)

DTenem_pe <- enem_pe %>% setDT()
class(DTenem_pe)

regressao <- DTenem_pe[ , summary(lm(formula = nota_media ~ renda_pc + preto + pardo + amarelo + indigena + federal + estadual + municipal + sexo))]
