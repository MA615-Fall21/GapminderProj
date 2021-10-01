# Create a ggplot visualization of this data.  What you display and how you 
# choose to do so is up to you.  But you should be thinking about telling a 
# story that  you see in your data.  Your visualization code should be written
# as a function ( that takes a tibble as an input and returns the ggplot 
# visualization ).  This should be saved in an .R script named something like, 
# “visualization_function.R”

install.packages("esquisse")
library(esquisse)

temp <- inner_join(une_gather,lit_gather)
#esquisser(data = temp, viewer = "browser")


ggplot(all) +
  aes(x = mean_pov, y = mean_lit) +
  geom_point(shape = "circle", size = 1.5, colour = "#112446") +
  theme_minimal()