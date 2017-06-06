# Project: R Workshop, Part I
# Author: Davit Sargsyan
# Created: 06/04/2017
#*****************************************************
# Basic plots----
# R knows how to plot objects of each class
x <- rnorm(10)
x
plot(x)

# Change parameters
plot(x,
     col = "red",
     pch = 16)
# etc.
?plot

# Plotting two vectors agains each other
y <- runif(10)
y
plot(y ~ x,
     pch = 16)

# Plot a data table
dt1 <- data.table(y, x)
dt1
plot(dt1)

# Against a factor
dt1$z <- factor(rep(1:2, 5))
dt1
plot(dt1$y ~ dt1$z)
points(dt1$y ~ dt1$z)

dt1 <- dt1[order(dt1$x)]
plot(dt1$y ~ dt1$x)
lines(dt1$y ~ dt1$x)

# Plot all variables pairwise
plot(dt1)

# Example: cars----
?cars
data("cars")
cars
plot(cars)

# Linear model
m1 <- lm(dist ~ speed, 
         data = cars)
m1
summary(m1)
anova(m1)
fitted(m1)
resid(m1)

# Residuals
plot(m1)

# Fitted line
plot(cars)
abline(m1)

class(m1)
names(m1)
m1$coefficients

speed1 <- seq(0, 100, 1)
pr1 <- predict(m1, 
               newdata = list(speed = speed1))
plot(pr1 ~ speed1, type = "l")
points(cars)

# Example; brain vs. body weight
data("Animals", package = "MASS")
?Animals
Animals
plot(Animals)
plot(log(Animals))
text(rownames(Animals),
     x = log(Animals$body),
     y = log(Animals$brain))

# Example: diamonds----
require(ggplot2)
data("diamonds")
diamonds

# Example: Davit's MTS data----
require(data.table)
dt1 <- fread("r_workshop/example_mts.csv")
dt1

dt2 <- subset(dt1,
              Dose != 0)
dt2

plot(dt2$Readout ~ log(dt2$Dose),
     col = as.numeric(factor(dt2$Treatment)),
     pch = 16)

# Linear models