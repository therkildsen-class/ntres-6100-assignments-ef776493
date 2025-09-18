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

select(coronavirus, contains('o')) #also "ends with" and "reorder" "rename" other similar commands to filter/subset

select(coronavirus, contains('y'), everything()) #first just rows that contain y, then everything else

#FILTER & SUBSET
coronavirus_us <- filter(coronavirus, country == "US") #keyboard shortcut for <- : option/-
coronavirus_us2 <- select(coronavirus_us, -lat, -long, -province)

#introducing pipe operator. shortcut for |> = command/shift/m
filter(coronavirus, country == "US")

coronavirus |>
  filter(country == "US") |>
  select(-lat, -long, -province)

coronavirus |> filter(country == "US") |> select(-lat, -long, -province)

#without the pipe we have to start nesting functions within themselves. Pipe is very useful!

#Exercise in piping, variable names don't need quotes

coronavirus |>
  filter(type == "death", country %in% c("US", "Canada","Mexico")) |>
         select(country, date, cases) |> 
  ggplot() +
  geom_line(mapping = aes(x = date, y = cases, color = country))
  

# Vaccine data ----------------------------------------------------------
vacc <- read_csv("https://raw.githubusercontent.com/RamiKrispin/coronavirus/main/csv/covid19_vaccine.csv")
View(vacc)

max(vacc$date)

#MUTATE to create new variable, assign it name and then what you want it to be

vacc |>
  filter(date == max(date)) |> 
  select(country_region, continent_name, people_at_least_one_dose, population) |> 
  mutate(vaxxrate = round(people_at_least_one_dose / population, 2))

#Exercise 2

#select function nice for viewing, but not needed for plotting

vacc |>
  filter(date == max(date)) |> 
  select(country_region, continent_name, people_at_least_one_dose, population, doses_admin) |>
  mutate(avgdose = doses_admin/ people_at_least_one_dose) |> 
  ggplot() +
  geom_histogram(mapping = aes(x = avgdose))

#plot countries more than 2 million doses
vacc |>
  filter(date == max(date), doses_admin > 200 * 10^6) |> 
  select(country_region, continent_name, people_at_least_one_dose, population, doses_admin) |>
  mutate(avgdose = doses_admin/ people_at_least_one_dose) |> 

  
#plot countries more than 2 million doses + avg dose > 3
vacc |>
  filter(date == max(date), doses_admin > 200 * 10^6) |> 
  select(country_region, continent_name, people_at_least_one_dose, population, doses_admin) |>
  mutate(avgdose = doses_admin/ people_at_least_one_dose) |> 
  filter(avgdose > 3)

#pipe into arrange function to sort it 
vacc |>
  filter(date == max(date)) |> 
  select(country_region, continent_name, people_at_least_one_dose, population, doses_admin) |>
  mutate(avgdose = doses_admin/ people_at_least_one_dose) |> 
  filter(avgdose > 3) |> 
  arrange(-avgdose)

#Exercise 3
vacc |>
  filter(date == max(date)) |> 
  select(country_region, continent_name, people_at_least_one_dose, population) |> 
  mutate(vaxxrate = people_at_least_one_dose / population) |> 
  filter(vaxxrate > 0.9) |> 
  arrange(-vaxxrate) |> 
  head(5)



# Summarize --------------------------------------------------------------


  

