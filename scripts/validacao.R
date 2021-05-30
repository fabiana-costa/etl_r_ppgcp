library(data.table)
library(dplyr)
library(tidyverse)
library(funModeling)
install.packages('validate')
library(validate)

# Base de dados referente ao censo dos cursos de nível superior em 2016
censo_CURSO_2016 <- read.csv2('bases_originais/DM_CURSO.CSV', sep = '|')

# Filtrando apenas os cursos de Universidades públicas federais e selecionando variáveis
censo_curso <- censo_CURSO_2016 %>% filter(CO_CATEGORIA_ADMINISTRATIVA ==1, 
                                           CO_ORGANIZACAO_ACADEMICA == 1) %>% 
  select("NO_IES", "NO_CURSO", "IN_MATERIAL_DIGITAL", "NU_CARGA_HORARIA")

# Verificando valores ausentes na base
status(censo_curso)

# Retirando os casos ausentes nas variáveis "material digital" e "carga horária"
censo_curso <- censo_curso %>% filter(IN_MATERIAL_DIGITAL>=0,
                                      NU_CARGA_HORARIA >0)

regras_censo_curso <- validator(IN_MATERIAL_DIGITAL>=0,
                                NU_CARGA_HORARIA >0)

validacao_censo_curso <- confront(censo_curso, regras_censo_curso)

summary(validacao_censo_curso)

plot(validacao_censo_curso)

