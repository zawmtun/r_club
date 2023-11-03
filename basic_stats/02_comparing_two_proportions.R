# Example 1: Clinical trial for advanced breast cancer
x <- c(CMF = 49, LPAM = 18)
n <- c(CMF = 93, LPAM = 91)
prop.test(x, n)

x <- c(49, 18)
n <- c(93, 91)
prop.test(x = x, n = n)

# Yates' continuity correction for correcting either the expected successes or failures is < 5
prop.test(x = x, n = n, correct = TRUE)
prop.test(x = x, n = n, correct = FALSE)

# Example 2: Clinical trial for MI patients
x <- c(Anturane = 32, Placebo = 44)
n <- c(Anturane = 775, Placebo = 783)
prop.test(x = x, n = n, correct = FALSE)

# Exercise: Women aged 19-24
x <- c(vegetarian = 1429, non_vegetarian = 3011)
n <- c(vegetarian = 4893, non_vegetarian = 11031)
prop.test(x = x, n = n, correct = FALSE)







# Practice 1: Peppermint ease pain?
x <- c(peppermint = 13, no_pappermint = 6)
n <- c(peppermint = 19, no_pappermint = 23)
prop.test(x = x, n = n, correct = FALSE)

# Practice 2: Mild hypertension treatment
# (a) Deaths
x <- c(diuretics = 134, placebo = 315)
n <- c(diuretics = 1081, placebo = 2213)
prop.test(x = x, n = n, correct = FALSE)

# (b) Strokes
x <- c(bb = 45, placebo = 134)
n <- c(bb = 1081, placebo = 2213)
prop.test(x = x, n = n, correct = FALSE)

# (c) Active treatment
death <- c(tx = 134 + 167, placebo = 315)
coronary <- c(tx = 48 + 80, placebo = 159)
stroke <- c(tx = 45 + 56, placebo = 134)
n <- c(tx = 1081 + 1102, placebo = 2213)

prop.test(x = death, n = n, correct = FALSE)
prop.test(x = coronary, n = n, correct = FALSE)
prop.test(x = stroke, n = n, correct = FALSE)
