# tabelas da wikipedia
url <- "https://www.trt.net.tr/portuguese/covid19"

urlTables <- url %>% read_html %>% html_nodes("table")

coronaTable <- as.data.frame(html_table(urlTables[]))
