library(dplyr)

install.packages('pdftools')
library(pdftools)

install.packages('textreadr')
library(textreadr)

library(stringr)

#ler PDF
ementa <- read_pdf('documentos/ementa.pdf', ocr = T)

# agrupar páginas em 1 doc: 1) agrupa por id 2) cria nova coluna colando a coluna texto na mesma linha 3) seleciona apenas colunas de interesse 4) remove duplicata
ementa2 <- ementa %>% group_by(element_id) %>% mutate(all_text = paste(text, collapse = " | ")) %>% select(element_id, all_text) %>% unique()

# extrai as datas de forma automática
( datas <- str_extract_all(ementa2$all_text, "\\d{2}/\\d{2}") ) 

# modifica um padrão # substituindo barar (/) por (-)
str_replace_all(string = ementa2, pattern = "/", replacement = "-") 


