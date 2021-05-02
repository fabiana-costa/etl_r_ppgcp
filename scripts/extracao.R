ls() # lista todos os objetos no R

# Visualizando quanto cada objeto está ocupando

for (itm in ls()) { 
  print(formatC(c(itm, object.size(get(itm))), 
                format="d", 
                width=30), 
        quote=F)
} 

 
# Os objetos que mais usavam memória do R era a base de dados original 2019 e a base final que reúne 3 anos de dados

rm(list=(ls()[ls()!="sinistrosRecifeRaw" & ls() != "naZero"]))


saveRDS(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.rds")

write.csv2(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.csv")