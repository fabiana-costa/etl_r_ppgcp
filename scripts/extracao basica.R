# extraindo um arquivo de texto que contém 64 emails

emails <- read.table("https://archive.ics.uci.edu/ml/machine-learning-databases/00219/", header = FALSE, sep = ',')
str(emails)


# extraindo um arquivo xml com cursos da Washingto State University

courses_wsu <- xmlToDataFrame("http://aiweb.cs.washington.edu/research/projects/xmltk/xmldata/data/courses/wsu.xml")


# extraindo um arquivo json sobre UBS's

dadosUBS <- fromJSON(file= "http://dados.recife.pe.gov.br/dataset/39d3ab40-573d-42e7-b96e-0cc051695391/resource/2f4e51bf-4aaf-47ef-ac4d-59690c685ecd/download/metadados-de-unidedes-basicas-saude.json" )












