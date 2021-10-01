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
# une_gather <- (une_perr %>% pivot_longer(cols=c('X1989':'X2016'), 
#                                          values_to = "une_rate", 
#                                          values_drop_na = TRUE)) 
# une_gather$year <- as.numeric(str_sub(une_gather$name, start = 2, end = 5))
# une_gather <- select(une_gather, -name)
# 
# #CREATE DECADE VARIABLE AND GROUP
# une_gather$decade <- as.factor(une_gather$year - une_gather$year %% 10)
# une_dec <- une_gather %>%
#   group_by(decade, country) %>%
#   summarise(mean_une=(mean(une_rate)))


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

#rm("pov_tbl"); rm("lit_tbl")

jn <- inner_join(lit_gather,pov_gather)
jn_dec <- inner_join(lit_dec,pov_dec)
jn_dec$decade2 <- jn_dec$decade
jn_tbl <- data.frame(table(jn_dec$country))
jn_countries <- jn_tbl[jn_tbl$Freq>=3,"Var1"]

jn <- jn[jn$country %in% jn_countries,]
jn_dec <- jn_dec[jn_dec$country %in% jn_countries,] %>% 
        pivot_wider(
          names_from = decade,
          names_prefix = "lit_",
          values_from = mean_lit) %>% 
        pivot_wider(
           names_from = decade2,
           names_prefix = "pov_",
           values_from = mean_pov) %>%
        group_by(country) 



#rm("jn_tbl")
#rm("jn_countries")
