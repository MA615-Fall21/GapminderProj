#The “data_wrangling_function.R” script uses:
# dplyr joins of some sort, #tidyr commands

#install.packages("tidyr")
library(tidyr)
library(dplyr)
library(stringr)


#IMPORT DATA
lit_rate <- read.csv("literacy_rate_adult_total_percent_of_people_ages_15_and_above.csv",fileEncoding = "UTF-8-BOM")
pov_per <- read.csv("poverty_percent_people_below_550_a_day.csv",fileEncoding = "UTF-8-BOM")
une_perr <- read.csv("long_term_unemployment_rate_percent.csv",fileEncoding = "UTF-8-BOM")


#PROCESS LITERACY RATES
#MAKE TIDY
une_gather <- (une_perr %>% pivot_longer(cols=c('X1989':'X2016'), 
                                         values_to = "une_rate", 
                                         values_drop_na = TRUE)) 
une_gather$year <- as.numeric(str_sub(une_gather$name, start = 2, end = 5))
une_gather <- select(une_gather, -name)

#CREATE DECADE VARIABLE AND GROUP
une_gather$decade <- une_gather$year - une_gather$year %% 10
une_dec <- une_gather %>%
  group_by(decade, country) %>%
  summarise(mean_une=(mean(une_rate)))

#SELECT COUNTRIES WITH AT LEAST TWO DECADES OF DATA
une_dup <- une_dec[duplicated(une_dec$country) | duplicated(une_dec$country, fromLast=TRUE), ]


#PROCESS LITERACY RATES
#MAKE TIDY
lit_gather <- (lit_rate %>% pivot_longer(cols=c('X1974':'X2010'), 
                                         values_to = "lit_rate", 
                                         values_drop_na = TRUE)) 
lit_gather$year <- as.numeric(str_sub(lit_gather$name, start = 2, end = 5))
lit_gather <- select(lit_gather, -name)

#CREATE DECADE VARIABLE AND GROUP
lit_gather$decade <- lit_gather$year - lit_gather$year %% 10
lit_dec <- lit_gather %>%
  group_by(decade, country) %>%
  summarise(mean_lit=(mean(lit_rate)))

#SELECT COUNTRIES WITH AT LEAST TWO DECADES OF DATA
lit_dup <- lit_dec[duplicated(lit_dec$country) | duplicated(lit_dec$country, fromLast=TRUE), ]


#PROCESS POVERTY DATA
#MAKE TIDY
pov_gather <- (pov_per %>% pivot_longer(cols=c('X1966':'X2018'),
                                       values_to = "pov_rate", 
                                       values_drop_na = TRUE))  

pov_gather$year <- as.numeric(str_sub(pov_gather$name, start = 2, end = 5))
pov_gather<- select(pov_gather, -name)   

#CREATE DECADE VARIABLE AND GROUP
pov_gather$decade <- pov_gather$year - pov_gather$year %% 10
pov_dec <- pov_gather %>%
    group_by(decade, country) %>%
    summarise(mean_pov=(mean(pov_rate)))

#SELECT COUNTRIES WITH AT LEAST TWO DECADES OF DATA
pov_dup <- pov_dec[duplicated(pov_dec$country) | duplicated(pov_dec$country, fromLast=TRUE), ]

