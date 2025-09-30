library(tidyverse)

#TB data preloaded in R, same data in different forms
?table1
table1 

table2

table3

table4a
table4b

#only table1 is in tidy format

table1 |> 
  mutate(rate = cases/population*10000)

table1 |> 
  group_by(year) |> 
  summarize(total = sum(cases))


table1 |> 
  ggplot(mapping = aes(x = year, y = cases)) +
  geom_line()

#Exercise: compute rate for table2 and table 4a and table 4b
#couldn't do it. very hard to do when not formatted in tidy format!

#reshaping the data into tidy format

table2
table4a
table4b

#use pivot_longer() - fix: single variable across multiple columns
table4a_tidy <- table4a |> 
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")


table4b_tidy <- table4b |> 
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "population")


#use pivot_wider() - fix: single observations across multiple rows

table2 |> 
  pivot_wider(names_from = type, values_from = count)


#use separate() to deal with multiple variables per cell
table3

table3 |> 
  separate(rate, into = c("cases", "population"), sep = "/", convert = TRUE)

table5 <-  table3 |> 
  separate(year, into = c("century", "year"), sep = 2)

#bring columns back together

table5 |> 
  unite(fullyear, century, year, sep = "")


#Is the data in tidy format?

head(coronavirus)



# Notes: Tidy Data cont. 9/30/25 ------------------------------------------


#Tidy data set rules 
#1 each variable forms a column
#2 each observation forms a row
#3 each cell is a single measurement

#pivot wider to spread to new variables
#pivot longer to pull data into consolidated columns


coronavirus <- read_csv('https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv')
library(tidyverse)   
head(coronavirus)


coronavirus |> 
  filter(country == "US", cases >= 0) |> 
  ggplot() +
  geom_line(aes(x = date, y=cases, color = type))


#separate out confirmed-death-recovered
coronawide <- coronavirus |> 
  pivot_wider(names_from = type, values_from = cases)

#very hard to plot in wide format! would have to overlay 3 layers
coronawide |> 
  filter(country == "US", confirmed >= 0, death >= 0, recovery >= 0) |> 
  ggplot() +
  geom_line(aes(x = date, color ))


#plot death count vs confirmed cases by country 
coronavirus_ttd <- coronavirus |> 
  group_by(country, type) |>
  summarize(total_cases = sum(cases)) |>
  pivot_wider(names_from = type, values_from = total_cases)

# Now we can plot this easily
ggplot(coronavirus_ttd) +
  geom_label(mapping = aes(x = confirmed, y = death, label = country))



