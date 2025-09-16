library(tidyverse)

mpg
?mpg
##set up in a tibble
#very helpful because only prints first 10 rows
#tells you type of variable


?cars
cars
#set up in dataframe, simpler, prints a lot

View(mpg)
#can scroll up and down, see all the data, scroll and see differernt columns
#one of very new things in R that is capalized
#DO NOT USE IN QUARTO DOC


head(cars)
#first 6 lines

head(cars,4)
tail(cars)

##in ggplot get in the habit of putting every new layer on a new line (it auto-indents)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))



#Exercise 2

ggplot(data = mpg)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x=cyl, y=hwy))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class, size = cyl))
##two more parameters and lots more info added!

#change to open circle points - be outside parenthesis when it applies to all data points equally
#google shape and see what the different characteristics/options are 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class, size = cyl), shape = 1)

?geom_point


#Exercise 3
ggplot(data = mpg) + 
  geom_point(mapping = aes(x=cyl, y=hwy, color = year))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x=cyl, y=hwy), color = "blue")


#add trendline with geom_smooth 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x=displ, y=hwy, color = class, size = cyl), shape = 1) +
  geom_smooth(mapping = aes(x = displ, y = hwy))


#make x and y variables at top layer to avoid needing to repeat them 
ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) + 
  geom_point(mapping = aes(color = class, size = cyl), shape = 1) +
  geom_smooth()

#add another layer: facet wrap - so powerful to seperate out variables like year
ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) + 
  geom_point(mapping = aes(color = class, size = cyl), shape = 1) +
  geom_smooth() + 
  facet_wrap(~ year, nrow = 2)

ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) + 
  geom_point(mapping = aes(color = class, size = cyl), shape = 1) +
  geom_smooth() + 
  facet_wrap(~ class)

#changing theme
ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) + 
  geom_point(mapping = aes(color = class, size = cyl), shape = 1) +
  geom_smooth() + 
  facet_wrap(~ year, nrow = 2) +
  theme_minimal()

#SAVE FIGURES WITH CODE using ggsave
#default uses last plot you made to save 
# if you put things in order with default, don't need argument such as "filename = "
#call out name in argument once you get used to it
?ggsave
ggsave(filename = "plots/hwy_vs_displ.png")

ggsave(filename = "plots/hwy_vs_displ.jpeg")

ggsave(filename = "plots/hwy_vs_displ.pdf")


#change dimensions 
ggsave(filename = "plots/hwy_vs_displ.pdf", width = 8, height = 4)

#save as object 
plot1 <- ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) + 
  geom_point(mapping = aes(color = class, size = cyl), shape = 1) +
  geom_smooth() + 
  facet_wrap(~ year, nrow = 2) +
  theme_minimal()
plot1

ggsave(filename = "plots/hwy_vs_displ.pdf", plot = plot1)


