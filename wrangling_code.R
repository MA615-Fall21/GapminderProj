#The “data_wrangling_function.R” script uses:
# dplyr joins of some sort, #tidyr commands

#install.packages("tidyr")
library(tidyr)
library(dplyr)
library(stringr)
library(reshape2)

#IMPORT DATA
lit_rate <- read.csv("literacy_rate_adult_total_percent_of_people_ages_15_and_above.csv",fileEncoding = "UTF-8-BOM")
#write.csv(unique(lit_rate$country),'uniquecountries.csv')
from <- c("Aruba","Afghanistan","Angola","Anguilla","Albania","Netherlands Antilles","United Arab Emirates","Argentina","Armenia","Antigua and Barbuda","Azerbaijan","Burundi","Benin","Burkina Faso","Bangladesh","Bulgaria","Bahrain","Bosnia and Herzegovina","Belarus","Belize","Bolivia","Brazil","Brunei","Bhutan","Botswana","Central African Republic","Chile","China","Cote d'Ivoire","Cameroon","Congo, Dem. Rep.","Colombia","Comoros","Cape Verde","Costa Rica","Cuba","Cayman Islands","Cyprus","Dominican Republic","Algeria","Ecuador","Egypt","Eritrea","Spain","Estonia","Ethiopia","Gabon","Georgia","Ghana","Guinea","Gambia","Guinea-Bissau","Equatorial Guinea","Greece","Guatemala","Guyana","Honduras","Croatia","Haiti","Hungary","Indonesia","India","Iran","Iraq","Israel","Italy","Jamaica","Jordan","Kazakhstan","Kenya","Kyrgyz Republic","Cambodia","Kuwait","Lao","Lebanon","Liberia","Libya","Sri Lanka","Lesotho","Lithuania","Latvia","Macao, China","Morocco","Moldova","Madagascar","Maldives","Mexico","North Macedonia","Mali","Malta","Myanmar","Montenegro","Mongolia","Mozambique","Mauritania","Mauritius","Malawi","Malaysia","Namibia","Niger","Nigeria","Nicaragua","Nepal","Oman","Pakistan","Panama","Peru","Philippines","Palau","Papua New Guinea","Poland","Puerto Rico","North Korea","Portugal","Paraguay","Palestine","Qatar","Romania","Russia","Rwanda","Saudi Arabia","Sudan","Senegal","Singapore","Sierra Leone","El Salvador","Serbia","Sao Tome and Principe","Suriname","Slovenia","Eswatini","Seychelles","Syria","Chad","Togo","Thailand","Tajikistan","Turkmenistan","Timor-Leste","Tonga","Trinidad and Tobago","Tunisia","Turkey","Tanzania","Uganda","Ukraine","Uruguay","Uzbekistan","Venezuela","Vietnam","Vanuatu","Samoa","Yemen","South Africa","Zambia","Zimbabwe")
to <- c("Caribbean & Central Amer.","Middle East","Africa","Caribbean & Central Amer.","Europe","Caribbean & Central Amer.","Middle East","S. Amer.","Asia","Caribbean & Central Amer.","Asia","Africa","Africa","Africa","Asia","Europe","Middle East","Europe","Europe","Caribbean & Central Amer.","S. Amer.","S. Amer.","Africa","Africa","Africa","Africa","S. Amer.","Asia","S. Amer.","Africa","Africa","S. Amer.","Africa","Africa","Caribbean & Central Amer.","Caribbean & Central Amer.","Caribbean & Central Amer.","Middle East","Caribbean & Central Amer.","Africa","S. Amer.","Africa","Africa","Europe","Europe","Africa","Africa","Asia","Africa","Africa","Africa","S. Amer.","Africa","Europe","Caribbean & Central Amer.","Africa","Caribbean & Central Amer.","Europe","Caribbean & Central Amer.","Europe","Asia","Asia","Middle East","Middle East","Middle East","Europe","Caribbean & Central Amer.","Middle East","Asia","Africa","Asia","Asia","Middle East","Asia","Middle East","Africa","Africa","Asia","Africa","Europe","Europe","Asia","Africa","Europe","Africa","Asia","North America","Europe","Africa","Europe","Asia","Europe","Asia","Africa","Africa","Africa","Africa","Asia","Africa","Africa","Africa","Caribbean & Central Amer.","Asia","Middle East","Middle East","Caribbean & Central Amer.","S. Amer.","Asia","Oceania","Oceania","Europe","Caribbean & Central Amer.","Asia","Europe","S. Amer.","Middle East","Middle East","Europe","Asia","Africa","Africa","Africa","Africa","Asia","Africa","Caribbean & Central Amer.","Europe","Africa","S. Amer.","Europe","Africa","Africa","Middle East","Africa","Africa","Asia","Asia","Asia","Asia","Oceania","Caribbean & Central Amer.","Africa","Middle East","Africa","Africa","Europe","S. Amer.","Asia","S. Amer.","Asia","Oceania","Oceania","Middle East","Africa","Africa","Africa")
lit_rate$Region <- lit_rate$country
lit_rate$Region <- plyr::mapvalues(lit_rate$Region, from = from, to = to)
                                   
