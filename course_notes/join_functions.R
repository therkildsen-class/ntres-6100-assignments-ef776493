library(tidyverse)
library(nycflights13) #install.packages("nycflights13")


# Row-binding -------------------------------------------------------------


#LOTR datasets


fship <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Fellowship_Of_The_Ring.csv")

ttow <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Two_Towers.csv")

rking <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Return_Of_The_King.csv")

#combining 3 data sets
lotr <- bind_rows(fship, ttow, rking)
lotr

fship_no_female <- fship |> 
  select(-Female)

bind_rows(fship_no_female, ttow, rking) #lets us bind even though one dataset is missing a column

#bind_rows will work even if variable names are in a different order, will put NA if there is anything missing 

#dont bind columns! not robust. bind rows 


# Join functions ----------------------------------------------------------

#mutating joins - add new variables from matching observations in another
#filtering joins 

#primary key: uniquely identifies each observation

#install.packages
library(nycflights13) #install.packages("nycflights13")

flights
View(flights)

airlines #carrier variable as "foreign key" into flights dataset 
airports
planes

planes |> 
  count(tailnum) |>  #check that there is only 1 of each to ensure it's a unique identifier
  filter(n > 1) #since there is 0, we're good to go 

planes |> 
  count(year) 

weather
View(weather) #try to figure out the unique identifier

weather |> 
  count(time_hour) #cn't do alone, 3 airports with same stamp

weather |> 
  count(time_hour, origin) |>  #use two columns to create a unique key 
  filter(n > 1)

#check for missing data for any of the keys

planes |> 
  filter(is.na(tailnum)) #check for NA in tail number, getting no output meaning every row has data 

flights2 <- flights |> 
  select(year: day, hour, origin, dest, tailnum, carrier)
flights2

flights2 |> 
  left_join(airlines) #default behavior: matches values with any matching column names

flights2 |> 
  left_join(weather)

#let's add some info about planes

flights2 |> 
  left_join(planes) |> #doesn't work, year column means two different things!
  head()

flights2 |> 
  left_join(planes, join_by(tailnum)) # solves the problem, by not two different year variables (now year.x and year.y)

flights2 |> 
  left_join(planes, join_by(tailnum), suffix = c("_flight", "_planes")) #tells it suffix for double year variable


flights2
airports

flights2 |> 
  left_join(airports, join_by(origin == faa))

airports2 <- airports |> 
  select(faa, name, lat, lon)

flights2 |> 
  left_join(airports2, join_by(orgin == faa)) |> 
  left_join(airports2, join_by(dest == faa), suffix = c("_origin", "_dest"))



# 10/7/25: Understanding joins --------------------------------------------

#in most cases, stick to left join 


#semi-join - "sanity check" 
airports |> 
  semi_join(flights2, join_by(faa == origin)) #semi join works as a filtering function, keeps records that match 

#anti-join
flights2 |> 
  anti_join(airports, join_by(dest == faa)) |>
  distinct(dest) # keeps records that don't match airports dataframe

#exercise: flights with planes > 100 flights
planes_gt100 <- flights2 |> 
  group_by(tailnum) |> 
  summarize(count = n()) |> 
  filter(count > 100)

#OR - shortcut

planes_gt100 <- flights2 |> 
  count(tailnum) |> 
  filter(n > 100)

flights |> 
  semi_join(planes_gt100)








