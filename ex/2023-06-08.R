library(tidyverse)

us_states <- data.frame(
  abb = state.abb,
  name = state.name
)


v <- c(1, 2, 3)
v == 2

dat1 <- us_states |> 
  filter(str_detect(name, "^O"))
  
dat2 <- us_states |> 
  mutate(
    nn = str_detect(name, "nn")
  )

dat2

dat3 <- us_states |> 
  filter(
    str_to_lower(name) |> 
      str_detect("i")
  )

dat3

