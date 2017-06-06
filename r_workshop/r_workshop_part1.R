# Project: R Workshop, Part I
# Author: Davit Sargsyan
# Created: 06/04/2017
#*****************************************************
# RStudio IDE Layout----
# 1. Cone pane
# 2. Console pane
# 3. Enviromnent/History/Git
# 4. Files/Plots/Help/Packages/Viewer

# RStudio Menu---
# Go through each item

# RStudio Shortcuts----
# Ctrl+Enter = run code chunk
# Ctrl+C = copy
# Ctrl+ X = cut
# Ctrl+V = paste
# ?<function_name> = help file
# Ctrl+Space = autofill drop-down; follow by Tab for selected

# R operators
# +, -, *, /
# ^ power, e.g. 10^2 = 100
# =, <-, -> assign
# == test for equality, 
# != not equal
# ? help
# & and
# | or

# Basic functions
?class
?require
?exp
?log
?table
?rnorm
?runif
?plot
?order

#*****************************************************
# R Objects----
# (Almost) everything in R is an object
# Basic data structures
## a. Data point----
x <- 4
class(x)
typeof(x)

x <- "ABC"
class(x)
typeof(x)

## b. Vector----
x <- 1:10
x
class(x)
typeof(x)
dim(x)

x <- c(3, 6, 10)
x

y <- rep("A", 10)
y

# Classes
# Character
y <- rep(c("A", "B"), each = 5)
y

# Factor
y <- factor(y)
y
levels(y)

# Numeric
y <- as.numeric(y)
y

# Boolean
y <- y == 1
y
sum(y)
table(y)

# Sequences
1:100

seq(from = 1, to = 10, by = 0.1)

x <- c("A", "B", "C")
seq_along(x)

# Access an element of a vector with '[...]'
x[2]

## c. Matix----
x <- matrix(1:12, ncol = 4, byrow = TRUE)
x

matrix(1:12, ncol = 4, byrow = FALSE)

dim(x)

# Access a row
x[2, ]

# Access a column
x[, 4]

# Access an element
x[2, 3]

# Access multiple elements, i.e. subset 
x[c(1, 3), c(2, 4)]

rownames(x) <- LETTERS[1:nrow(x)]
x

colnames(x) <- letters[1:ncol(x)]
x

dimnames(x)
names(dimnames(x)) <- c("My Rows", "My Columns")
x

# Multidimentional arrays
x <- array(1:60, 
           dim = c(3, 4, 5),
           dimnames = list(dim1 = letters[1:3],
                           dim2 = letters[4:7],
                           dim3 = letters[8:12]))
x

x[2, 3, 1]

# NOTE: all elements of matrices and arrays must be of the same type 

## d. List----
x <- list(a = c(1:10),
          b = LETTERS[1:20],
          c = seq(1, 5, 0.1))
x

class(x$a)
class(x$b)
class(x$c)

# Access an element of a list
x$b[3]
x$a[3:5]

# Data frame
n.col <- 10
x <- data.frame(a = c(1:n.col),
                b = LETTERS[1:n.col],
                c = seq(1, 
                        5, 
                        length.out = n.col))
x

# Matrix-like access
x[4, 2]

# List-like access
x$a
x$b[1:4]

## e. Data table
require(data.table)

n.col <- 1000
x <- data.table(a = c(1:n.col),
                b = rep(LETTERS[1:10], 100),
                c = seq(1, 
                        5, 
                        length.out = n.col))
x
class(x)

#*****************************************************
# Data editing----
# Change the value of an element
x[1, 1]
x[1, 1] <- 100
x

# Add a new column
x$d <- 0
x

# Delete a column
x$b <- NULL
x

# Matematical operations
x$c <- x$c*10
x

x$c <- x$c - 20
x

x$e <- (x$a + x$c)/100
x

# Search
x$b <- rep(LETTERS[1:10], 100)
x$b == "A"

x[x$b == "A"]

x$c[x$b == "A" & x$a == 100]

# Subset data table
subset(x, 
       b = "A",
       select = c("a", "b"))

# Search vector in vector
x[x$a %in% c(2, 4, 5), ]

# Save data
# 1. As an R object
save(x, file = "tmp/x.RData")

# 2. Save CSV
write.csv(x, file = "tmp/x.csv")

# 3. Read CSV
read.csv("tmp/x.csv")
read.table("tmp/x.csv", sep = ",")
fread("tmp/x.csv")

# Read Excel
require(xlsx)
read.xlsx("tmp/x.xlsx",
          sheetIndex = 1,
          rowIndex = 1:10,
          colIndex = 1:3,
          header = TRUE)