library(tidyverse)

# Systolic blood pressure of everyone in village A. (n = 1000)
set.seed(111)
dat <- data.frame(serno = 1:1e3,
                  sbp = rnorm(1e3, 120, 25)) |> 
  mutate(
    hypertension = if_else(sbp >= 140, "HT", "Non-HT")
  )

ggplot(dat, aes(x = sbp)) +
  geom_histogram(binwidth = 10) +
  labs(title = "Systolic blood pressure of village A")

ggplot(dat, aes(x = hypertension, y = ..count../sum(..count..))) +
  geom_bar() +
  scale_y_continuous(limits = c(0, 1), labels = scales::label_percent()) +
  labs(title = "Prevalence of hypertension in village A.",
       x = "Percentage", y = NULL)

ht <- dat |>
  count(hypertension = sbp >= 140) |> 
  mutate(prop = n/sum(n))

# Let's say we don't know the true proportion and want to estimate it from a sample.
# Select a random sample of 150 people
dat_samp <- dat |> 
  sample_n(150)

hist(dat_samp$sbp)

dat_samp |>
  count(hypertension) |> 
  mutate(prop = n/sum(n)) |> 
  filter(hypertension == "HT") |> 
  pull(prop)

# Repeat the sampling process 500 times

# First create a function to do the sampling
get_ht_prev_sample <- function(data, n) {
  data |> 
    sample_n(n) |> 
    count(hypertension) |> 
    mutate(prop = n/sum(n)) |> 
    filter(hypertension == "HT") |> 
    pull(prop)
}

get_ht_prev_sample(dat, 150)

ht_prev <- replicate(200, get_ht_prev_sample(dat, 150))
quantile(ht_prev, probs = c(0.025,  0.975))

ggplot(dat_ht_prev_samp, aes(x = ht_prev)) +
  geom_histogram(bins = 10)

# Estimate standard deviation

ss <- seq(10, 1000, 10)





get_ci <- function(data, var) {
  
}







