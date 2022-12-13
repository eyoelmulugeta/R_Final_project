# R_Final_project
# BY: EYOEL MULUGETA AND BLEN BUTICHO
# Data_331 Final project 

# Overview
The biology department at Augustana College provided the two xslx data (ladybug, scan ladybug).Utilizing the information we learned in class, we conducted our analysis using specific variables. In our first analysis (Ladybug) we used: Species, Genus, Scan Code,Collector, Identifier, Country, State Plot, A_E_V,  and Date. For our second analysis (cabbage butterfly) we used: Location, Date, Wing length/width, Apex Area, Left anterior Spot  
 Right anterior Spot, Longitude, Latitude.
 
![9stumMa](https://user-images.githubusercontent.com/112992643/207207656-803fdc24-ae44-4088-a2d3-9ec71e8e6414.jpeg)

#ladybug 

## 1. Joining the Data 

Inorder to create analysis we needed to join the lady bug data by the scan ladybug. This is needed to use logical relationships between different tables to get data from those different tables. 
 
 
## 2. Cleaning Data 
 
 The data was cleaned first by renaming each species into a common one. Then the identifer and collector names had been written in different formats and like the species these had to be collected into a common one. after doing so we saw that there was no use of na vales so, we just dropped them using drop_na function. 
 
## 3. vizualization 

#species count by identifier

To establish who correctly identified the most and least species, the identification count was required. doing so, for example: we found out Jack Hughs identifeed Harmonia Axyiridis the most.

![Rplot](https://user-images.githubusercontent.com/112992643/207180467-fc8edac2-40b0-471f-af64-59c3cb1523c6.png)

## 1.Species by count

For the second vizulaization in lady bug we did count by species, The Area count was required. Doing so, for example: we found out Harmonia Axyiridis was there most in for Industrial .

<img width="1440" alt="Screen Shot 2022-12-12 at 12 20 28 AM" src="https://user-images.githubusercontent.com/112992643/207182571-9a83115b-2e22-4886-be92-a52a77f784b8.png">

## 2. Plot genus by month


For the third plot we did genus by count and showing how mant times it occured in a month. we drew certain conclusions from doig this analysis. for example Genus Adalia was mostly found during the end of the year which shows it's found mostly on colder months. 
<img width="1440" alt="Screen Shot 2022-12-12 at 7 30 55 PM" src="https://user-images.githubusercontent.com/112992643/207205720-7fc71719-321a-41b1-9ca8-2275599807de.png">



 # 1.Cabbage Butterfly 
 
![maxresdefault](https://user-images.githubusercontent.com/112992643/207225952-2a462e91-ba82-4179-87c8-a7651051db58.jpeg)


## Join Data 
 
 Inorder to create analysis we needed to join the cleaned data by the uncleaned data 
 
 ## 1.Cleaning the Data
 
 Before joining the Data we had to rename each column to meake it easier for us the read and also join the files. The Date column was a character and this neede to be changed into a date format. The sex column containing male and female had to be changed to a common format. same was done for Country (specifically the United States ). after doing do we selected all the necessary variables needed to condcu our analysis. Then we had to drop the NA values.
 
 then we changed the year value from charachter to numeric.  
 

## Finding Average of the length,width,apex and anterior

By adding the Left wing length with the right wing and dividing it by two, we found AverageWingLength. We did the same for the width, anterior and apex



# Plotting the average by Year using sex as factor  

## Average length

We conducted an analysis using the average we found. we did the average wing length by year(every 10 years) doing so we found out the female average winglegth lowest and highest point were in the 1960s. and for the male 1940s was the highest while 1970s had the lowest averge.  

<img width="1440" alt="Screen Shot 2022-12-12 at 10 56 10 AM" src="https://user-images.githubusercontent.com/112992643/207186445-14097524-3fb4-4ee0-b72e-c7b9940723a4.png">

##  Width

We conducted an analysis using the average we found. we did the average wing width by year(every 10 years) doing so we found out the female average winglegth lowest point was during the 1960s  and highest point was around the same time. and for the male 1940s was the highest and lowest averge. 

<img width="1440" alt="Screen Shot 2022-12-12 at 10 56 41 AM" src="https://user-images.githubusercontent.com/112992643/207187849-e4a4afbb-10e4-46ea-abae-3574cf550358.png">

## Apex

we condcuted a box plot for the average apex area of the insects. we did the average apex area by year(every 10 years). for the male the highest value lied above 20 average apex area while the female was in the range 0-5 while the lowest for both sex was zero. but most of the data lied between 5 and 15. 

<img width="1440" alt="Screen Shot 2022-12-12 at 10 57 20 AM" src="https://user-images.githubusercontent.com/112992643/207191127-6c4f926b-2a7a-4db3-aea8-160465ae09a4.png">

then we arranged all three graphs together

# Effect of country on the Average Length, Width and Apex 
Canada has the largest wing length and width, but the smallest Apex area, of all the nations. while the Republic of Ireland had the highest average apex area Length.

![image](https://user-images.githubusercontent.com/112992643/207200652-7ce6e38e-c478-471d-a007-be5a906c7143.png)

## 1.Map-making plot

conducting analysis using country three countiress were used. United states, United KIngdom and Republic Of Ireland. Then we used one specific Country to conduct where most of the inssects were found. The purpose of this diagram displays the distribution of butterflies on a world and US map according to sex.


<img width="1440" alt="Screen Shot 2022-12-12 at 2 06 52 AM" src="https://user-images.githubusercontent.com/112992643/207192884-4c889a65-3a74-4f04-bec2-ee21ce4e28fb.png">

The majority of the insects were then found in one particular country, where we conducted our research, which was the USA.

<img width="1440" alt="Screen Shot 2022-12-12 at 2 34 48 AM" src="https://user-images.githubusercontent.com/112992643/207192955-e21783a7-6eae-44f4-a5a1-edc6d8a361f1.png">

## concluding: 

That the the female insects are mostly located in the West coast and most of the male insects are located in the East coast.  














 









 




