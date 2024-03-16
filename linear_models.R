library(tidyverse)

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

# Q: Adapt the above code to create a new dataframe (pn_learn) that computes the
# averages (mean_acc, mean_RT) for the first session only, regardless of
# learning time. You will want to use the filter() function. Make sure to keep
# in the ID and vocab data!


pn_learn <- pn_long |> 
  filter(session == 1) |> 
  summarise(
    mean_acc = mean(acc, na.rm = TRUE),
    mean_RT = mean(RT, na.rm = TRUE),
    .by = c(ID, vocab, sleep_wake)
  )
  
  

