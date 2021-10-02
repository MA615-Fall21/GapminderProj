# Create a ggplot visualization of this data.  What you display and how you 
# choose to do so is up to you.  But you should be thinking about telling a 
# story that  you see in your data.  Your visualization code should be written
# as a function ( that takes a tibble as an input and returns the ggplot 
# visualization ).  This should be saved in an .R script named something like, 
# “visualization_function.R”

#install.packages("esquisse")
library(esquisse)

library(plotly)
library(tidyverse)
#library(htmlwidgets)

#esquisser(data = jn, viewer = "browser")


rates_scatter <- function(data){
  knitr::opts_chunk$set(fig.width = 20,fig.height = 4)
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
      title = "Figure 2: Literacy Rate vs Poverty Rate")+
    theme_minimal()
  
    ggplotly(plt,tooltip = "text")
}

#rates_violin(lit_dec)
rates_violin <- function(data){
  ggplot(data) +
    aes(x = decade, y = lit_rate) +
    geom_violin(adjust = 1L, scale = "area", fill = "#112446") +
    labs(
      x = "Decade",
      y = "Literacy Rate",
      title = "Figure 1: Density of Literacy Rates by Decade"
    ) +
    theme_minimal()
}




