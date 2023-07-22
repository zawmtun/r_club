library(tidyverse)

# Example data ----
# Built-in datasets
data()

# Build using constants
grocery <- data.frame(
  item = c("apple", "peach", "kai lan", "grape", "brocoli"),
  type = c("fruit", "fruit", "vege", "fruit", "vege"),
  qty = c(3, 4, 2, 2, 3)
)

grocery

grocery |> count(type)

# dput()
dat <- mtcars |> 
  select(mpg, cyl, hp) |> 
  head(3)

dat

dput(dat)

# Simulation
(x <- rbinom(n = 20, size = 1, prob = 0.3))
table(x)

set.seed(30)
(x <- rbinom(n = 20, size = 1, prob = 0.3))
table(x)

set.seed(30)
(x <- rnorm(n = 20, mean = 0, sd = 1))
hist(x)

# More simulation
library(epiR)
library(dplyr)

make_data <- function() {
  n <- 100
  A <- rbinom(n, 1, 0.3)
  B <- rbinom(n, 1, 0.2)
  X <- rbinom(n, 1, 0.1 + 0.4*A)
  rcase <- rbinom(n, 1, 0.1 + 0.2*X + 0.1*A + 0.2*B)
  
  dat <- data.frame(rcase, A, B, X)
  
  return(dat)
}

dat <- make_data() |> 
  mutate(across(A:X, factor, labels = c("No", "Yes")),
         rcase = factor(rcase, labels = c("Non-case", "Case")))

head(dat)

(tab <- dat |> select(X, rcase) |> table())
epi.2by2(tab, method = "cohort.count")

# Reprex demonstration ----

# Example 1
grocery <- data.frame(
  item = c("apple", "peach", "kai lan", "grape", "brocoli"),
  type = c("fruit", "fruit", "vege", "fruit", "vege"),
  qty = c(3, 4, 2, 2, 3)
)

grocery

grocery |> count(type)

# Example 2
library(dplyr)
grocery <- data.frame(
  item = c("apple", "peach", "kai lan", "grape", "brocoli"),
  type = c("fruit", "fruit", "vege", "fruit", "vege"),
  qty = c(3, 4, 2, 2, 3)
)

grocery

grocery |> count(type)


# Example 2
library(ggplot2)
diamonds |> 
  ggplot(aes(carat, price, colour = cut)) +
  geom_point(alpha = 0.4) +
  theme_minimal()
