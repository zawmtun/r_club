library(tidyverse)

# Construct an example data
# Systolic blood pressure of everyone in village A. (n = 1000)
set.seed(111)
dat <- data.frame(serno = 1:1e3,
                  sbp = rnorm(1e4, 120, 25)) |> 
  mutate(
    hypertension = if_else(sbp >= 140, "Hypertensive", "Normotensive")
  )

hist(dat$sbp)

ht <- dat |>
  count(hypertension = sbp >= 140) |> 
  mutate(prop = n/sum(n))

ht

ggplot(dat, aes(x = hypertension, y = after_stat(count)/sum(after_stat(count)), fill = hypertension)) +
  geom_bar(show.legend = FALSE) +
  scale_y_continuous(limits = c(0, 1), labels = scales::label_percent()) +
  labs(title = "Prevalence of hypertension in village A.",
       x = "Percentage", y = NULL)


# Let's draw a random sample
dat_samp <- sample_n(dat, 100)

dat_samp |>
  count(hypertension) |> 
  mutate(prop = n/sum(n))

# Construct my own functions
# Standard error

get_se <- function(p, n) {
  sqrt(p*(1-p)/n)
}

get_se(0.23, 100)

get_95ci <- function(p, n) {
  ll <- p - 1.96 * get_se(p = p, n = n)
  ul <- p + 1.96 * get_se(p = p, n = n)
  c(ll, ul)
}

ci <- get_95ci(0.23, 100) |> round(2)
cat(0.23, "(95% CI:", ci[1], ",", ci[2], ")")

# CI using prop.test()
ht_prop <- table(dat_samp$hypertension)
ht_prop
prop.test(ht_prop)




# Construct sampling distribution
get_ht_prev_sample <- function(data, n) {
  dat <- sample_n(data, n)
  ht_prev <- table(dat$hypertension) |> prop.table()
  ht_prev["Hypertensive"] |> unname()
}

get_ht_prev_sample(dat, 100)
dat_rep <- replicate(3000, get_ht_prev_sample(dat, 100))


data.frame(dat_rep) |> 
  ggplot(aes(x = dat_rep)) +
  geom_histogram(bins = 30)
