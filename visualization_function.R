# Create a ggplot visualization of this data.  What you display and how you 
# choose to do so is up to you.  But you should be thinking about telling a 
# story that  you see in your data.  Your visualization code should be written
# as a function ( that takes a tibble as an input and returns the ggplot 
# visualization ).  This should be saved in an .R script named something like, 
# “visualization_function.R”

library(esquisse)
library(plotly)
library(tidyverse)
library(gridExtra)

#esquisser(data = pov_gather, viewer = "browser")

rates_violin <- function(data){
    ggplot(data, aes(x = decade, y = lit_rate)) +
    geom_violin(fill = "#112446") +
    labs(
      x = "Decade",
      y = "Literacy Rate",
      title = "Figure 1: Density of Literacy Rates by Decade",
      caption = "Source: UNESCO Institute of Statistics (UIS) through www.gapminder.org",
    ) +
    theme_minimal()
}

rates_scatter <- function(data){
  
  plt <-  ggplot(jn) +
    aes(x = lit_rate, y = pov_rate, colour = Region,
        text = paste(
          "Country: ", country, "\n",
          "Year: ", year, "\n",
          "Literacy Rate: ", lit_rate, "\n",
          "Poverty Rate: ", pov_rate, "\n",
          sep = ""
        )) +
    geom_point(shape = "circle", size = 2, alpha = 0.85) +
    scale_color_brewer(palette = "Dark2", direction = 1) +
    labs(
      x = "Literacy Rate",
      y = "Poverty Rate",
      title = "Figure 2: Literacy Rate vs Poverty Rate",
      caption = "Source: World Bank, Development Research Group and UNESCO Institute of Statistics (UIS) through www.gapminder.org",)+
    theme_minimal()
  
    ggplotly(plt,tooltip = "text")
}



boxes <- function(new){
    ggplot(new, aes(x=Region,y=value, fill=variable))+
    geom_boxplot() + 
                  labs(x = "Region",
                       y = "Rate",
                       title="Figure 3: Literacy Rate and Poverty by Region",
                       caption = "Source: World Bank, Development Research Group and UNESCO Institute of Statistics (UIS) through www.gapminder.org") +
      scale_fill_discrete(name = "Rate", labels = c("Literacy", "Poverty")) 
}
