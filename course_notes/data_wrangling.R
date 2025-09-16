#best practice: session > restart R
#list packages at top
#load packages

library(tidyverse)
library(skimr) #install.packages("skimr")

#load in data via githib using URL, loads current version every time
#read in data. read_csv creates tibble
coronavirus <- read_csv('https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv')

#explore data / view it
summary(coronavirus)
skim(coronavirus)
view(coronavirus) #prints dataset, not all of it 
head(coronavirus)
tail(coronavirus)

#SUBSET ROWS
#pull out a variable
coronavirus$cases #prints just vector of the cases, but can do differently in tidyverse w/o $
head(coronavirus$cases)

#dplyr: use 5 main functions: filter, 

#keep only non-zero case count rows
#don't need quotes to call out a variable in base R
?filter
filter(coronavirus, cases > 0)

# single = assigns value, == pulls out one thing
filter(coronavirus, country == "US")

#anything not US (!=)
filter(coronavirus, country != "US")

#save as an object
coronavirus_US <- filter(coronavirus, country == "US")

# or statement: from US or Canada
filter(coronavirus, country == "US" | country == "Canada")

#and statement: use (&) or (,)
filter(coronavirus, country == "US" & type == "death")

# shorter way to write either/or : use "included in" operator (%in% v=c())
filter(coronavirus, country %in% c("US", "Canada"))

#Exercise: subset rows
filter(coronavirus, country %in% c("Spain", "Italy", "Portugal") & type == "death" & date == "2021-09-16")

View(count(coronavirus, country))      


#SUBSET COLUMNS
#will output in order we list them 
select(coronavirus, date, country, type, cases)

#do inverse, drop single column
select(coronavirus, -province)

#Exercise
select(coronavirus, country, lat, long)
select(coronavirus, lat, long, country)

select(coronavirus, date:cases)

select(coronavirus, 1:3) #can do this, but more robust to use the names and generally avoid this
