library(tidyverse)

#When to use
#when you repeat a block of code 3 or more times

# Function template ----------------------------------------------------------------

#function_name <- function(input) {
output_value <-  do_something(inputs)
return(outputs)
}


# Function for volume -----------------------------------------------------

#function to calculate volume, hint: start with a verb
calc_shrub_vol <- function(length, width, height) {
  area <- length * width
  volume <- area * height
  return(volume)
}

calc_shrub_vol(0.8, 1.6, 2.0)

#can also write them out
calc_shrub_vol(length = 0.8, width = 1.6, height = 2.0)

est_shrub_mass <- function(volume) {
  mass <- 2.65 * volume ^ 0.9
  return(mass)
}

shrub_volume <- calc_shrub_vol(0.8, 1.6, 2.0) #putting whole function cll inside the second function 
shrub_mass <- est_shrub_mass(shrub_volume)

#you can use your own functions within tidyverse, make this simpler by doing some piping
calc_shrub_vol(length = 0.8, width = 1.6, height = 2.0) |> 
  est_shrub_mass()

est_shrub_mass_from_raw <- function(length, width, height) {
  volume <- calc_shrub_vol(length, width, height)
  mass <- est_shrub_mass(volume)
  return(mass) #can be done more consisely, wrote this to show that functions can call other functions
}


# Exercise ----------------------------------------------------------------

convert_pounds_to_grams <- function(pounds) {
  grams <- pounds * 453.6
  return(grams)
}

convert_pounds_to_grams(3.75)


# for loop to function  ---------------------------------------------------

library(tidyverse)
library(gapminder)


gapminder <- gapminder |> 
  rename("life_exp" = lifeExp, "gdp_per_cap" = gdpPercap)


est <- read_csv('https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/countries_estimated.csv')
gapminder_est <- gapminder |> 
  left_join(est)


cntry <- "Belgium"
country_list <- c("Albania", "Canada", "Spain")


dir.create("figures")
dir.create("figures/europe")

country_list <- unique(gapminder$country)

gap_europe <- gapminder_est |> 
  filter(continent == "Europe") |> 
  mutate(gdp_tot = gdp_per_cap * pop)

country_list <- unique(gap_europe$country)

length(country_list)

cntry <- "Albania"

print_plot <- function(cntry, stat = "gdp_per_cap", filetype = "pdf") {
  
  print(str_c("Plotting ", cntry))
  
  gap_to_plot <- gap_europe |> 
    filter(country == cntry)
  
  my_plot <- ggplot(data = gap_to_plot, mapping = aes(x = year, y = gdp_tot)) +
    geom_point() +
    labs(title = str_c(cntry, "GDP", sep = " "), 
         subtitle = ifelse(any(gap_to_plot$estimated == "yes"), "Estimated data", "Reported data"), 
         y = stat)
  ggsave(filename = str_c("figures/europe/", cntry, "_", stat, ".", filetype, sep = ""), plot = my_plot)

}

print_plot("Germany", "gdp_per_cap")
  
#change output file type
  
  #ggsave(filename = str_c("figures/europe/", cntry, "_", stat, ".png", sep = ""), plot = my_plot)

library(tidyverse)
library(gapminder)
gapminder <- gapminder |>
  rename("life_exp" = lifeExp, "gdp_per_cap" = gdpPercap)
est <- read_csv('https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/countries_estimated.csv')
gapminder_est <- gapminder |>
  left_join(est)


gap_europe <- gapminder_est |>
  filter(continent == "Europe") |>
  mutate(gdp_tot = gdp_per_cap * pop)

country_list <- unique(gap_europe$country)

