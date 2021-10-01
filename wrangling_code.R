#The “data_wrangling_function.R” script uses:
# dplyr joins of some sort, #tidyr commands

#install.packages("tidyr")
library(tidyr)
library(dplyr)
library(stringr)


#IMPORT DATA
lit_rate <- read.csv("literacy_rate_adult_total_percent_of_people_ages_15_and_above.csv",fileEncoding = "UTF-8-BOM")
pov_per <- read.csv("poverty_percent_people_below_550_a_day.csv",fileEncoding = "UTF-8-BOM")

#PROCESS LITERACY RATES
#MAKE TIDY
lit_gather <- (lit_rate %>% pivot_longer(cols=c('X1974':'X2010'), 
                                         values_to = "lit_rate", 
                                         values_drop_na = TRUE)) 
lit_gather$year <- as.numeric(str_sub(lit_gather$name, start = 2, end = 5))
lit_gather <- select(lit_gather, -name)

#CREATE DECADE VARIABLE AND GROUP
lit_gather$decade <- as.factor(lit_gather$year - lit_gather$year %% 10)
lit_dec <- lit_gather %>%
  group_by(decade, country) %>%
  summarise(mean_lit=(mean(lit_rate)))


#PROCESS POVERTY DATA
#MAKE TIDY
pov_gather <- (pov_per %>% pivot_longer(cols=c('X1966':'X2018'),
                                       values_to = "pov_rate", 
                                       values_drop_na = TRUE))  

pov_gather$year <- as.numeric(str_sub(pov_gather$name, start = 2, end = 5))
pov_gather<- select(pov_gather, -name)   

#CREATE DECADE VARIABLE AND GROUP
pov_gather$decade <-as.factor(pov_gather$year - pov_gather$year %% 10)

pov_dec <- pov_gather %>%
    group_by(decade, country) %>%
    summarise(mean_pov=(mean(pov_rate)))

rm("lit_rate")
rm("pov_per")

jn <- inner_join(lit_gather,pov_gather)

