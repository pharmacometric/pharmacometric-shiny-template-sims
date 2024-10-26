set.seed(number(1))
regimenDT = data.frame(
  Group = rep(LETTERS[1:3],each = 2),
  Dose = sample(seq(10,500,50),6),
  Frequency = sample(1:5,6, replace = T),
  Additional = sample(0:4,6, replace = T),
  Route = rep(sample(c("IV","SC")),3),
  WT = 70,
  stringsAsFactors = FALSE
)
