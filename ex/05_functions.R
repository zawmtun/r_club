library(conflicted)
library(tidyverse)
library(patchwork)

df <- tibble::tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

df |> class()

df$a <- (df$a - min(df$a, na.rm = TRUE)) / 
  (max(df$a, na.rm = TRUE) - min(df$a, na.rm = TRUE))

df$b <- (df$b - min(df$b, na.rm = TRUE)) / 
  (max(df$b, na.rm = TRUE) - min(df$a, na.rm = TRUE))

df$c <- (df$c - min(df$c, na.rm = TRUE)) / 
  (max(df$c, na.rm = TRUE) - min(df$c, na.rm = TRUE))

df$d <- (df$d - min(df$d, na.rm = TRUE)) / 
  (max(df$d, na.rm = TRUE) - min(df$d, na.rm = TRUE))

df

# Use range()

df <- tibble::tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

df$a
rng <- range(df$a, na.rm = TRUE)
rng[1]
rng[2]

df$a1 <- (df$a - rng[1]) / (rng[2] - rng[1])
df$a1

# Write a function using range()

rescale01 <- function(x) {
  rng <- range(x, na.rm = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}

rescale01(c(0, 5, 10))

# Check function with different inputs

rescale01(c(-10, 0, 10))
rescale01(c(1, 2, 3, NA, 5))


df$a2 <- rescale01(df$a)


# Simpler functions

add_one <- function(x) {
  x + 1
}

add_one(10)
add_one(-10)

add_nums <- function(x, y) {
  x + y
}

1 + 2
add_nums(1, 2)

# Simplify the original example

df <- tibble::tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

df$a <- rescale01(df$a)
df$b <- rescale01(df$b)
df$c <- rescale01(df$c)
df$d <- rescale01(df$d)
df

# dplyr version

df1 <- df |> 
  mutate(
    a = rescale01(a),
    b = rescale01(b),
    c = rescale01(c),
    d = rescale01(d)
  )

# Change the function

x <- c(1:10, Inf)
rescale01(x)
range(x, na.rm = TRUE)
range(x, na.rm = TRUE, finite = TRUE)


rescale_new <- function(x) {
  # To rescale variables for statistical modeling
  rng <- range(x, na.rm = TRUE, finite = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}

rescale_new(x)

# Naming functions

# Too short
f()

# Not a verb, or descriptive
my_awesome_function()

# Long, but clear
impute_missing()
collapse_years()


# Never do this!
col_mins <- function(x, y) {} # snake_case name
rowMaxes <- function(y, x) {} # camelCase name

# If you have a family of functions that do similar things, make sure they have
# consistent names and arguments. Use a common prefix to indicate that they are
# connected. That’s better than a common suffix because autocomplete allows you
# to type the prefix and see all the members of the family.

# Good
input_select()
input_checkbox()
input_text()

# Not so good
select_input()
checkbox_input()
text_input()

# Where possible, avoid overriding existing functions and variables.
# Don't do this!
T <- FALSE
c <- 10
mean <- function(x) sum(x)

# Use comments, lines starting with #, to explain the “why” of your code. You
# generally should avoid comments that explain the “what” or the “how”. If you
# can’t understand what the code does from reading it, you should think about
# how to rewrite it to be more clear.

check_prefix <- function(string, prefix) {
  substr(string, 1, nchar(prefix)) == prefix
}


remove_last <- function(x) {
  if (length(x) <= 1) return(NULL)
  x[-length(x)]
}

remove_last(c(1, 2, 3))

repeat_value <- function(x, y) {
  rep(y, length.out = length(x))
}

num <- c(-1, 443, 39487, 5)
f3(num, 999)



mtcars

ggplot(mtcars, aes(y = factor(vs))) +
  geom_bar()

ggplot(mtcars, aes(y = factor(gear))) +
  geom_bar()

draw_bar_chart <- function(data, var) {
  ggplot(data, aes(y = factor({{var}}))) +
    geom_bar() +
    theme_bw()
}

draw_bar_chart(mtcars, vs) /
  draw_bar_chart(mtcars, gear) /
  draw_bar_chart(mtcars, carb)


