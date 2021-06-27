library(zoo) 
library(dplyr)

library(plotly)

install.packages('drc')
library(drc)

install.packages("xts")
library(xts)

url = 'https://raw.githubusercontent.com/wcota/covid19br/master/cases-brazil-states.csv' # passar a url para um objeto
covidBR = read.csv2(url, encoding='latin1', sep = ',') # baixar a base de covidBR

covidPE <- subset(covidBR, state == 'PE') # filtrar para Pernambuco

str(covidPE) # observar as classes dos dados

covidPE$date <- as.Date(covidPE$date, format = "%Y-%m-%d") # modificar a coluna data de string para date

str(covidPE) # observar a mudança na classe

covidPE$dia <- seq(1:length(covidPE$date)) # criar um sequencial de dias de acordo com o total de datas para a predição

predDia = data.frame(dia = covidPE$dia) # criar vetor auxiliar de predição
predSeq = data.frame(dia = seq(max(covidPE$dia)+1, max(covidPE$dia)+30)) # criar segundo vetor auxiliar 

predDia <- rbind(predDia, predSeq) # juntar os dois 

install.packages('drc')
library(drc) # pacote para predição

fitLL <- drm(deaths ~ dia, fct = LL2.5(),
             data = covidPE, robust = 'mean') # fazendo a predição log-log com a função drm

plot(fitLL, log="", main = "Log logistic") # observando o ajuste

predLL <- data.frame(predicao = ceiling(predict(fitLL, predDia))) # usando o modelo para prever para frente, com base no vetor predDia
predLL$data <- seq.Date(as.Date('2020-03-12'), by = 'day', length.out = length(predDia$dia)) # criando uma sequência de datas para corresponder aos dias extras na base de predição

predLL <- merge(predLL, covidPE, by.x ='data', by.y = 'date', all.x = T) # juntando as informações observadas da base original 

library(plotly) # biblioteca para visualização interativa de dados

plot_ly(predLL) %>% add_trace(x = ~data, y = ~predicao, type = 'scatter', mode = 'lines', name = "Mortes - Predição") %>% add_trace(x = ~data, y = ~deaths, name = "Mortes - Observadas", mode = 'lines') %>% layout(
  title = 'Predição de Mortes de COVID 19 em Pernambuco', 
  xaxis = list(title = 'Data', showgrid = FALSE), 
  yaxis = list(title = 'Mortes por Dia', showgrid = FALSE),
  hovermode = "compare") # plotando tudo junto, para comparação

install.packages('zoo')
library(zoo) # biblioteca para manipulação de datas e séries temporais
library(dplyr)

covidPE <- covidPE %>% mutate(deathsMM7 = round(rollmean(x = deaths, 7, align = "right", fill = NA), 2)) # média móvel de 7 dias

covidPE <- covidPE %>% mutate(deathsL7 = dplyr::lag(deaths, 7)) # valor defasado em 7 dias

plot_ly(covidPE) %>% add_trace(x = ~date, y = ~deaths, type = 'scatter', mode = 'lines', name = 'Mortes') %>% add_trace(x = ~date, y = ~deathsMM7, name = "Mortes MM7", mode = 'lines') %>% layout(
  title = 'Mortes por COVID19 em Pernambuco e Media móvel', 
  xaxis = list(title = 'Data', showgrid = FALSE), 
  yaxis = list(title = 'Mortes por Dia', showgrid = FALSE),
  hovermode = "compare") # plotando tudo junto, para comparação


(covidPETS <- xts(covidPE$deaths, covidPE$date)) # transformar em ST
str(covidPETS)

autoplot(covidPETS)
acf(covidPETS)






