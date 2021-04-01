### Exploratory Data Analysis

## Packages
library(tidyverse)

## Load Data
lillard <- read_csv( "/home/leonardr/Spatial Data NBA/Data/lillard.csv")

## Scatterplots

# Distance vs. FG %

# Defender distance vs. FG %

# Dribbles vs. FG %

# Dummy variable for 3-pt FGA

# Dummy for action type (e.g. layup)

## Shot Charts (introducing x and y!)

# Each covariate (distance, defender distance, dribbles, shot clock, touch time) as raster over space 

# How do x and y (location) affect relationships between predictors and response (FG %)

## Inference

# Perform MLR

# Perform GWR

# Cross validation!

# Using coefficient estimates to develop formula for spFG%

# Performing inference on specific teams players

# Creating model for expected points

# Residuals as value over expected!

# Risk as mean variance in expected points!