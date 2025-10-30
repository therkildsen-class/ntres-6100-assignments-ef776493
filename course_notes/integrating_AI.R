install.packages("chattr")
library(chattr)

#look on course notes to see pathways for connecting AI help to code

library(tidyverse)

view(mtcars)
mtcars_6cyl <- mtcars |> 
  filter(cyl == 6) 
View(mtcars_6cyl)

