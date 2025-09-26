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

         