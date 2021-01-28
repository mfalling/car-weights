# About -------------------------------------------------------------------

# An mtcars plot with `wt` on the Y-Axis and make/model on the X-Axis.
# The numeric `wt` column is converted into a factor ("light", "average", "heavy")
# The X-Axis is sorted in ascending value.

# See blog post for more details: 
# https://maryfalling.wordpress.com/2021/01/27/r-default-parameters-a-ggplot-geom_bar-example/


# Plot Objects ------------------------------------------------------------

# Create cut-off values for car weights.
lowAvg <- mean(mtcars$wt) - sd(mtcars$wt)
highAvg <- mean(mtcars$wt) + sd(mtcars$wt)

# Find the "weight class" based on the mean and standard deviation.
weightClass <- ifelse(test = mtcars$wt < lowAvg, 
       yes = "light",
       no = ifelse(test = mtcars$wt > lowAvg & mtcars$wt < highAvg, 
                   yes = "average", 
                   no = ifelse(test = mtcars$wt >= highAvg, 
                               yes = "heavy",
                               no = NA)))

# Get the make/model of each car.
carNames <- row.names(mtcars)

# Plot --------------------------------------------------------------------

ggplot(mtcars, aes(x = reorder(carNames, wt), 
                   y = wt, 
                   fill = factor(weightClass))) + 
  geom_bar(stat = "identity") + 
  labs(title = "Vehicle Weight",
       x = "Make and Model",
       y = "Weight (in tons)",
       fill = "Weight Class") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90)) +
  scale_fill_manual(breaks = c("light","average","heavy"), 
                    values = c("seagreen", "gold", "firebrick"))
