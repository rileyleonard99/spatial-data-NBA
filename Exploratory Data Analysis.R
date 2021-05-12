### Exploratory Data Analysis

## Packages
library(tidyverse)
library(sp)
library(raster)

## Load Data
lillard <- read_csv( "/home/leonardr/Spatial Data NBA/Data/lillard.csv")

data <- read_csv( "/home/leonardr/Spatial Data NBA/Data/shot_data.csv")

# Limited to 50,000 observations (pull by date range and rbind!)


## Player Summary Data

summary_data <- data %>%
  group_by(name) %>%
  summarize(avg_dist = mean(shot_distance),
            avg_dribbles = mean(dribbles),
            avg_touch_time = mean(touch_time),
            avg_defender = mean(defender_distance),
            fg = sum(shot_made_flag == 1),
            fga = (sum(shot_made_flag == 0)) + sum(shot_made_flag == 1),
            pct = fg/fga)

summary_data <- summary_data %>%
  filter(fga >= 100)


## Recode Variables

data <- data %>%
  filter(shot_distance < 47) %>%
  mutate(shot_outcome = as_factor(shot_made_flag))

lillard <- lillard %>%
  filter(shot_distance < 47) %>%
  mutate(shot_outcome = as_factor(shot_made_flag))


## Scatterplots

# Distance vs. Outcome

ggplot(data,
       aes(x = shot_distance,
           y = shot_outcome)) +
  geom_jitter(alpha = 0.1, aes(color = shot_outcome)) +
  labs(x = "Shot Distance (ft)",
       y = "Shot Outcome") +
  scale_color_manual(name = " ", 
                     labels = c("Miss", "Make"), 
                     values = c("0" = "palevioletred2", "1" = "deepskyblue")) + 
  theme_classic()

cor(data$shot_distance,
    data$shot_made_flag)


# Average Distance vs. FG %

ggplot(summary_data,
       aes(x = avg_dist,
           y = pct)) +
  geom_point(size = 2, alpha = 0.5, color = "darkorange") +
  labs(x = "Average Shot Distance (ft)",
       y = "Field Goal %") +
  theme_classic()

cor(summary_data$avg_dist,
    summary_data$pct)

# Average Dribbles vs. FG %

ggplot(summary_data,
       aes(x = avg_dribbles,
           y = pct)) +
  geom_point(size = 2, alpha = 0.5, color = "darkorange") +
  labs(x = "Average Dribbles",
       y = "Field Goal %") +
  theme_classic()

cor(summary_data$avg_dribbles,
    summary_data$pct)


## Shot Chart Example (Lillard)

ggplot(lillard,
       aes(x = x,
           y = y)) +
  geom_jitter(alpha = 0.5, aes(color = shot_outcome)) +
  scale_color_manual(name = " ", 
                     labels = c("Miss", "Make"), 
                     values = c("0" = "palevioletred2", "1" = "deepskyblue")) + 
  theme_classic()


## Shot Chart Raster (Lillard)

lillard_pts <- lillard %>%
  dplyr::select(x, y, shot_distance, dribbles, touch_time, defender_distance, shot_made_flag)

lillard_short <- lillard %>%
  dplyr::select(shot_distance, dribbles, touch_time, defender_distance, shot_made_flag)

pts <- SpatialPoints(c(lillard_pts[ ,1], lillard_pts[ ,2]))

spLillard <- SpatialPointsDataFrame(pts, data = lillard_short)

r <- raster(spLillard)
res(r) <- 5
f <- rasterize(spLillard, r)
plot(f)


## Heat Map (Lillard)

r2 <- raster(spLillard)
res(r2) <- 20
f2 <- rasterize(spLillard, r2)
heat <- rasterize(spLillard, f2, fun = 'count', background = 0)
plot(heat)
plot(spLillard, add = TRUE)


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

# Logistic regression to calculate expected FG%

# Measure FG% versus expFG%

# spFG% = FG% * spatial modifier