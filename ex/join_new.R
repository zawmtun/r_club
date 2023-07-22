library(tidyverse)

band_members
band_instruments
band_instruments2

band_members |> inner_join(band_instruments)
band_members |> left_join(band_instruments)
band_members |> right_join(band_instruments)
band_members |> full_join(band_instruments)

band_members |> left_join(band_instruments, by = join_by(name))


semi_join(band_members, band_instruments, by = join_by(name))
anti_join(band_members, band_instruments, by = join_by(name))

band_members |> semi_join(band_instruments, by = join_by(name))
band_members |> filter(name %in% band_instruments$name)

band_members |> anti_join(band_instruments, by = join_by(name))
band_members |> filter(!name %in% band_instruments$name)

band_members |> inner_join(band_instruments2,
                           by = join_by(name == artist),
                           keep = TRUE)


df1 <- tibble(x = 1:3)
df2 <- tibble(x = c(1, 1, 2), y = c("first", "second", "third"))
df1 %>% left_join(df2, join_by(x))

df1 |> distinct(x) |> nrow()
df1 |> nrow()
df2 |> distinct(x) |> nrow()
df2 |> nrow()

df2_new <- df2 |> 
  group_by(x) |> 
  slice(1) |> 
  ungroup()

df2_new <- df2 |> 
  group_by(x) |> 
  slice(n()) |> 
  ungroup()

df1 |> left_join(df2_new, join_by(x))

df3 <- tibble(x = c(1, 1, 1, 3))
df2
df3 %>% left_join(df2, join_by(x))
df3 %>% left_join(df2, join_by(x), relationship = "many-to-many")
df3 %>% left_join(df2, join_by(x), relationship = "one-to-many")

df1 %>% left_join(df2, join_by(x > x))

df1 <- data.frame(x = c(1, NA), y = 2)
df2 <- data.frame(x = c(1, NA), z = 3)
left_join(df1, df2, na_matches = "never")
