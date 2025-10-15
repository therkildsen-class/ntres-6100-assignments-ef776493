library(tidyverse)
library(gapminder) #install.packages("gapminder")
library(gridExtra) #install.packages("gridExtra")

# Intro factors -----------------------------------------------------------

#making a character vector of different month names
x1 <- c("Dec", "Apr", "Jan", "Mar")
x2 <- c("Dec", "Apr", "Jam", "Mar")

sort(x1)

month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)

y1 <- factor(x1, levels = month_levels) #force override of alphabetical sorting by being explict about order level 
sort(y1)

y2 <- factor(x2, levels = month_levels) #will NA "jam" because doesn't match


# Factors in plotting -----------------------------------------------------

gapminder

str(gapminder$continent)
levels(gapminder$continent)
nlevels(gapminder$continent)


gapminder |> 
  count(continent)


nlevels(gapminder$country)

h_countries <- c("Egypt", "Haiti", "Romania", "Thailand", "Venezuela")

h_gap <- gapminder |> 
  filter(country %in% h_countries)

h_gap |> 
  count(country) #check that it's just these 5 countries 

nlevels((h_gap$country)) 


h_gap_dropped <- h_gap |> 
  droplevels() #drops all unused levels

nlevels(h_gap_dropped$country)

h_gap$country |> 
  fct_drop() #only retains levels used in the factor

#exercise: filter to rows where pop is less than 250K, get rid of unused levels using droplevels() and fct_drop() inside mutate()
pop_lt250K <- gapminder |> 
  filter(pop < 250000) |> 
  droplevels() #remove unused factors

#can drop with mutate too
pop_lt250K <- gapminder |> 
  filter(pop < 250000) |> 
  mutate(country = fct_drop(country)) #remove unused factors

pop_lt250K |> 
  count(country)

nlevels(pop_lt250K$country)


levels(gapminder$continent)

gapminder |> 
  count(continent)

gapminder$continent |> 
  fct_infreq() |> 
  fct_rev() |> 
  levels()

p1 <- gapminder |> 
  ggplot(aes(x = continent)) +
  geom_bar() + 
  coord_flip() #flip names 
p1

p2 <- p1 <- gapminder |> 
  ggplot(aes(x = fct_infreq(continent))) +
  geom_bar() + 
  coord_flip() 
p2


gap_asia_2007 <- gapminder |> 
  filter(year == 2007, continent == "Asia")

gap_asia_2007 |> 
  ggplot(aes(x = lifeExp, y = country)) +
  geom_point()

gap_asia_2007 |> 
  ggplot(aes(x = lifeExp, y = fct_reorder(country, lifeExp))) + # can make sense of the data now that it got reordered
  geom_point()





  
