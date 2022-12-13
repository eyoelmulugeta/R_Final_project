library(tidyr)
library(plyr)
library(dplyr)
library(tidyverse)
library(readxl)
library(lubridate)
library(ggplot2)
library(hrbrthemes)
library(viridis)
library(tidyverse)
library(dplyr)
library(readxl)
library(lubridate)
library(readr)
library(ggplot2)

library(ggthemes)
library(ggpmisc)
library(ggpubr)
library(maps)

library(usmap)



rm(list =ls())

setwd("~/Documents/Data 331")
df_1= read_excel("Cleaned Data LWA .xlsx" , .name_repair ="universal")
df_2= read_excel("CompletePierisData_2022-03-09.xlsx" , .name_repair ="universal")


#change df_2 column name
colnames(df_1)[1] = "core ID"
colnames(df_1)[8] = "RW apex A"
colnames(df_2)[1] = "core ID"
colnames(df_2)[12] = "sex"
colnames(df_2)[17] = "LW apex A"
colnames(df_2)[21] = "RW length"
colnames(df_2)[22] = "RW width"
colnames(df_2)[23] = "RW apex A"
colnames(df_2)[31] = "Day"
colnames(df_2)[32] = "Month"
colnames(df_2)[33] = "Year"
colnames(df_2)[42] = "Country"
colnames(df_2)[43] = "State or Province"
colnames(df_2)[47] = "Lattitude"
colnames(df_2)[48] = "Longitude"
colnames(df_2)[18] = "LAnteriorSpot"
colnames(df_2)[24] = "RAnteriorSpot"


df_2$Date = paste(df_2$Year, df_2$Month, df_2$Day, sep = "-")
df_2$Date = ymd(df_2$Date)


#joining the Data


df=df_2%>%
  dplyr::mutate(sex= ifelse((sex == "f")|(sex == "F?")|(sex == "female")|(sex == "F")|(sex == "Females"), "Female", sex))%>%
  dplyr::mutate(sex= ifelse((sex == "M")|(sex == "male")|(sex == "male?"), "Male", sex))%>%
  dplyr::mutate(Country= ifelse((Country== "U.S.A.")|(Country=="USA"), "United States", Country))%>%
  dplyr::select('core ID', "Date","Day", "Month", "Year", 'Country',"State or Province", "LAnteriorSpot", "RAnteriorSpot", 'Longitude', "Lattitude")%>%
  left_join(df_1, by = c('core ID'))


#drop the na values 
df_1=df_1%>% drop_na()
df_2=df_2%>% drop_na()


#Finding Average of the length,width,apex and anterior

df_3= df_1 %>%
  left_join(df, by = c('core ID'))%>%
  mutate(AverageWingLength = (`LW.length.x`+ `RW.length.x`)/2)%>%
  mutate(AverageWingWidth = (`LW.width.x` + `RW.width.x`)/2)%>%
  mutate(AverageApexArea = (`LW.apex.A.x` + `RW apex A.x`)/2)%>%
  mutate(AverageAnteriorSpotA = (as.numeric(`LAnteriorSpot`) +
                                   as.numeric(`RAnteriorSpot`))/2)
df_3$Year = as.numeric(df_3$Year)

colnames(df_3)[2] = "sex"

#plotting the average by sex 
wing_length_plot = df_3%>% 
  ggplot(aes(x = Date, y = AverageWingLength, color = sex)) +
  scale_linetype_manual(values = c("solid", "dashed"))+ 
  geom_line(aes(linetype = sex), size = 1.4, alpha = 0.9) + 
  scale_x_date(date_breaks = "10 years", date_labels = "%Y") +
  scale_color_manual(values=c("green", "red","green"))+
  labs(title = "Average Wing Length of Insects",
       subtitle = "The Effect of Winglength on Sex in a Span of Ten Years",
       x = "Year (every 10 years)",
       y = "Average Wing Length",
       color = "sex")+ theme(axis.line.x = element_line(color = "purple", size = 0, linetype = "dashed"),
                                             axis.line.y = element_line(color = "pink", size =0, linetype = "dotted"),
                                             legend.position = "bottom",
                                             legend.title = element_text(face = "bold"))
wing_length_plot

