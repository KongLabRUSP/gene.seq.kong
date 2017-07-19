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
     col = c("red", "blue", "green"),
     pch = 1:length(x),
     xlab = "My X Values",
     ylab = "My Y values",
     main = "My Title")
# etc.
?plot
abline(h = 0,
       lty = 2)

abline(a = -1,
       b = 0.1,
       lty = 2,
       col = "blue")
text(labels = "ABCD",
     x = 5,
     y = 0)

# Plotting two vectors agains each other
y <- runif(10)
y
plot(y ~ x,
     pch = 16,
     xlim = c(-0.5, 1))

# Plot subsets of data
plot(y[c(3, 6:9)] ~ x[c(3, 6:9)])
plot(y[x > -0.5 & x < 1] ~ x[x > -0.5 & x < 1])
plot(y[x < -0.5 | x > 1] ~ x[x < -0.5 | x > 1])

# Plot a data frame
df1 <- data.frame(x, y)
df1
plot(df1)

# Against a factor
df1$z <- factor(rep(1:2, 5))
df1
plot(df1$y ~ df1$z)
points(df1$y ~ jitter(as.numeric(df1$z)),
       col = "blue",
       pch = 16)

dt1 <- dt1[order(dt1$x)]
plot(df1$y ~ df1$x)
lines(dt1$y ~ dt1$x)

# Plot all variables pairwise
plot(df1)

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
m1$coefficients[2]

speed1 <- seq(0, 100, 1)
speed1
pr1 <- predict(m1, 
               newdata = list(speed = speed1))
pr1
plot(pr1 ~ speed1, type = "l")
points(cars)

# Example; brain vs. body weight
data("Animals", package = "MASS")
?Animals
Animals
plot(Animals)
plot(log10(Animals))
text(rownames(Animals),
     x = log10(Animals$body),
     y = log10(Animals$brain))

dd <- data.frame(l.body = log10(Animals$body),
                 l.brain = log10(Animals$brain))
dd
plot(dd)
dd$name <- rownames(Animals)

m2 <- lm(l.brain ~ l.body, data = dd)
summary(m2)
abline(m2, lty = 2, col = "blue")

dt2 <- dd[!(dd$name %in% c("Triceratops",
                         "Brachiosaurus",
                         "Dipliodocus")), ]
m3 <- lm(l.brain ~ l.body, data = dt2)
summary(m3)

plot(dd$l.brain ~ dd$l.body)
abline(m2, col = "red", lty = 2)
abline(m3, col = "blue", lty = 3)
text(labels = dd$name,
     x = dd$l.body,
     y = dd$l.brain)

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