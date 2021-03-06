install.packages("geobr")
library(geobr)
library(tidyverse)
library(stringr)

# GEOBR - Pol�gonos do Mapa
ceara<-read_municipality(code_muni = "CE")
# Ajuste nos nomes das cidades
ceara$name_muni<-str_to_lower(ceara$name_muni) %>% abjutils::rm_accent()
# Importando os dados
relatorio<-read.csv("MapaR.csv",header = TRUE,sep = ",",encoding = "UTF-8")
names(relatorio)<-c("name_muni","Situa��o")
# Ajuste nos nomes das cidades
relatorio$name_muni<-str_to_lower(relatorio$name_muni) %>% abjutils::rm_accent()

# Juntando as duas bases, a dos pol�gonos com a dos dados
dados<-left_join(ceara,relatorio,by="name_muni")
cores<-c("white","red","orange","green","yellow")
# Gerando o Mapa
dados %>% ggplot() + geom_sf(aes(fill=Situa��o)) + scale_fill_manual(values = cores) + theme_bw() +
  ggtitle("Situa��o das Respostas \nE-SIC") + theme(plot.title = element_text(hjust = 0.5))