wing_width_plot = df_3 %>%
  ggplot(aes(x = Date, y = AverageWingWidth, color = sex)) +
  geom_point() +stat_smooth(mapping = NULL, data = NULL, geom = "smooth",
                            position = "identity", method = "auto", formula = y ~ x,
                            se = TRUE, n = 80, span = 0.75, fullrange = FALSE, level = 0.95,
                            method.args = list(), na.rm = FALSE, show.legend = NA,
                            inherit.aes = TRUE)+
  scale_color_manual(values=c("purple", "orange","green"))+
  scale_x_date(date_breaks = "10 years", date_labels = "%Y") +
  labs(title = "Average Wing width of Insects",
       subtitle ="The Effect of Wingwidth on Sex in a Span of Ten Years",
       x = "Year (Decades)",
       y = "Average Wing width",
       color = "sex")
wing_width_plot

apex_area_plot = df_3 %>%
  ggplot(aes(x = Date, y = AverageApexArea, color = sex)) +
  geom_boxplot(varwidth=T, fill="plum")+
  geom_smooth(method = glm, se = FALSE, fullrange = TRUE)+
  scale_x_date(date_breaks = "10 years", date_labels = "%Y") +
  labs(title = "Average Apex Area of Insects",
       subtitle = "The Effect of Wingwidth on Sex in a Span of Ten Years" ,
       x = "Year (Decades)",
       y = "Average Apex Area",
       color = "sex") +
  theme_dark()

apex_area_plot

all_plot = ggarrange(wing_length_plot, wing_width_plot, apex_area_plot,
                          ncol = 2, nrow = 2)
all_plot

#Map-making plot
world= map_data("world")
world_plot =  df_3 %>%
  ggplot() +
  geom_map(
    data = world, map = world,
    aes(long, lat, map_id = region),
    color = "black", fill = "darkgreen", size = 0.1) +
  geom_point(
    data = df_3,
    aes(x = Longitude, y = Lattitude,
        color = sex),
    alpha = 6) +
  labs(x = NULL, y = NULL, color = NULL)+ guides(fill = guide_legend(title = "Title"))+
  theme_dark() +
  theme(legend.position = "middle")+
  labs(title="Location of Insects")

world_plot  
#mapping USA

df_just_usa = df_3 %>%
  dplyr::filter(Country == "United States")

usa = map_data("state")
usa_plot = ggplot() +
  geom_map(
    data = usa, map = usa,
    aes(long, lat, map_id = region),
    color = "black", fill = "darkgreen", size = 0.1) +
  geom_point(
    data = df_3,
    aes(x = Longitude, y = Lattitude,
        color = sex),
    alpha = 5, size = 4) +
  labs(x = NULL, y = NULL, color = NULL)+
  theme_dark() +
  theme(legend.position = "middle")+
  labs(title="Locations of Insects In United States")


usa_plot

InsectMeasurments = c(df_3$AverageWingLength, df_3$AverageWingWidth, df_3$AverageApexArea, df_3$AverageAnteriorSpotA)
country_plot = df_3%>%
  gather(InsectMeasurments, Length, 19:22)%>%
  group_by(Country, InsectMeasurments)%>%
  summarise(mnl = round(mean(Length), digits=3), sdl = round(sd(Length), digits=3))%>%
  ggplot(aes(reorder(Country, mnl),mnl, fill = reorder(InsectMeasurments,mnl))) +
  geom_bar(stat = "identity", position = "dodge")+
  geom_text(mapping = aes(label=mnl),position = position_dodge(width = 0.9),
            cex = 2.5, vjust = -4)+
  labs(title = "Insect Wing Measurments in different Countries",
       subtitle = "Wing Length, Width, and Area grouped by Countries",
       x = "Country", y = "Length in mm",
       caption = "cabbage-butterfly dataset", fill = "Description: ")+
  geom_errorbar(mapping = aes(ymin = round(mnl-sdl, digits = 3), ymax = mnl+sdl),
                width = 0.2, position = position_dodge(width = 0.9))+
  theme_bw()

country_plot

apex_area_t_test = t.test(df_3$AverageApexArea ~ df_3$sex,data = df_3, var.equal = TRUE)
apex_area_t_test
wing_length_t_test = t.test  
