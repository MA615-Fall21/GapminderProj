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
jn$Region <- jn$country
jn$Region <- plyr::mapvalues(jn$Region, from=c("Albania","Argentina","Armenia","Burkina Faso","Bangladesh","Bulgaria","Bosnia and Herzegovina","Belarus","Bolivia","Brazil","Chile","China","Cote d'Ivoire","Cameroon","Colombia","Costa Rica","Cyprus","Dominican Republic","Ecuador","Egypt","Spain","Estonia","Ethiopia","Georgia","Greece","Honduras","Croatia","Hungary","Indonesia","India","Iran","Italy","Jamaica","Jordan","Kazakhstan","Kyrgyz Republic","Liberia","Sri Lanka","Lithuania","Latvia","Moldova","Mexico","North Macedonia","Mali","Mongolia","Mauritania","Malawi","Niger","Nigeria","Nicaragua","Pakistan","Panama","Peru","Philippines","Poland","Portugal","Paraguay","Palestine","Romania","Russia","Rwanda","Sierra Leone","El Salvador","Slovenia","Eswatini","Chad","Togo","Thailand","Timor-Leste","Tunisia","Turkey","Uganda","Ukraine","Uruguay","Uzbekistan","Venezuela","South Africa","Zambia","Zimbabwe"), 
                 to=c("Europe","South America","Asia","Africa","Asia","Europe","Europe","Europe","South America","South America","South America","Asia","Africa","Africa","South America","Caribbean and Central America","Middle East","Caribbean and Central America","South America","Africa","Europe","Europe","Africa","Europe","Europe","Caribbean and Central America","Europe","Europe","Asia","Asia","Middle East","Europe","Caribbean and Central America","Middle East","Asia","Asia","Africa","Asia","Europe","Europe","Europe","North America","Europe","Africa","Asia","Africa","Africa","Africa","Africa","Caribbean and Central America","Middle East","Caribbean and Central America","South America","Asia","Europe","Europe","South America","Middle East","Europe","Asia","Africa","Africa","Caribbean and Central America","Europe","Africa","Africa","Africa","Asia","Asia","Africa","Middle East","Africa","Europe","South America","Asia","South America","Africa","Africa","Africa"))
#write.csv(unique(jn$country),'uniquecountries.csv')

