#read_csv()
#read_csv2()
#read_tsv()
#read_delim()

library(googlesheets4)
library(tidyverse)
library(readxl)
library(janitor) #install.packages("janitor")


# Read in data ------------------------------------------------------------


library(tidyverse)
lotr <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/lotr_tidy.csv")

#save to local file
write_csv(lotr, file = "data/lotr.csv")

#read in from local computer (realtive to where I already am (Github WD)), easiest is to use relative, shorter path 
lotr <- read.csv("data/lotr.csv")
View(lotr)

getwd()
#[1] "/Users/fox/Documents/GitHub/ntres-6100-assignments-ef776493"

lotr <- read.csv("/Users/fox/Documents/GitHub/ntres-6100-assignments-ef776493/data/lotr.csv") 
head(lotr)

#using functions after editing raw data file in text editor
lotr <- read.csv("data/lotr.csv", skip = 1, comment = "#")


#install package to read in excel files
library(readxl) #install.packages("readxl")

#read in from excel, default behavior is to load first tab
lotr_excel <- read_xlsx("data/data_lesson11.xlsx")
head(lotr_excel)

#specify which tab in excel spreadsheet
lotr_excel <- read_xlsx("data/data_lesson11.xlsx", sheet = "FOTR ")
head(lotr_excel)

#load google sheet
#install packages for it
#install.packages("googlesheets4")
#made R restart, load all packages again
library(googlesheets4)
library(tidyverse)
library(readxl)

lotr <- read_sheet("https://docs.google.com/spreadsheets/d/1X98JobRtA3JGBFacs_JSjiX-4DPQ0vZYtNl_ozqF6IE/edit#gid=754443596")

#turn off authorization requirements
gs4_deauth()


#read in specific tab and specific lines in the sheet
lotr_google <- read_sheet("https://docs.google.com/spreadsheets/d/1X98JobRtA3JGBFacs_JSjiX-4DPQ0vZYtNl_ozqF6IE/edit#gid=754443596", sheet = "deaths", range = "A5:F15")



# Standardize variable naming ---------------------------------------------
#janitor package
#snake_case
#SCREAMING_SNAKE_CASE
#camelCase

library(janitor) #install.packages("janitor")

msa <- read_tsv("https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/main/datasets/janitor_mymsa_subset.txt")
View(msa)

msa_clean <- clean_names(msa) #default is snake_case

msa_clean <- clean_names(msa, case = "upper_camel")

#see old and new names side by side
cbind(colnames(msa), colnames(msa_clean))



# Clean up messy data -----------------------------------------------------

parse_number("$100") #removes everything that isn't a number
parse_number("80%")

parse_double("1,23", locale=locale(decimal_mark=",")) #helpful with international conventions
parse_number("123.456.789", locale=locale(grouping_mark = "."))


#can specify parse when reading in data to make sure it gets read in correctly 
#good data set to work on cleaning up messy data using mutate function 
mess = read_tsv("https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/refs/heads/main/datasets/messy_data.tsv", locale = locale(decimal_mark = ","))

problems() #tells where the issues in the data set are


#look up dates and times chapter, very helpful. won't go over in class





