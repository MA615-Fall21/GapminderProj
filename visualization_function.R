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
library(htmlwidgets)

#esquisser(data = lit_dec, viewer = "browser")


rates_scatter <- function(data){
    plt <- ggplot(data) +
      aes(x = lit_rate, y = pov_rate,
          text = paste(
        "Country: ", country, "\n",
        "Year: ", year, "\n",
        "Literacy Rate: ", lit_rate, "\n",
        "Poverty Rate: ", pov_rate, "\n",
        sep = ""
      ),
      fill = decade) +
      geom_point(shape = "circle", size = 1.5, colour = "#112446", stroke = .1, alpha = 0.75) +
      labs(
        x = "Literacy Rate",
        y = "Poverty Rate",
        title = "Literacy Rate vs Poverty Rate"
      ) + 
      scale_fill_brewer(palette = "Greys", direction = 1)+
      theme_minimal()
    ggplotly(plt,tooltip = "text")
}

#rates_violin(lit_dec)
rates_violin <- function(data){
  ggplot(data) +
    aes(x = decade, y = mean_lit) +
    geom_violin(adjust = 1L, scale = "area", fill = "#112446") +
    labs(
      x = "Decade",
      y = "Literacy Rate",
      title = "Density of Literacy Rates by Decade"
    ) +
    theme_minimal()
}




