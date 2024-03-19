library(tidyverse)
library(collapse)

pn_long <- read_csv("https://raw.githubusercontent.com/emljames/YSJ_R_workshop/master/data/AMPM_subset.csv")

pn_id <- pn_long |> 
  summarise(
    mean_acc = mean(acc, na.rm = TRUE),
    mean_RT = mean(RT, na.rm = TRUE),
    .by = c(ID, vocab, sleep_wake, session)
  )

pn_wide <- pn_id |> 
  pivot_wider(names_from = session,
              values_from = c(mean_acc, mean_RT)) |> 
  mutate(
    change_acc = mean_acc_2 - mean_acc_1,
    change_RT = mean_RT_2 - mean_RT_1
  )

# Exercises ----
# Q: Adapt the above code to create a new dataframe (pn_learn) that computes the
# averages (mean_acc, mean_RT) for the first session only, regardless of
# learning time. You will want to use the filter() function. Make sure to keep
# in the ID and vocab data!

pn_learn <- pn_long |> 
  filter(session == 1) |> 
  summarise(
    mean_acc = mean(acc, na.rm = TRUE),
    mean_RT = mean(RT, na.rm = TRUE),
    .by = c(ID, vocab)
  )
  
# Q: Use the pn_id dataframe to work out the mean performance in each combination
# of conditions (sleep vs. wake, session 1 vs. 2).

pn_id |> 
  summarise(
    across(starts_with("mean"),
           list(overall = \(x) mean(x, na.rm = TRUE)))
  )

# Q: Use either your pn_id or pn_learn dataframe to work out some descriptive
# statistics for the first test session (regardless of sleep_wake condition).
# What was the mean number of pictures named? What was the standard deviation?

pn_learn |> 
  descr(cols = c("mean_acc", "mean_RT"))

lm_learn_acc <- lm(mean_acc ~ vocab, data = pn_learn)
summary(lm_learn_acc)
plot(lm_learn_acc)

ggplot(pn_learn, aes(x = vocab, y = mean_acc)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

plot(lm_learn_acc)

# Fit a similar model, lm_learn_RT to examine the relationship between vocabulary ability and response time:
# (a) Are children with better vocabulary quicker to name the pictures at the first test point?
# (b) How much of the variance in response time is accounted for by vocabulary ability?
# (c) What do you notice about the residuals for this model?

lm_learn_RT <- lm(mean_RT ~ vocab, data = pn_learn)
summary(lm_learn_RT)
plot(lm_learn_RT$residuals)
abline(h = 0, col = "red")

hist(lm_learn_RT$residuals)

pn_learn <- pn_learn |> 
  mutate(vocab_s = scale(vocab, center = TRUE, scale = TRUE))

pn_learn_1 <- pn_learn |> 
  mutate(vocab_s = (vocab - mean(vocab, na.rm = TRUE)) / sd(vocab, na.rm = TRUE))

lm_learn_acc_s <- lm(mean_acc ~ vocab_s, data = pn_learn)
summary(lm_learn_acc_s)

summary(lm_learn_acc)

pn_wide <- pn_wide |> 
  mutate(sleep_wake = factor(sleep_wake))

contrasts(pn_wide$sleep_wake)

pn_wide <- pn_wide |> 
  mutate(sleep_wake = fct_relevel(sleep_wake, "wake"))

contrasts(pn_wide$sleep_wake)

lm_acc_conds <- lm(change_acc ~ sleep_wake, data = pn_wide)
summary(lm_acc_conds)

contrasts(pn_wide$sleep_wake) <- c(-1, 1)
contrasts(pn_wide$sleep_wake)

lm_acc_conds_sc <- lm(change_acc ~ sleep_wake, data = pn_wide)
summary(lm_acc_conds_sc)
