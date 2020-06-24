library(tidyverse)

#install.packages("sf")##
library(sf)

#cargar shapes###
shp <- st_read("input/geo_data/COMUNA_C17.shp")
glimpse(shp)


ggplot(shp)+geom_sf()


library(readr)
##install.packages("here")
library(here)


datoscomunas <- read_rds(here("input","data_comunas.rds"))

names(datoscomunas)
names(shp)
unique(shp$NOM_COMUNA)
unique(datoscomunas$municipality)

shp_data <- shp %>%
  left_join(datoscomunas,by=c("NOM_COMUNA"="municipality"))
names(shp_data)  
head(shp_data)

colnames(shp_data)[19] <- "Indice_Pobreza_Casen"

#install.packages("ggthemes")
library(ggthemes)

plot1 <- ggplot(shp_data)+theme_classic()+ geom_sf(aes(fill= Indice_Pobreza_Casen)) +
  #scale_fill_gradient(low = "yellow", high = "red")
  scale_fill_viridis_c() +
  labs(title = "Pobreza Región del BioBio",
       caption = "source: SINIM, 2019")
ggsave(plot = plot1, filename ="output/Pobreza_BB.png",
       width = 12, height = 12)  

                         