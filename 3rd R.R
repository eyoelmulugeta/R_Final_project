library(tidyr)
library(plyr)
library(dplyr)
library(tidyverse)
library(readxl)
library(lubridate)
library(ggplot2)
rm(list =ls())

setwd("~/Documents/Data 331")
df_student = read_excel("Student.xlsx" , .name_repair ="universal")
df_registration = read_excel("Registration.xlsx" , .name_repair ="universal")
df_course = read_excel("Course.xlsx" , .name_repair ="universal")

#joindata

all_df = df_student%>%
  left_join(df_registration, by = c("Student.ID"))%>%
  left_join(df_course, by = c("Instance.ID"))
CSStudnets =all_df%>%
  dplyr::filter(Title== "Computer Science")

all_payment_plan_students= all_df%>%
  dplyr::filter(Payment.Plan == "TRUE")

first_quarter_class_options = all_df%>%
  dplyr::filter(Start.Date>="2021-09-01 ")%>%
  dplyr::filter(End.Date<="2021-12-30")

Total_Balance_By_Plan =all_df%>%
  group_by(Payment.Plan)%>%
  summarise(TotalBalance.Due= sum(Balance.Due))

Total_Cost_By_Major = all_df%>%
  group_by(Title)%>%
  summarise(Total.Cost = sum(Cost))

barplot(Total_Cost_By_Major$Total.Cost) 



  