pov_per <- read.csv("poverty_percent_people_below_550_a_day.csv",fileEncoding = "UTF-8-BOM")
from <- c("Angola","Albania","United Arab Emirates","Argentina","Armenia","Australia","Austria","Azerbaijan","Burundi","Belgium","Benin","Burkina Faso","Bangladesh","Bulgaria","Bosnia and Herzegovina","Belarus","Belize","Bolivia","Brazil","Bhutan","Botswana","Central African Republic","Canada","Switzerland","Chile","China","Cote d'Ivoire","Cameroon","Congo, Dem. Rep.","Congo, Rep.","Colombia","Comoros","Cape Verde","Costa Rica","Cyprus","Czech Republic","Germany","Djibouti","Denmark","Dominican Republic","Algeria","Ecuador","Egypt","Spain","Estonia","Ethiopia","Finland","Fiji","France","Micronesia, Fed. Sts.","Gabon","United Kingdom","Georgia","Ghana","Guinea","Gambia","Guinea-Bissau","Greece","Guatemala","Guyana","Honduras","Croatia","Haiti","Hungary","Indonesia","India","Ireland","Iran","Iraq","Iceland","Israel","Italy","Jamaica","Jordan","Japan","Kazakhstan","Kenya","Kyrgyz Republic","Kiribati","South Korea","Kosovo","Lao","Lebanon","Liberia","St. Lucia","Sri Lanka","Lesotho","Lithuania","Luxembourg","Latvia","Morocco","Moldova","Madagascar","Maldives","Mexico","North Macedonia","Mali","Malta","Myanmar","Montenegro","Mongolia","Mozambique","Mauritania","Mauritius","Malawi","Malaysia","Namibia","Niger","Nigeria","Nicaragua","Netherlands","Norway","Nepal","Nauru","Pakistan","Panama","Peru","Philippines","Papua New Guinea","Poland","Portugal","Paraguay","Palestine","Romania","Russia","Rwanda","Sudan","Senegal","Solomon Islands","Sierra Leone","El Salvador","Somalia","Serbia","South Sudan","Sao Tome and Principe","Suriname","Slovak Republic","Slovenia","Sweden","Eswatini","Seychelles","Syria","Chad","Togo","Thailand","Tajikistan","Turkmenistan","Timor-Leste","Tonga","Trinidad and Tobago","Tunisia","Turkey","Tuvalu","Tanzania","Uganda","Ukraine","Uruguay","United States","Uzbekistan","Venezuela","Vietnam","Vanuatu","Samoa","Yemen","South Africa","Zambia","Zimbabwe")
to <- c("Africa","Europe","Middle East","S. Amer.","Asia","Oceania","Europe","Asia","Africa","Europe","Africa","Africa","Asia","Europe","Europe","Europe","Caribbean & Central Amer.","S. Amer.","S. Amer.","Africa","Africa","Africa","North America","Europe","S. Amer.","Asia","S. Amer.","Africa","Africa","Africa","S. Amer.","Africa","Africa","Caribbean & Central Amer.","Middle East","Europe","Europe","Africa","Europe","Caribbean & Central Amer.","Africa","S. Amer.","Africa","Europe","Europe","Africa","Europe","Oceania","Europe","Oceania","Africa","Europe","Asia","Africa","Africa","Africa","S. Amer.","Europe","Caribbean & Central Amer.","Africa","Caribbean & Central Amer.","Europe","Caribbean & Central Amer.","Europe","Asia","Asia","Europe","Middle East","Middle East","Europe","Middle East","Europe","Caribbean & Central Amer.","Middle East","Asia","Asia","Africa","Asia","Oceania","Asia","Europe","Asia","Middle East","Africa","Caribbean & Central Amer.","Asia","Africa","Europe","Europe","Europe","Africa","Europe","Africa","Asia","North America","Europe","Africa","Europe","Asia","Europe","Asia","Africa","Africa","Africa","Africa","Asia","Africa","Africa","Africa","Caribbean & Central Amer.","Europe","Europe","Asia","Oceania","Middle East","Caribbean & Central Amer.","S. Amer.","Asia","Oceania","Europe","Europe","S. Amer.","Middle East","Europe","Asia","Africa","Africa","Africa","Oceania","Africa","Caribbean & Central Amer.","Africa","Europe","Africa","Africa","S. Amer.","Europe","Europe","Europe","Africa","Africa","Middle East","Africa","Africa","Asia","Asia","Asia","Asia","Oceania","Caribbean & Central Amer.","Africa","Middle East","Oceania","Africa","Africa","Europe","S. Amer.","North America","Asia","S. Amer.","Asia","Oceania","Oceania","Middle East","Africa","Africa","Africa")
pov_per$Region <- pov_per$country
pov_per$Region <- plyr::mapvalues(pov_per$Region, from = from, to = to)


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



#JOIN DATA
jn <- inner_join(lit_gather,pov_gather)

#MAKE LONG DATA

lit_long <- melt(lit_gather)
pov_long <- melt(pov_gather)
new <- rbind(lit_long, pov_long)
new <- new[new$variable != "year",]
unique(new$Region)
new$Region <- factor(new$Region, levels = c("Europe","North America", "Asia",
                                            "S. Amer.","Caribbean & Central Amer.","Oceania","Middle East", "Africa"))
rm("pov_long")
