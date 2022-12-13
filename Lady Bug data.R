library(tidyr)
library(plyr)
library(dplyr)
library(tidyverse)
library(readxl)
library(lubridate)
library(ggplot2)
library(hrbrthemes)
library(viridis)
rm(list =ls())

setwd("~/Documents/Data 331")
df_ladybug = read_excel("Ladybug Data.xlsx" , .name_repair ="universal")
df_scanladybug= read_excel("Scan Ladybug Data.xlsx" , .name_repair ="universal")

colnames(df_ladybug)[8] ="scan.code"
colnames(df_scanladybug)[8]="scan.code"

#joining the Data 
scantwo = left_join(df_ladybug,df_scanladybug%>% dplyr::select(scan.code,genus), by = "scan.code" )

#cleandata 
#change species name 


df_ladybug$date = ymd(df_ladybug$date)

df_ladybug= df_ladybug%>%
  dplyr::mutate(Species = ifelse((Species =='Coccinella semtempuncta')|(Species == 'coccinella semptempuncata')|(Species == 'coccinella septempunctata')|(Species == 'Coccinella septempunctata')|(Species == "Coccinella semtempuncata"), "Coccinella Septempunctata", Species))%>%
  dplyr::mutate(Species = ifelse((Species == 'cycloneda munda') | (Species =='Cycloneda Munda'), 'Cycloneda munda', Species))%>%
  dplyr::mutate(Species = ifelse((Species == 'Harminia axyridis')|(Species == 'harmonia axyrids')|(Species == 'Harmonia axyrisis')|(Species == "Harmonia axyridis")|(Species == 'harmonia axyridis'),  "Harmonia Axyridis",Species))%>%
  dplyr::mutate(Species = ifelse((Species == "hippodamia convergens") |(Species == "Hippodamia covergence")|(Species == "Hippodamia convergens"), "Hippodamia Convergens", Species))%>%
  dplyr::mutate(Species = ifelse((Species == "Propylea quatuordecimpunctata")|(Species == "Propylea quatuordecimpuncata ")|(Species == "Propylea quatuordecimpuncata"), "Propylea Quatuordecimpunctata", Species))%>%
  dplyr::mutate(Species = ifelse((Species == "Colemegilla maculata")|(Species == "coleomegilla maculata")|(Species == "Coleomegilla maculata"), "Coleomegilla Maculata", Species))%>% 
  dplyr::mutate(Species = ifelse((Species == "hippodamia parenthesis")|(Species == "Hippodamia parenthesis"), 'Hippodamia Parenthesis',Species))
  
#change people names

df_ladybug= df_ladybug%>% 
  dplyr::mutate(collector= ifelse((collector== 'J Hughes')|(collector =='J. Hughees')|(collector== 'j. hughes')|(collector== 'j. Hughes')|(collector== 'J. hughes')|(collector== 'jack hughes')|(collector== 'J. Hughes'),"Jack Hughes", collector))%>%
  dplyr::mutate(collector= ifelse((collector== "m gorsegner")|(collector =="M. Gorsegner")|(collector== "m. gorsegner")|(collector== "M. gorsegner")|(collector== "M.Gorsegner"), "Marissa Gorsegner",collector))%>%
  dplyr::mutate(collector= ifelse((collector== 'O. Ruffatto')|(collector== 'o. ruffattto')|(collector== 'o. ruffatto')|(collector== 'O. ruffatto')|(collector== 'OliviaRuffatto'), "Olivia Ruffatto", collector))%>%
  dplyr::mutate(collector= ifelse((collector== 'v cervantes')|(collector== 'V. Cervantes')|(collector== 'v. cervantes')|(collector== 'V. cervantes')|(collector== 'V.Cervantes')|(collector== 'VeronicaCervatnes'), "Veronica Cervantes",collector))%>%
  dplyr::select('Species','plot','A_E_V','date','coordinates','collector','identifier','scan.code')


df_ladybug= df_ladybug%>% 
  dplyr::mutate(identifier= ifelse((identifier== 'J Hughes')|(identifier =='J. Hughees')|(identifier== 'j. hughes')|(identifier== 'j. Hughes')|(identifier== 'J. hughes')|(identifier== 'jack hughes')|(identifier== 'J. Hughes'),"Jack Hughes", identifier))%>%
  dplyr::mutate(identifier= ifelse((identifier== "m gorsegner")|(identifier== "m. Gorsegner")|(identifier =="M. Gorsegner")|(identifier== "m. gorsegner")|(identifier== "M. gorsegner")|(identifier== "M.Gorsegner"), "Marissa Gorsegner",identifier))%>%
  dplyr::mutate(identifier= ifelse((identifier== 'O. Ruffatto')|(identifier== "O Ruffatto ")|(identifier== "O RUffatto ")|(identifier== "O Ruffatto ")|(identifier== "O RUffatto ")|(identifier== 'o. ruffattto')|(identifier== 'o. ruffatto')|(identifier== 'O. ruffatto')|(identifier== "O Ruffatto")|(identifier== "O RUffatto")|(identifier== 'OliviaRuffatto'), "Olivia Ruffatto", identifier))%>%
  dplyr::mutate(identifier= ifelse((identifier== 'v cervantes')|(identifier== 'V. Cervantes')|(identifier== 'v. cervantes')|(identifier== 'v. Cervantes ')|(identifier== 'V. cervantes')|(identifier== 'V.Cervantes')|(identifier== "v. Cervantes")|(identifier== 'VeronicaCervatnes'), "Veronica Cervantes",identifier))%>%
  dplyr::select('Species','plot','A_E_V','date','coordinates','collector','identifier','scan.code') 
  
#species count by identifier

df_identifier_count= df_ladybug %>%
  dplyr::count(Species, identifier)%>%
  drop_na()

df_identifier_count%>%
  ggplot(aes(x= Species, y = n, fill = identifier))+
  geom_col()+
  coord_flip()+
  facet_wrap(~ identifier)+
  labs(x = 'Species', y = "count")

scantwo$plot=substr(scantwo$plot,1,5)

df_plot_count = scantwo %>%
  count(plot)

df_plot_count %>%
  ggplot(aes(x= plot, y=n, fill = plot)) +
  geom_col()+
  coord_flip() + 
  labs(x="plot", y="Count")

#species by plot
df_ladybug$plot=substr(df_ladybug$plot,1,5)

df_species_count = df_ladybug %>%
  count(Species, plot)

df_species_count %>%
  ggplot(aes(x = Species, y= n , fill = plot )) +
  scale_color_manual(values=c("purple", "orange","green","yellow","pink","red"))+
  geom_col() +
  coord_flip() +
  facet_wrap(~ plot) +
  labs(x="Species", y = "Count")

#plot genus by month

df_species_by_month= df_scanladybug %>%
  count(genus, month)

df_species_by_month%>%
  ggplot(aes(x = genus, y= n , fill = month, group_by=(month) )) +
  geom_col(aes(color=month)) +
  coord_flip() +
  labs(x="Genus", y = "Count")

  


















  
  
  
  
  
  
  