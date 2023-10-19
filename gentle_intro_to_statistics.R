library(palmerpenguins) # dataset
library(tidyverse) # tools for data management and visualisation
library(broom) # tools for extracting model estimates

dat <- read_csv("penguins.csv")

names(dat)
summary(dat)
glimpse(dat)


