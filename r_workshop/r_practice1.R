# Project: R Workshop, Practice Problems Batch 1
# Author: Davit Sargsyan
# Created: 06/010/2017
# References: 'r_workshop_part1.R', 'r_workshop_part2.R'

#*****************************************************
# Setup----
# Please save a copy of this file with your initialls 
# ammended (e.g. my file would be 'r_practice1_ds.R').
# and write your code to it. Once fihished, please 
# upload the file to our GitHub repository as following:
# 0. In the upper rght panel, click 'Git' tab
# 1. Update your repository by clicking 'Pull' button 
#    in the upper right panel (blue arrow down)
# 2. Click 'Commit'
# 3. Place a check mark in front of your newly 
#    created file 'r_practice1_xx.R'
# 4. In the 'Commit message' section write:
#    '<YOUR NAME>'s practice1'
# 5. Click 'Commit'
# 6. Close the pop-up window
# 7. Click 'Push' (green arrow up in the upper
#    right corner of the Git window)
# 8. Enter your GitHub ID, then password

#*****************************************************
# Problem1: vectors----
## a. Create a numeric vector of 10 random values

  <code here>

## b. Create a character vector containing names
##    of your top five favorite foods
  
  <code here>

## c. Create a character vector containing names 
##    of your top three favorite movies, each name
##    repeated 10 times. Name your vector 'myfavs'

  <code here>
  
## d. Transform 'myfavs' vector from character to factor. 
  
  <code here>

## e. Subset your vector: keep 2 out of 3 movies
  
  <code here>

# Problem2: matrices----
## a. Create a 4 rows by 6 columns matrix of
##    random normal values. Hint: use function 'rnorm'

  <code here>
  
## b. Remove 3rd column of your matrix
  
  <code here>
  
## c. Multiply all values of your matrix by 10
  
  <code here>
  
## d. Divide 2nd row of your matrix by 5
  <code here>
## e. Print the value from 3rd row and 1st column
  
  <code here>
  
# Problem3: data frames----
## a. Create a data frame with 20 rows the following 4 columns:
##    AnimalID:  a character vector with values 
##               "ID1", "ID2", "ID3", "ID4" and "ID5".
##               Repeat this vector 4 times
##    Day:       Repeat the sequence of 5 "Day1" and 5 "Day2 
##               vectors twice (i.e. so each animal would have 
##               2 records on each day). Make Day variable a factor.
##    Treatment: 2-level factor with repeating 'TrtA' and 'TrtB'
##               values 10 times each (i.e. so each animal has a record 
##               at one of each treatment on each of the 2 days).
##               Hint: use 'each' argument in function 'rep'.
##    Readout:   random uniform values between 0 and 100,
##               rounded to whole numbers
##               (Hint: function 'runif' and 'round')

<code here>
  
## b. Plot readouts vs treatment
  
<code here>
  
## c. Plot readouts vs treatment separate for Day1 and Day2
  
<code here>
  
## d. Color-code the previous plot so that
##    each animal is assigned a unique color
  
<code here>
  
#*****************************************************
# End code----